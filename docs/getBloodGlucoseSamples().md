Query for blood glucose samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'mmolPerL',	// optional; default 'mmolPerL'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10,	// optional; default no limit
};
```
Available units are: `'mmolPerL'`, `'mgPerdL'`.

The callback function will be called with a `samples` array containing objects with *value*, *sourceId*, *sourceName*, *startDate*, and *endDate* fields

```javascript
AppleHealthKit.getBloodGlucoseSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```
