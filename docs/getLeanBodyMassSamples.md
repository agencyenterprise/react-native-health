# getLeanBodyMassSamples

Query for lean body mass samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'pound', // optional; default 'pound'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getLeanBodyMassSamples(
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
    "id": "ba13089a-a311-4ffe-9352-f5c568936f16", // The universally unique identifier (UUID) for this HealthKit object.
    "value": 160,
    "startDate": "2016-07-09T00:00:00.000-0400",
    "endDate": "2016-07-10T00:00:00.000-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "id": "b50407fa-44a7-4f12-9348-74c63748b38b",
    "value": 161,
    "startDate": "2016-07-08T00:00:00.000-0400",
    "endDate": "2016-07-09T00:00:00.000-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "id": "5013eca7-4aee-45af-83c1-dbe3696b2e51",
    "value": 165,
    "startDate": "2016-07-07T00:00:00.000-0400",
    "endDate": "2016-07-08T00:00:00.000-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
