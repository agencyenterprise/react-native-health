# getVo2MaxSamples

Query for Vo2Max samples. The options object is used to setup a query to retrieve relevant samples.

Note: This API is only available for **iOS 11**.

Example input options:

```javascript
let options = {
  unit: 'bpm', // optional; default 'ml/(kg * min)'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getVo2MaxSamples(
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
    "id": "5013eca7-4aee-45af-83c1-dbe3696b2e51", // The universally unique identifier (UUID) for this HealthKit object.
    "endDate": "2021-03-22T16:35:00.000-0300",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-22T16:35:00.000-0300",
    "value": 2,
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
