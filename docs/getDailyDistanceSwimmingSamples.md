# getDailyDistanceSwimmingSamples

Query for distance swimming samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
  period: 60, // time interval in minutes optional: default 60
  includeManuallyAdded: false. // optional: default false
  unit: 'meter' // optional; default meter
};
```

Call the method:

```javascript
AppleHealthKit.getDailyDistanceSwimmingSamples(
  options,
  (err: Object, results: Array<HealthValue>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output, value is on meters:

```json
[
  {
    "endDate": "2021-03-22T17:00:00.000-0300",
    "startDate": "2021-03-22T16:00:00.000-0300",
    "value": 91.44
  }
]
```
