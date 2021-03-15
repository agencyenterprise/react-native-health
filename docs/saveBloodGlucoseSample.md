save a blood glucose value to Healthkit

`saveBloodGlucoseSample` accepts an options object containing a percent value:

```javascript
let options = {
    value: 16.7 // 16.7%
    startDate: '2016-07-08T12:00:00.000-0400', // Optional, default now
    unit: 'percent', // Optional, default is percent
}
```

```javascript
AppleHealthKit.saveBloodGlucoseSample(
  (options: Object),
  (err: Object, results: Object) => {
    if (err) {
      return
    }
    // blood glucose successfully saved
  },
)
```
