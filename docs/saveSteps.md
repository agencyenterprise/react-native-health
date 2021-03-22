Save a step count sample.

A step count sample represents the number of steps during a specific period of time. A sample should be a precise as possible, with startDate and endDate representing the range of time the steps were taken in.

`saveSteps` accepts an options object containing required _`value: number`_, _`startDate: ISO8601Timestamp`_, and _`endDate: ISO8601Timestamp`_.

```javascript
// startDate and endDate are 30 minutes apart.
// this means the step count value occurred within those 30 minutes.
let options = {
  value: 100,
  startDate: new Date(2016, 6, 2, 6, 0, 0).toISOString(),
  endDate: new Date(2016, 6, 2, 6, 30, 0).toISOString(),
}
```

```javascript
AppleHealthKit.saveSteps(options, (err, res) => {
  if (this._handleHKError(err, 'saveSteps')) {
    return
  }
  // step count sample successfully saved
})
```
