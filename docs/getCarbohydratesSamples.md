Query for carbohydrate samples. the options object is used to setup a query to retrieve relevant samples.

```javascript
let options = {
  unit: 'gramUnit', // optional; default 'gram'
  startDate: new Date(2016, 4, 27).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

The callback function will be called with a `samples` array containing objects with _value_, _startDate_, and _endDate_ fields.

```javascript
AppleHealthKit.getCarbohydrateSamples(
  options,
  (err: Object, results: Array<Object>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```
