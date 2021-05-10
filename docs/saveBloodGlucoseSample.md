# saveBloodGlucoseSample

Save a blood glucose value to HealthKit.

`saveBloodGlucoseSample` accepts an options object containing glucose sample data and a callback:

Example input object:

```javascript
let input = {
    value: 6.1, // 6.1 mmol/L
    startDate: '2016-07-08T12:00:00.000-0400', // Optional, defaults to now
    endDate: '2016-07-08T12:00:00.000-0400', // Optional, defaults to startDate
    unit: 'mmolPerL', // Optional, defaults to mmolPerL
}
```

Available units are: `'mmolPerL'`, `'mgPerdL'`.

Example usage:

```javascript
AppleHealthKit.saveBloodGlucoseSample(
  input,
  (err: Object, result: number) => {
    if (err) {
      return
    }
    // blood glucose successfully saved
    console.log(result)
  },
)
```

Example output:

```json
6.1
```
