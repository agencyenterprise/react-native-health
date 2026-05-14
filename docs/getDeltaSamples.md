# getDeltaSamples / getDeltaSamplesForPermissions

Fetch only what changed in HealthKit since your last query — added and deleted records.

## Quick reference

| Options | Behaviour |
|---|---|
| `anchor` | Delta since last sync — **`startDate`/`period` are ignored when `anchor` is present** |
| `anchor` + `period` / `startDate` | **`anchor` wins** — date bounds are silently ignored; a warning is logged on the native side |
| `period: 'last3months'` | All samples in last N period (no anchor) |
| `startDate` / `endDate` | All samples in explicit window (no anchor) |
| (none) | All samples in last 24 hours (default when not anchored) |

> **Anchor vs date precedence:** When `anchor` is provided, HealthKit returns all changes since that checkpoint regardless of any `startDate`/`period`/`endDate` values. Those date parameters are only meaningful for non-anchored scans. Passing both `anchor` and a date bound is a no-op for the date bound — the native layer logs a warning and ignores it.

## Result shape

```ts
{
  anchor:  string          // Store and pass back on next call
  added:   DeltaSample[]   // HealthValue | SleepSample | BloodPressureSample | ClinicalSample — shape depends on `type`
  deleted: { id: string }[] // Deleted sample UUIDs — original data is gone
}
```

> **Shape depends on `type`:** `added` entries are `HealthValue` for most types, `SleepSample` for `SleepAnalysis`, `BloodPressureSample` for `BloodPressure`, and `ClinicalSample` for clinical record types. Accessing `.value` directly will crash or return `undefined` for BloodPressure and Clinical — narrow the type by `options.type` first.

## Proactive mode — fetch on demand

App manages the anchor in AsyncStorage:

```js
import AsyncStorage from '@react-native-async-storage/async-storage'
import AppleHealthKit from 'react-native-health'

async function syncHeartRate() {
  const anchor = await AsyncStorage.getItem('hk_anchor_HeartRate') ?? undefined

  AppleHealthKit.getDeltaSamples(
    { type: 'HeartRate', unit: 'bpm', anchor },
    async (err, { added, deleted, anchor: newAnchor }) => {
      if (err) return
      await AsyncStorage.setItem('hk_anchor_HeartRate', newAnchor)
      localStore.addSamples(added)
      localStore.removeSamples(deleted.map(d => d.id))
    }
  )
}
```

## Periods constant

```js
import { Periods } from 'react-native-health'
// last24hours | today | last7days | last30days | last3months | last6months | lastYear

AppleHealthKit.getDeltaSamples(
  { type: 'HeartRate', unit: 'bpm', period: Periods.last3Months },
  (err, { added, deleted, anchor }) => { /* ... */ }
)
```

## Multi-type fetch

```js
AppleHealthKit.getDeltaSamplesForPermissions(
  [
    { type: 'HeartRate',          unit: 'bpm',   anchor: anchors.HeartRate },
    { type: 'StepCount',          unit: 'count', anchor: anchors.StepCount },
    { type: 'ActiveEnergyBurned',                anchor: anchors.ActiveEnergyBurned },
  ],
  (err, results) => {
    // results.HeartRate          → { added, deleted, anchor }
    // results.StepCount          → { added, deleted, anchor }
    // results.ActiveEnergyBurned → { added, deleted, anchor }
  }
)
```

## Reactive mode — observer events

After calling `setObserver` for each type you want to monitor, HealthKit pushes deltas automatically:

```js
import { NativeModules, NativeEventEmitter } from 'react-native'

const emitter = new NativeEventEmitter(NativeModules.AppleHealthKit)

emitter.addListener('healthKit:HeartRate:delta', ({ added, deleted, anchor }) => {
  // added:   HealthValue[] — new samples since last delivery
  // deleted: { id: string }[] — UUIDs removed since last delivery
  localStore.addSamples('HeartRate', added)
  localStore.removeSamples('HeartRate', deleted.map(d => d.id))
  // anchor is informational here — observer manages its own anchor in NSUserDefaults
})
```

**What the observer guarantees:**
- First delivery only contains data added/deleted **after** observer registration (anchor seeded at setup)
- Each delivery contains only what changed since the previous delivery
- Deletions carry UUID only — HealthKit discards original values on delete
- `healthKit:<Type>:new` still fires alongside `:delta` for backwards compatibility

## Options

| Option | Type | Required | Description |
|---|---|---|---|
| `type` | `HealthObserver` | **YES** | HealthKit data type (e.g. `'HeartRate'`). Missing type will return error |
| `unit` | `HealthUnit` | No | Unit for values. Falls back to type default if omitted |
| `anchor` | `string` | No | Opaque cursor from previous call. If omitted, fetches all matching |
| `startDate` | `string` | No | ISO 8601. Lower bound for the query window |
| `endDate` | `string` | No | ISO 8601. Upper bound. Defaults to now |
| `period` | `HealthPeriod` | No | Preset window (`last7days`, `last3months`, etc.) Used if `startDate` is omitted |
| `limit` | `number` | No | Max samples to return. Default: no limit |

## Validation

The `type` field is **required**. If omitted or empty, both methods return an error:

```javascript
// ❌ WRONG - missing type
AppleHealthKit.getDeltaSamples({ anchor: lastAnchor }, (err) => {
  // err.message: "getDeltaSamples: missing required 'type' field"
  // err.expectedTypes: ['HeartRate', 'StepCount', ..., 'Workout', ...]
})

// ✅ CORRECT
AppleHealthKit.getDeltaSamples({ type: 'HeartRate', anchor: lastAnchor }, (err, result) => {
  // Works correctly
})
```

For batch queries, each request must have a type:

```javascript
// ❌ WRONG - missing type in one request
AppleHealthKit.getDeltaSamplesForPermissions([
  { type: 'HeartRate', unit: 'bpm' },
  { anchor: 'abc' },  // Missing type!
], (err) => {
  // err.message: "getDeltaSamplesForPermissions: missing required \"type\" field in request"
})

// ✅ CORRECT
AppleHealthKit.getDeltaSamplesForPermissions([
  { type: 'HeartRate', unit: 'bpm' },
  { type: 'StepCount', unit: 'count' },
], (err, results) => {
  // Works correctly
})
```

## Unsupported Type Errors

Passing a non-empty but unrecognized type returns a distinct error:

```javascript
AppleHealthKit.getDeltaSamples(
  { type: 'UnknownType' },
  (err) => {
    // err.message: "getDeltaSamples: unsupported type"
    // err.type: 'UnknownType'
  }
)
```

Passing an empty or missing type returns the missing-type error with the full supported list:

```javascript
AppleHealthKit.getDeltaSamples(
  { type: '' },
  (err) => {
    // err.message: "getDeltaSamples: missing required 'type' field"
    // err.expectedTypes: ['HeartRate', 'StepCount', ..., 'Workout', ...]
  }
)
```

Supported types:

**Vitals & activity:**
`HeartRate`, `RestingHeartRate`, `HeartRateVariabilitySDNN`, `Vo2Max`,
`OxygenSaturation`, `RespiratoryRate`, `BodyTemperature`, `BloodGlucose`, `BloodPressure`

**Body measurements:**
`BodyMass`, `BodyMassIndex`, `Height`, `BodyFatPercentage`

**Activity:**
`StepCount`, `Walking`, `Running`, `Cycling`, `StairClimbing`, `Swimming`,
`ActiveEnergyBurned`, `BasalEnergyBurned`

**Other quantity types:**
`InsulinDelivery`, `DietaryCholesterol`

**Special types:**
`SleepAnalysis` (category type), `Workout` (workout type)

**Clinical / FHIR (iOS 12+):**
`AllergyRecord`, `ConditionRecord`, `CoverageRecord`, `ImmunizationRecord`,
`LabResultRecord`, `MedicationRecord`, `ProcedureRecord`, `VitalSignRecord`
