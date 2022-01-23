# getBodyTemperatureSamples

Query for body temperature samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'celsius', // optional; default 'celsius'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Available units are: `'fahrenheit'`, `'celsius'`.

```javascript
AppleHealthKit.getBodyTemperatureSamples(
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
    "value": 74.02,
    "startDate": "2016-06-29T17:55:00.000-0400",
    "endDate": "2016-06-29T17:55:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  },
  {
    "id": "1128b739-357d-4044-9205-3a287658aac1",
    "value": 74,
    "startDate": "2016-03-12T13:22:00.000-0400",
    "endDate": "2016-03-12T13:22:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  }
]
```
