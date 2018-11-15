Query for sleep samples.

Each sleep sample represents a period of time with a startDate and an endDate.
the sample's value will be either `INBED` or `ASLEEP`. these values should overlap,
meaning that two (or more) samples represent a single nights sleep activity. see
[Healthkit SleepAnalysis] reference documentation

The options object is used to setup a query to retrieve relevant samples.
The options must contain `startDate` and may also optionally include `endDate`
and `limit` options
```javascript
let options = {
  startDate: (new Date(2016,10,1)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  limit:10, // optional; default no limit
};
```

The callback function will be called with a `samples` array containing objects
with *value*, *startDate*, and *endDate* fields

```javascript
AppleHealthKit.getSleepSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results).
});
```