# getVitaminB6Samples

A quantity sample type that measures the amount of Vitamin B6 consumed.

Permission required:

- `AppleHealthKit.Constants.Permissions.VitaminB6`

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
}
```

Call the method:

```javascript
AppleHealthKit.getVitaminB6Samples(
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
    "value": 20,
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```
