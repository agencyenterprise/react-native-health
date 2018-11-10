Get the total steps per day over a specified date range.

`getDailyStepCountSamples` accepts an options object containing required *`startDate: ISO8601Timestamp`* and optional *`endDate: ISO8601Timestamp`*. If `endDate` is not provided it will default to the current time
```javascript
let options = {
    startDate: (new Date(2016,1,1)).toISOString() // required
    endDate:   (new Date()).toISOString() // optional; default now
};
```

```javascript
 AppleHealthKit.getDailyStepCountSamples(options: Object, (err: Object, results: Array<Object>) => {
    if (this._handleHealthkitError(err, 'getDailyStepCountSamples')) {
        return;
    }
    console.log(results)
});
```