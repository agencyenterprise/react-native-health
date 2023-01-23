# getBodyFatPercentageSamples

Query for body fat percentage samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getBodyFatPercentageSamples(
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
    "value": 16.5,
    "startDate": "2016-07-09T00:00:00.000-0400",
    "endDate": "2016-07-10T00:00:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  },
  {
    "id": "ba13089a-a311-4ffe-9352-f5c568936f16",
    "value": 16.1,
    "startDate": "2016-07-08T00:00:00.000-0400",
    "endDate": "2016-07-09T00:00:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  },
  {
    "id": "2292e713-636e-45a1-acd8-365397f6efed",
    "value": 15.9,
    "startDate": "2016-07-07T00:00:00.000-0400",
    "endDate": "2016-07-08T00:00:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  }
]
```
