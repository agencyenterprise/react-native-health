```javascript
let options = {
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
  period: 60, // time interval in minutes optional: default 60
  includeManuallyAdded: false. // optional: default false
};
```

```javascript
AppleHealthKit.getDailyDistanceSwimmingSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```
