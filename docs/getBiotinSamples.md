# getBiotinSamples

A quantity sample type that measures the amount of biotin consumed.

Permission required:

- `AppleHealthKit.Constants.Permissions.Biotin`

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
}
```

Call the method:

```javascript
AppleHealthKit.getBiotinSamples(
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
    "endDate": "2021-04-01T22:00:00.000+0300", 
    "startDate": "2021-04-01T22:00:00.000+0300", 
    "value": 4,
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
