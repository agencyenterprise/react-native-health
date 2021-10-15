# getHeightSamples

Query for height samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'inch', // optional; default 'inch'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getHeightSamples(
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
    "id": "3d366e60-4f7c-4f72-b0ce-479ea19279b8", // The universally unique identifier (UUID) for this HealthKit object.
    "value": 74.02,
    "startDate": "2016-06-29T17:55:00.000-0400",
    "endDate": "2016-06-29T17:55:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  },
  {
    "id": "19a9910d-230a-437f-a830-353f6e61f676",
    "value": 74,
    "startDate": "2016-03-12T13:22:00.000-0400",
    "endDate": "2016-03-12T13:22:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  }
]
```
