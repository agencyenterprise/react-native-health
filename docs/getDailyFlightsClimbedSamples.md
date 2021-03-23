# getDailyFlightsClimbedSamples

Query for daily flights climbed samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getDailyFlightsClimbedSamples(
  options,
  (err: Object, results: Array<Object>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output, value is on count unit:

```json
[
  {
    "endDate": "2021-03-22T17:00:00.000-0300",
    "startDate": "2021-03-22T16:00:00.000-0300",
    "value": 5
  }
]
```
