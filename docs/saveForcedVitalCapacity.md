# saveForcedVitalCapacity

save a numeric Forced Vital Capacity value to Healthkit.

`saveForcedVitalCapacity` accepts an options object containing a numeric Forced Vital Capacity rate value:

Example input options:

```javascript
let options = {
  value: 608, // liter per minute
  unit: 'liter' // this is the only accepted unit for Forced Vital Capacity
}
```

Call the method:

```javascript
AppleHealthKit.saveForcedVitalCapacity(
  (options: HealthValueOptions),
  (err: Object, results: number) => {
    if (err) {
      console.error(err)
      return
    }
    // Forced Vital Capacity successfully saved
  },
)
```

Example output:

```json
4.6
```
