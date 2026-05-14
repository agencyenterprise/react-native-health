# configureBackgroundSync

Configure the minimum interval between background delta fetches. Call this once after `initHealthKit` to opt into background sync.

## Signature

```js
AppleHealthKit.configureBackgroundSync(options)
```

## Options

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| `enabled` | `boolean` | `true` | Enable or disable background sync |
| `syncInterval` | `SyncInterval \| number` | `'every24hours'` | Minimum time between delta fetches |

### SyncInterval

Either a named alias or a raw **number of seconds**:

| Alias | Seconds |
|-------|---------|
| `'every1hour'` | 3600 |
| `'every6hours'` | 21600 |
| `'every12hours'` | 43200 |
| `'every24hours'` | 86400 |
| `'every48hours'` | 172800 |
| `'everyweek'` | 604800 |
| `number` | positive seconds, e.g. `60` for 1 minute; floats are rounded to nearest integer |

### Input validation

- **Unrecognized string** — falls back to `86400s` (24 hours) and logs a warning.
- **Float** — rounded to nearest integer, minimum `1s` (e.g. `1.5` → `2`, `0.3` → `1`).
- **Invalid number** (zero, negative, NaN, Infinity) — defaults to `86400s` (24 hours).
- **Wrong type** (not string or number) — falls back to `86400s` and logs a warning.

## Examples

```js
import AppleHealthKit from 'react-native-health'

// Named alias
AppleHealthKit.configureBackgroundSync({ enabled: true, syncInterval: 'every6hours' })

// Raw seconds — useful for testing or non-standard intervals
AppleHealthKit.configureBackgroundSync({ enabled: true, syncInterval: 60 })   // 1 minute
AppleHealthKit.configureBackgroundSync({ enabled: true, syncInterval: 300 })  // 5 minutes

// Disable
AppleHealthKit.configureBackgroundSync({ enabled: false })
```

## Notes

- This only controls the minimum interval enforced in native code. HealthKit itself decides when to wake the app in the background.
- If never called, background sync is disabled by default (opt-in behaviour).
- Call `setObserver` for each type you want to receive delta events for.
