```javascript
let options = {
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
};
```

```javascript
AppleHealthKit.getDailyFlightsClimbedSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```
