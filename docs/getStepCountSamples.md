# getStepCountSamples

Query for step count samples over a specified date range. Each sample represents individual step count data points. Use this for detailed per-sample data; use `getDailyStepCountSamples` for aggregated daily totals.

Example input options:

```javascript
let options = {
    startDate: (new Date(2016,1,1)).toISOString(), // required
    endDate:   (new Date()).toISOString(), // optional; default now
    unit: 'count', // optional; default 'count'
    ascending: false, // optional; default false
    limit: 10, // optional; default no limit
};
```

Call the method:

```javascript
AppleHealthKit.getStepCountSamples(
  (options: HealthInputOptions),
  (err: Object, results: Array<Object>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output, value is in count unit:

```json
[
  {
    "id": "5013eca7-4aee-45af-83c1-dbe3696b2e51",
    "value": 1234,
    "startDate": "2021-03-22T16:00:00.000-0300",
    "endDate": "2021-03-22T17:00:00.000-0300",
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
