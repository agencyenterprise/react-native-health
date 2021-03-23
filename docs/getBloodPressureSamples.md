# getBloodPressureSamples

Query for blood pressure samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'mmhg', // optional; default 'mmhg'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getBloodPressureSamples(
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
    "bloodPressureSystolicValue": 120,
    "bloodPressureDiastolicValue": 81,
    "startDate": "2016-06-29T17:55:00.000-0400",
    "endDate": "2016-06-29T17:55:00.000-0400"
  },
  {
    "bloodPressureSystolicValue": 119,
    "bloodPressureDiastolicValue": 77,
    "startDate": "2016-03-12T13:22:00.000-0400",
    "endDate": "2016-03-12T13:22:00.000-0400"
  }
]
```
