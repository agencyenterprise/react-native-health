# HealthKit Delta Query — Integration Guide

Covers everything an app needs to read and sync HealthKit data using the delta (anchor-based) system. Includes background sync, proactive pulls, reactive events, start/end date queries, and how anchors work.

---

## What was built

### react-native-health (iOS SDK)

| What | File |
|---|---|
| `defaultHKUnitForType:` — maps type string → default `HKUnit` | `Utils.h/m` |
| `fetchAnchoredSamplesOfType:` — generic anchored query, returns `added + deleted` | `Queries.h/m` |
| `getDeltaSamples` — JS-callable proactive delta fetch | `RCTAppleHealthKit.m` |
| `getDeltaSamplesForPermissions` — parallel multi-type fetch | `index.js` |
| `configureBackgroundSync` — sets sync interval + enabled flag | `RCTAppleHealthKit.m` |
| Observer upgrade — anchor seeding + 24h time gate + `healthKit:<Type>:delta` events | `Queries.m` |
| `Periods` constant | `src/constants/Periods.js` |
| `SyncIntervals` constant | `src/constants/SyncIntervals.js` |
| TypeScript types: `HealthPeriod`, `SyncInterval`, `DeltaQueryResult`, `DeltaQueryOptions`, `BackgroundSyncOptions`, `DeletedSample` | `index.d.ts` |

### mobileapp-core (app abstraction layer)

| What | File |
|---|---|
| `HealthKitProvider.fetchSamples` — anchor path wired to `getDeltaSamples` | `providers/HealthKitProvider.ts` |
| `subscribeHealthDelta` — subscribe to `healthKit:<Type>:delta` events | `healthDeltaObserver.ts` |
| `useHealthDeltaObserver` — React hook wrapping `subscribeHealthDelta` | `healthDeltaObserver.ts` |
| `registerHealthBackgroundSync` — unified enable/disable/configure background sync | `backgroundSync.ts` |

---

## Native setup (one-time, AppDelegate.m)

Background delivery requires a native call at app launch. This is the only line that needs to go in Objective-C:

```objc
// AppDelegate.m — application:didFinishLaunchingWithOptions:
[[RCTAppleHealthKit new] initializeBackgroundObservers:bridge];
```

This registers one `HKObserverQuery` per health type. These observers can wake the app even when it has been killed by the user — HealthKit background delivery is one of the few iOS mechanisms that supports this.

---

## Understanding the anchor

The anchor is an **opaque cursor** into HealthKit's internal change log. Think of it as a bookmark: it marks the position after your last successful query.

```
HealthKit change log for StepCount:
  [...record A added, record B added, record C deleted, record D added...]
                                                        ↑
                                               anchor stored here after last fetch

Next getDeltaSamples call with this anchor:
  → returns { added: [D], deleted: [C] }
  → returns new anchor pointing after D
```

**Properties:**
- Opaque — do not parse or construct it. It is a Base64-encoded `NSKeyedArchiver` blob.
- Per-type — the Steps anchor knows nothing about the HeartRate anchor.
- Persistent — survives app restarts. Store it in AsyncStorage and pass it back.
- Monotonic — each successful call returns an anchor further along the log.

**What it is NOT:**
- Not a date or timestamp
- Not a count or offset you can do arithmetic on
- Not something HealthKit exposes the internals of

**First call (no anchor):** returns all samples matching your date/period window — the full initial load.  
**Subsequent calls (with anchor):** returns only what changed since that anchor — could be zero records if nothing changed.

---

## Fetch modes

Every `getDeltaSamples` call supports four modes depending on which options you pass.

### Mode 1 — Anchor only (delta since last sync)

The primary production mode. Pass the anchor you stored from the previous call.

```ts
AppleHealthKit.getDeltaSamples(
  { type: 'StepCount', unit: 'count', anchor: storedAnchor },
  (err, result) => {
    // result.added   → new step records since storedAnchor
    // result.deleted → UUIDs of deleted records since storedAnchor
    // result.anchor  → store this, pass on next call
  }
)
```

Returns only the diff. If nothing changed since the last anchor, `added` and `deleted` are both empty and a new (advanced) anchor is still returned.

### Mode 2 — Date range

Fetch all samples within an explicit time window. No anchor needed.

```ts
AppleHealthKit.getDeltaSamples(
  {
    type:      'StepCount',
    unit:      'count',
    startDate: '2026-01-01T00:00:00.000Z',
    endDate:   '2026-01-31T23:59:59.999Z',
  },
  (err, { added, deleted, anchor }) => {
    // added contains all step records in January 2026
    // Store anchor if you want to track future changes to this window
  }
)
```

`startDate` and `endDate` are ISO 8601 strings. `endDate` defaults to now if omitted.

### Mode 3 — Period preset

Use a named period instead of explicit dates. Resolved natively on the device.

```ts
import { Periods } from 'react-native-health'

AppleHealthKit.getDeltaSamples(
  { type: 'StepCount', unit: 'count', period: Periods.last7Days },
  (err, { added, anchor }) => { ... }
)
```

Available periods:

| Constant | Window |
|---|---|
| `Periods.last24Hours` | Rolling: now − 24h → now |
| `Periods.today` | Calendar day: midnight → now |
| `Periods.last7Days` | now − 7 days → now |
| `Periods.last30Days` | now − 30 days → now |
| `Periods.last3Months` | now − 3 months → now (calendar-aware) |
| `Periods.last6Months` | now − 6 months → now (calendar-aware) |
| `Periods.lastYear` | now − 1 year → now |

`today` vs `last24Hours`: `today` starts at calendar midnight. `last24Hours` is a rolling 24-hour window.

### Mode 4 — Anchor + period (bounded delta)

Combine both: return only records that changed since the anchor AND fall within the period window. Useful when you want the delta but don't want records older than N days.

```ts
AppleHealthKit.getDeltaSamples(
  {
    type:   'StepCount',
    unit:   'count',
    anchor: storedAnchor,
    period: Periods.last30Days,
  },
  (err, { added, deleted, anchor }) => { ... }
)
```

### Mode 5 — No options (avoid in production)

Omitting anchor, dates, and period returns all HealthKit history for the type. Can return millions of records for long-term users. Only use during development.

---

## Option precedence

When multiple options are passed:

1. `startDate` wins over `period` for the lower date bound
2. `endDate` defaults to now if omitted
3. `anchor` filters the result set down to changes since the cursor
4. `limit` caps the number of returned records (no limit by default)

---

## Parallel multi-type fetch

`getDeltaSamplesForPermissions` fires all types concurrently and returns a keyed map.

```ts
AppleHealthKit.getDeltaSamplesForPermissions(
  [
    { type: 'StepCount',          unit: 'count', anchor: anchors.StepCount },
    { type: 'HeartRate',          unit: 'bpm',   anchor: anchors.HeartRate },
    { type: 'ActiveEnergyBurned',                anchor: anchors.ActiveEnergyBurned },
  ],
  (err, results) => {
    if (err) return

    // Each key matches the type string passed in
    const { added: steps,    deletedIds: deletedSteps    } = results.StepCount
    const { added: hrSamples, deletedIds: deletedHR      } = results.HeartRate
    const { added: energy,   deletedIds: deletedEnergy   } = results.ActiveEnergyBurned

    // Save updated anchors
    anchors.StepCount          = results.StepCount.anchor
    anchors.HeartRate          = results.HeartRate.anchor
    anchors.ActiveEnergyBurned = results.ActiveEnergyBurned.anchor
  }
)
```

The first error from any type short-circuits the callback.

---

## Background sync setup

### Enable / disable

```ts
import { registerHealthBackgroundSync } from '@app/health'

// After health permissions granted — call once at app start
registerHealthBackgroundSync({
  enabled:      true,
  syncInterval: 'every24hours',  // default if omitted
})

// On user logout or permission revoke
registerHealthBackgroundSync({ enabled: false })
```

Available intervals:

| Value | Interval |
|---|---|
| `'every1hour'` | 1 hour |
| `'every6hours'` | 6 hours |
| `'every12hours'` | 12 hours |
| `'every24hours'` | 24 hours (default) |
| `'every48hours'` | 48 hours |
| `'everyweek'` | 7 days |

**Opt-in by default.** The observer is always registered (required for HealthKit background delivery), but it will not fetch or emit events until `enabled: true` is set. If `registerHealthBackgroundSync` is never called, background delta fetches are skipped.

### What happens in the background

1. HealthKit detects new or deleted data for a registered type
2. iOS wakes the app (even if killed by the user)
3. The observer fires for that type
4. **Enabled check:** if `enabled` is false → calls `completionHandler()` and exits immediately
5. **Time gate:** if less than `syncInterval` has passed since the last fetch → exits
6. Fetches delta using the stored anchor for that type
7. Persists the new anchor in `NSUserDefaults`
8. Stamps `lastFetchTime` for the time gate
9. Emits `healthKit:<Type>:delta` event with `{ added, deleted, anchor }`
10. Emits `healthKit:<Type>:new` for backwards compatibility
11. Calls `completionHandler()` — HealthKit stops background delivery if this is ever skipped

### Multiple types in parallel

When HealthKit has changes across 5 types simultaneously, all 5 observers fire in parallel. This is safe because every piece of state (anchor, lastFetchTime) is keyed per-type:

- `RNHealth_DeltaAnchor_StepCount`
- `RNHealth_DeltaAnchor_HeartRate`
- `RNHealth_LastFetch_StepCount`
- `RNHealth_LastFetch_HeartRate`
- `RNHealth_SyncEnabled` ← global (one flag for all types)
- `RNHealth_SyncInterval` ← global (one interval for all types)

No shared mutable state across types — parallel execution is safe.

---

## Reactive mode — listening for background delta events

Subscribe to events pushed by the observer. The app does not need to poll or fetch — data arrives automatically when HealthKit fires.

### Raw SDK level

```ts
import { NativeEventEmitter, NativeModules } from 'react-native'

const emitter = new NativeEventEmitter(NativeModules.AppleHealthKit)

const sub = emitter.addListener(
  'healthKit:StepCount:delta',
  ({ added, deleted, anchor }) => {
    // added:   HealthValue[] — new records since last delivery
    // deleted: { id: string }[] — UUIDs of deleted records
    // anchor:  string — informational; observer manages its own anchor internally
    myStore.applyDelta('StepCount', added, deleted.map(d => d.id))
  }
)

// Cleanup
sub.remove()
```

### mobileapp-core hook

```tsx
import { useHealthDeltaObserver, HealthMetric } from '@app/health'

function StepsTracker() {
  useHealthDeltaObserver(HealthMetric.Steps, (event) => {
    // event.added:   HealthSample[]
    // event.deleted: string[]  ← already unwrapped to UUID strings
    // event.anchor:  string
    dispatch(applyStepsDelta(event.added, event.deleted))
  })

  return <StepsDisplay />
}
```

The hook subscribes on mount and unsubscribes on unmount. Re-subscribes if metric or listener reference changes.

### What the observer guarantees

- **No historical dump on first delivery.** At registration, the observer runs a `limit:0` anchored query to seed the anchor. The first real delivery only contains records added/deleted _after_ registration.
- **Exactly the diff.** Each delivery contains only what changed since the previous delivery.
- **Deletions carry UUID only.** HealthKit permanently discards the original values when a record is deleted. You cannot recover the value — only the UUID.
- **`healthKit:<Type>:new` still fires** alongside `:delta` for backwards compatibility with existing listeners.

---

## Proactive mode — app pulls delta on demand

The app owns the anchor in AsyncStorage. Fetch explicitly and store the result.

### mobileapp-core pattern (recommended)

```tsx
import { useState, useEffect } from 'react'
import AsyncStorage from '@react-native-async-storage/async-storage'
import { useHealthQuery, HealthMetric } from '@app/health'

function useStepsDelta() {
  const [anchor, setAnchor] = useState<string | undefined>()

  // Load stored anchor on mount
  useEffect(() => {
    AsyncStorage.getItem('anchor:Steps')
      .then((stored) => setAnchor(stored ?? undefined))
  }, [])

  const { data, isLoading, error } = useHealthQuery({
    metric: HealthMetric.Steps,
    period: 'last7days',   // fallback window used when no anchor exists yet
    anchor,
  })

  // Persist updated anchor after each successful fetch
  useEffect(() => {
    if (data?.anchor) {
      AsyncStorage.setItem('anchor:Steps', data.anchor)
      setAnchor(data.anchor)
    }
  }, [data?.anchor])

  return {
    samples:    data?.samples    ?? [],
    deletedIds: data?.deletedIds ?? [],
    isLoading,
    error,
  }
}
```

### What happens on each call

| Call | `anchor` in options | What is returned |
|---|---|---|
| First ever | `undefined` | All samples in `period` window (full initial load) |
| Second | anchor from first call | Only records added/deleted since first call |
| Third | anchor from second call | Only records added/deleted since second call |
| Nothing changed | any anchor | `added: []`, `deleted: []`, new (advanced) anchor |

### Raw SDK level

```ts
import AsyncStorage from '@react-native-async-storage/async-storage'
import AppleHealthKit, { Periods } from 'react-native-health'

async function syncSteps() {
  const stored = await AsyncStorage.getItem('anchor:StepCount')

  AppleHealthKit.getDeltaSamples(
    {
      type:   'StepCount',
      unit:   'count',
      anchor: stored ?? undefined,
      period: Periods.last7Days,   // used only when anchor is absent
    },
    async (err, result) => {
      if (err) {
        console.error('getDeltaSamples failed', err)
        return
      }

      // Apply changes to local store
      myStore.add(result.added)
      myStore.remove(result.deleted.map(d => d.id))

      // Always persist the new anchor, even if added/deleted are empty
      await AsyncStorage.setItem('anchor:StepCount', result.anchor)
    }
  )
}
```

---

## Steps + Blood Pressure — complete app example

```tsx
// App.tsx
import { useEffect } from 'react'
import { registerHealthBackgroundSync } from '@app/health'

export default function App() {
  useEffect(() => {
    // Enable after health permissions are confirmed
    registerHealthBackgroundSync({
      enabled:      true,
      syncInterval: 'every24hours',
    })
  }, [])

  return <HealthSyncProvider><AppNavigator /></HealthSyncProvider>
}
```

```tsx
// HealthSyncProvider.tsx — reactive background listener
import { useHealthDeltaObserver, HealthMetric } from '@app/health'
import { useDispatch } from 'react-redux'
import { applyDelta } from './healthSlice'

export function HealthSyncProvider({ children }) {
  const dispatch = useDispatch()

  useHealthDeltaObserver(HealthMetric.Steps, (event) => {
    dispatch(applyDelta({ metric: 'steps', ...event }))
  })

  useHealthDeltaObserver(HealthMetric.BloodPressure, (event) => {
    dispatch(applyDelta({ metric: 'bloodPressure', ...event }))
  })

  return children
}
```

```tsx
// StepsScreen.tsx — proactive pull with anchor
import { useState, useEffect } from 'react'
import AsyncStorage from '@react-native-async-storage/async-storage'
import { useHealthQuery, HealthMetric } from '@app/health'

export function StepsScreen() {
  const [anchor, setAnchor] = useState<string | undefined>()

  useEffect(() => {
    AsyncStorage.getItem('anchor:Steps')
      .then((s) => setAnchor(s ?? undefined))
  }, [])

  const { data, isLoading } = useHealthQuery({
    metric: HealthMetric.Steps,
    period: 'last7days',
    anchor,
  })

  useEffect(() => {
    if (data?.anchor) {
      AsyncStorage.setItem('anchor:Steps', data.anchor)
      setAnchor(data.anchor)
    }
  }, [data?.anchor])

  if (isLoading) return <Loading />

  return (
    <>
      <Text>New records: {data?.samples.length ?? 0}</Text>
      <Text>Deleted:     {data?.deletedIds.length ?? 0}</Text>
      <StepsList samples={data?.samples ?? []} />
    </>
  )
}
```

```tsx
// BloodPressureScreen.tsx
export function BloodPressureScreen() {
  const [anchor, setAnchor] = useState<string | undefined>()

  useEffect(() => {
    AsyncStorage.getItem('anchor:BloodPressure')
      .then((s) => setAnchor(s ?? undefined))
  }, [])

  const { data, isLoading } = useHealthQuery({
    metric: HealthMetric.BloodPressure,
    period: 'last30days',  // wider window for BP — less frequent readings
    anchor,
  })

  useEffect(() => {
    if (data?.anchor) {
      AsyncStorage.setItem('anchor:BloodPressure', data.anchor)
      setAnchor(data.anchor)
    }
  }, [data?.anchor])

  // data.samples → BloodPressureSample[] — each has .systolic and .diastolic
  return <BPChart readings={data?.samples ?? []} />
}
```

---

## What is NOT implemented

| Feature | Why deferred |
|---|---|
| APNs silent push to wake killed app on a guaranteed schedule | Requires backend scheduler — outside SDK scope |
| Android Health Connect + WorkManager | `registerHealthBackgroundSync` Android path is a stub |
| Per-type enable/disable | Global `enabled` flag controls all types — per-type is a future extension |

---

## Key files reference

### react-native-health

| File | Purpose |
|---|---|
| `RCTAppleHealthKit/RCTAppleHealthKit+Utils.m` | `defaultHKUnitForType:` |
| `RCTAppleHealthKit/RCTAppleHealthKit+Queries.m` | `fetchAnchoredSamplesOfType:`, upgraded observer |
| `RCTAppleHealthKit/RCTAppleHealthKit.m` | `getDeltaSamples`, `configureBackgroundSync`, `startDateFromPeriod:` |
| `src/constants/Periods.js` | Period preset strings |
| `src/constants/SyncIntervals.js` | Sync interval strings |
| `index.js` | JS API surface |
| `index.d.ts` | TypeScript types |
| `docs/getDeltaSamples.md` | Per-method API reference |

### mobileapp-core

| File | Purpose |
|---|---|
| `src/health/providers/HealthKitProvider.ts` | Anchor path in `fetchSamples` |
| `src/health/healthDeltaObserver.ts` | `subscribeHealthDelta`, `useHealthDeltaObserver` |
| `src/health/backgroundSync.ts` | `registerHealthBackgroundSync` |
| `src/health/index.ts` | Public exports |
