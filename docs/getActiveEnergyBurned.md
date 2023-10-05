# getActiveEnergyBurned

A quantity sample type that measures the amount of `active energy` the user has burned within a period of time. This represents only the Active Kilocalories from the Total Kilocalories for that time period.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: true, // optional
  includeManuallyAdded: true, // optional
}
```

Call the method:

```javascript
AppleHealthKit.getActiveEnergyBurned(
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
