# getBloodAlcoholContentSamples

Query for blood alcohol content samples. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getBloodAlcoholContentSamples(
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
    "endDate": "2020-09-29T22:09:35.527+0200",
    "sourceId": "com.example.app",
    "sourceName": "app",
    "startDate": "2020-09-29T22:09:35.527+0200",
    "value": 0.003,
    "metadata": {
      "HKWasUserEntered": true,
    }
  },
  {
    "id": "30977632-ba69-4405-8e91-63dc882e8a45",
    "endDate": "2020-09-29T21:52:00.000+0200",
    "sourceId": "com.apple.Health",
    "sourceName": "Helse",
    "startDate": "2020-09-29T21:52:00.000+0200",
    "value": 0.001,
    "metadata": {
      "HKWasUserEntered": true,
    }
  },
  {
    "id": "be028840-3e08-4532-8e57-145637affd2b",
    "endDate": "2020-09-28T22:46:00.000+0200",
    "sourceId": "com.apple.Health",
    "sourceName": "Helse",
    "startDate": "2020-09-28T22:46:00.000+0200",
    "value": 0.00015,
    "metadata": {
      "HKWasUserEntered": true,
    }
  }
]
```
