# getWalkingHeartRateAverage

Query for walking heart rate average values. The options object is used to setup a query to retrieve relevant samples.

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

Call the method:

```javascript
AppleHealthKit.getWalkingHeartRateAverage(
  options,
  (err: Object, results: HealthValue[]) => {
    if (err) {
      return;
    }
    console.log(results);
  },
)
```

Example output:

```json
[
  {
    "value": 77,
    "sourceId": "com.apple.health",
    "id": "6AFB1A69-0165-4495-9B9A-7C594B63D88C",
    "sourceName": "Source",
    "startDate": "2021-07-05T12:53:58.870-0400",
    "endDate": "2021-07-05T15:14:23.413-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "value": 73,
    "sourceId": "com.apple.health",
    "id": "A13D758C-DCD4-44FA-87A9-7DD63DED31F6",
    "sourceName": "Source",
    "startDate": "2021-07-04T00:00:25.881-0400",
    "endDate": "2021-07-04T11:39:15.130-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
