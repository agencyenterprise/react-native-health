# getBmiSamples

Query for BMI samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getBmiSamples(
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
    "endDate": "2021-10-10T09:19:00.000+0000", 
    "id": "73A653BA-4715-47BD-98FE-E9AA91DB33CA", // The universally unique identifier (UUID) for this HealthKit object.
    "sourceId": "com.apple.Health", 
    "sourceName": "Health", 
    "startDate": "2021-10-19T09:19:00.000+0000", 
    "value": 18.5
  },
  {
    "endDate": "2021-08-23T08:50:00.000+0000",
    "id": "B3D8B5BE-216C-4C10-A96E-3B2CF8EB646E",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-08-23T08:50:00.000+0000",
    "value": 18.83
  }
]
```
