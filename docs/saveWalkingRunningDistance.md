# saveWalkingRunningDistance

Save a walking + running distance sample.

A distance sample represents the amount traveled during a specific period of time. A sample should be a precise as possible, with `startDate` and `endDate` representing the range of time the steps were taken in. The unit of distance can be specified by `units` key in `options` below, defaulting to meters.

Example input options:

```javascript
// 300m over 5 min ~= 1 m/s (walking speed)
let options = {
  value: 300, // meters (default)
  startDate: new Date(2022, 6, 11, 6, 0, 0).toISOString(),
  endDate: new Date(2016, 6, 11, 6, 5, 0).toISOString(),
}
```

Call the method:

```javascript
AppleHealthKit.saveWalkingRunningDistance(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (this._handleHKError(err, 'saveWalkingRunningDistance')) {
      return
    }
    // walking + running distance sample successfully saved
  },
)
```

Example output:

```json
300
```
