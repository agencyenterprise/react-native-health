Query for blood glucose samples. the options object is used to setup a query to retrieve relevant samples.

```javascript
let options = {
  unit: 'mmolPerL', // optional; default 'mmolPerL'
  startDate: new Date(2016, 4, 27).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Available units are: `'mmolPerL'`, `'mgPerdL'`.

The callback function will be called with a `samples` array containing objects with _value_, _sourceId_, _sourceName_, _startDate_, and _endDate_ fields

```javascript
AppleHealthKit.getBloodGlucoseSamples(
  options,
  (err: Object, results: Array<HealthValue>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```
