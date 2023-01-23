# getActivitySummary

An object that contains the move, exercise, and stand data for a given day.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
}
```

Call the method:

```javascript
AppleHealthKit.getActivitySummary(
  (options: HealthInputOptions),
  (err: Object, results: HealthActivitySummary[]) => {
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
    "activeEnergyBurned": 354,
    "activeEnergyBurnedGoal": 360,
    "appleExerciseTime": 16,
    "appleExerciseTimeGoal": 30,
    "appleStandHours": 10,
    "appleStandHoursGoal": 12
  }
]
```
