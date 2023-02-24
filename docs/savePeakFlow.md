# savePeakFlow

save a numeric Peak Flow rate value to Healthkit.

`savePeakFlow` accepts an options object containing a numeric Peak Expiratory Flow rate value:

Example input options:

```javascript
let options = {
  value: 608, // liter per minute
  unit: 'literPerMinute' // this is the only accepted unit for Peak Flow rate
}
```

Call the method:

```javascript
AppleHealthKit.savePeakFlow(
  (options: HealthValueOptions),
  (err: Object, results: number) => {
    if (err) {
      console.error(err)
      return
    }
    // Peak flow successfully saved
  },
)
```

Example output:

```json
608
```
