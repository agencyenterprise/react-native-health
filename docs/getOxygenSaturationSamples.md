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
    "id": "5013eca7-4aee-45af-83c1-dbe3696b2e51", // The universally unique identifier (UUID) for this HealthKit object.
    "endDate": "2021-03-04T10:56:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-04T10:56:00.000-0500",
    "value": 0.98,
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "id": "86ff59e7-f393-4f32-95fb-b0bf7027374d",
    "endDate": "2021-03-04T09:55:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-04T09:55:00.000-0500",
    "value": 0.97,
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "id": "b8239909-e519-4e33-af3e-d87db605ae97",
    "endDate": "2021-03-04T08:00:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-04T08:00:00.000-0500",
    "value": 0.95,
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "id": "349fb170-86db-4857-9ffb-c70fb4510bac",
    "endDate": "2021-03-03T21:43:00.000-0500",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-03T21:43:00.000-0500",
    "value": 0.97,
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
