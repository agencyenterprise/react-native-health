# getBasalEnergyBurned

A quantity sample type that measures the amount of energy burned.

Example input options:

```javascript
let options = {
  startDate: new Date(2018, 10, 1).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
}
```

Call the method:

```javascript
AppleHealthKit.getBasalEnergyBurned(
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
    "endDate": "2021-03-22T17:00:00.000-0300",
    "startDate": "2021-03-22T16:00:00.000-0300",
    "value": 42
  }
]
```
