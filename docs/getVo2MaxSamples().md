Query for Vo2Max samples. the options object is used to setup a query to retrieve relevant samples.

Note: This API is only available for **iOS 11**.

```javascript
let options = {
  unit: 'bpm', // optional; default 'ml/(kg * min)'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
};
```

The callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields

```javascript
AppleHealthKit.getVo2MaxSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```
