Query for blood pressure samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'mmhg',	// optional; default 'mmhg'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(),	// optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
};
```

The callback function will be called with a `samples` array containing objects with *bloodPressureSystolicValue*, *bloodPressureDiastolicValue*, *startDate*, and *endDate* fields

```javascript
AppleHealthKit.getBloodPressureSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
  { bloodPressureSystolicValue: 120, bloodPressureDiastolicValue: 81, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400' },
  { bloodPressureSystolicValue: 119, bloodPressureDiastolicValue: 77, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
```