# getBloodGlucoseSamples

Query for blood glucose samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'mmolPerL', // optional; default 'mmolPerL'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Available units are: `'mmolPerL'`, `'mgPerdL'`.

```javascript
AppleHealthKit.getBloodGlucoseSamples(
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
    "endDate": "2021-03-22T16:19:00.000-0300",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-22T16:19:00.000-0300",
    "value": 5.7,
    "metadata": {
      "HKWasUserEntered": true,
      "HKBloodGlucoseMealTime": 1, // Preprandial = 1, Postprandial = 2
    }
  }
]
```
