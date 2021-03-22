# getAppleStandTime

A quantity sample type that measures the amount of time the user has spent standing.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
}
```

Call the method:

```javascript
AppleHealthKit.getAppleStandTime(
  (options: HealthInputOptions),
  (err: Object, results: HealthValue) => {
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
    "endDate": "2021-03-22T16:00:00.000-0300",
    "startDate": "2021-03-22T15:00:00.000-0300",
    "value": 123
  }
]
```
