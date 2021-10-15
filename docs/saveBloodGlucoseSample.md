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
    metadata: {
      HKWasUserEntered: true,
      HKBloodGlucoseMealTime: 1, // Preprandial = 1, Postprandial = 2
      anyOtherKey: 'some data', // supports string, number, boolean
    }
}
```

Available units are: `'mmolPerL'`, `'mgPerdL'`.

Example usage:

```javascript
AppleHealthKit.saveBloodGlucoseSample(
  input,
  (err: Object, result: string) => {
    if (err) {
      return
    }
    // blood glucose successfully saved
    console.log(result)
  },
)
```

Example output (record's UUID):

```json
"ba13089a-a311-4ffe-9352-f5c568936f16"
```
