Query for respiratory rate samples. the options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getRespiratoryRateSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```
