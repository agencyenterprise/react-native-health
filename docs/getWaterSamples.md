# getWaterSamples

Get the total amount of consumed water in litres for a specific time period

Example input options:

```javascript
let options = {
    unit: 'litre', // optional: default: litre
    startDate: new Date(2021, 0, 0).toISOString(), // required
    endDate: new Date().toISOString(), // required
    includeManuallyAdded: false, // optional: default true
    ascending: false, // optional; default false
    limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getWaterSamples(
  (options: HealthInputOptions),
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
    "endDate": "2021-03-22T16:34:00.000-0300",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-22T15:34:00.000-0300",
    "value": "0.6"
  }
]
```
