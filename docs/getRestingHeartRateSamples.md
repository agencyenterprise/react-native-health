Query for resting heart rate samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'bpm', // optional; default 'bpm'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10, // optional; default no limit
};
```

The callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields
```javascript
AppleHealthKit.getRestingHeartRateSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
	{ value: 74, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
