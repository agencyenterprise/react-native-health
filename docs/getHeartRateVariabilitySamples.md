# getHeartRateVariabilitySamples

Query for resting SDNN Heart Rate Variability samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'second', // optional; default 'second'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getHeartRateVariabilitySamples(
  options,
  (err: Object, results: Array<HealthValue>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output:

```json
[
  {
    "value": 0.4223,
    "startDate": "2016-03-12T13:22:00.000-0400",
    "endDate": "2016-03-12T13:22:00.000-0400"
  }
]
```
