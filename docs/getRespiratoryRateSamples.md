# getRespiratoryRateSamples

Query for respiratory rate samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'bpm', // optional; default 'bpm'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getRespiratoryRateSamples(
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
    "endDate": "2021-03-22T16:32:00.000-0300",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-22T16:32:00.000-0300",
    "value": 45
  }
]
```
