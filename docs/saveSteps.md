# saveSteps

Save a step count sample.

A step count sample represents the number of steps during a specific period of time. A sample should be a precise as possible, with startDate and endDate representing the range of time the steps were taken in.

Example input options:

```javascript
let options = {
  value: 100,
  startDate: new Date(2016, 6, 2, 6, 0, 0).toISOString(),
  endDate: new Date(2016, 6, 2, 6, 30, 0).toISOString(),
}
```

Call the method:

```javascript
AppleHealthKit.saveSteps(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (this._handleHKError(err, 'saveSteps')) {
      return
    }
    // step count sample successfully saved
  },
)
```

Example output:

```json
100
```
