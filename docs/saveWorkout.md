# saveWorkout

Save workout to Healthkit

`saveWorkout` accepts an options object containing type, startDate, endDate, energyBurned and distance

Example input options:

```javascript
let options = {
  type: 'AmericanFootball', // See HealthActivity Enum
  startDate: new Date(2016, 6, 2, 6, 0, 0).toISOString(),
  endDate: new Date(2020, 6, 2, 6, 30, 0).toISOString(),
  energyBurned: 50, // In Energy burned unit,
  energyBurnedUnit: 'calorie', 
  distance: 50, // In Distance unit
  distanceUnit: 'meter'
}
```

Call the method:

```javascript
AppleHealthKit.saveWorkout(
  (options: HealthInputOptions),
  (err: Object, results: string) => {
    if (err) {
      console.log('error saving workout to Healthkit: ', err)
      return
    }
    // workout successfully saved
  },
)
```

Example output, UUIDString:

```json
 A7D8E94A-5544-4533-869F-7566AAB81252
```
