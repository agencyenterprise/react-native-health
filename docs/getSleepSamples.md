# getSleepSamples

Query for sleep samples.

Each sleep sample represents a period of time with a startDate and an endDate.
the sample's value will be either `INBED` or `ASLEEP`. these values should overlap,
meaning that two (or more) samples represent a single nights sleep activity. see
[Healthkit SleepAnalysis] reference documentation

The options object is used to setup a query to retrieve relevant samples.
The options must contain `startDate` and may also optionally include `endDate`, `ascending`, or `limit` options

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  limit: 10, // optional; default no limit
  ascending: true, // optional; default false
}
```

```javascript
AppleHealthKit.getSleepSamples(options, (err: Object, results: Array<HealthValue>) => {
  if (err) {
    return;
  }
  console.log(results).
});
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
    "value": "INBED"
  }
]
```
