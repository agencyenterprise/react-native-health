# getOxygenSaturationSamples

Query for Oxygen Saturation samples.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 1, 1).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getOxygenSaturationSamples(
  options,
  (callbackError: Object, results: Array<HealthValue>) => {
    if (callbackError) {
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
    "endDate": "2021-03-04T10:56:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-04T10:56:00.000-0500",
    "value": 0.98
  },
  {
    "endDate": "2021-03-04T09:55:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-04T09:55:00.000-0500",
    "value": 0.97
  },
  {
    "endDate": "2021-03-04T08:00:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-04T08:00:00.000-0500",
    "value": 0.95
  },
  {
    "endDate": "2021-03-03T21:43:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-03T21:43:00.000-0500",
    "value": 0.97
  }
]
```
