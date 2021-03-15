# Save Workout

Save workout to Healthkit

`saveWorkout` accepts an options object containing type, startDate, endDate, energyBurned and distance

```javascript
let options = {
  type: 'AmericanFootball', // See HealthActivity Enum
  startDate: new Date(2016, 6, 2, 6, 0, 0).toISOString(),
  endDate: new Date(2020, 6, 2, 6, 30, 0).toISOString(),
  energyBurned: 50, // In Energy burned unit
  distance: 50, // In Distance unit
}
```

```javascript
AppleHealthKit.saveWorkout(
  (options: Object),
  (err: Object, results: Object) => {
    if (err) {
      console.log('error saving workout to Healthkit: ', err)
      return
    }
    // Done
  },
)
```
