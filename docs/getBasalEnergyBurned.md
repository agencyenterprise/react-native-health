# getBasalEnergyBurned

A quantity sample type that measures the amount of `resting energy` burned within a period of time.
These samples together with `active energy` burned for the same time period represent the `total energy` burned for that period (usually seen as Total Kilocalories in a workout on Apple Watch).

Example input options:

```javascript
let options = {
  startDate: new Date(2018, 10, 1).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: true, // optional
  includeManuallyAdded: true, // optional
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
