# getDailyStepCountSamples

Query for total steps per day over a specified date range. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
    startDate: (new Date(2016,1,1)).toISOString() // required
    endDate:   (new Date()).toISOString() // optional; default now
};
```

Call the method:

```javascript
AppleHealthKit.getDailyStepCountSamples(
  (options: HealthInputOptions),
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
    "value": 3978
  }
]
```
