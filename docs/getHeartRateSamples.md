# getHeartRateSamples

Query for heart rate samples. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getHeartRateSamples(
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
      "HKWasUserEntered": false
    }
  },
  {
    "id": "4ea9e479-86e2-4e82-8030-86a9a9b8e569",
    "value": 74,
    "startDate": "2016-03-12T13:22:00.000-0400",
    "endDate": "2016-03-12T13:22:00.000-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
