Query to get all activities of given type with extended information about it.  

```javascript 1.7
let options = {
  startDate: (new Date(2016,4,27)).toISOString(),
  endDate: (new Date()).toISOString(),
  type: 'Walking', // one of: ['Walking', 'StairClimbing', 'Running', 'Cycling', 'Workout']
};
```

The callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields

```javascript 1.7
AppleHealthKit.getSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

Resulting object has different fields for different types. 
In case of workout:
```
{
  activityId: Number, // [NSNumber numberWithInt:[sample workoutActivityType]]
  activityName: Number, // [RCTAppleHealthKit stringForHKWorkoutActivityType:[sample workoutActivityType]]
  calories: Number, // [[sample totalEnergyBurned] doubleValueForUnit:[HKUnit kilocalorieUnit]]
  tracked: Boolean, // [[sample metadata][HKMetadataKeyWasUserEntered] intValue] !== 1
  sourceName: String, // [[[sample sourceRevision] source] name]
  sourceId: String, // [[[sample sourceRevision] source] bundleIdentifier]
  device: String, // [[sample sourceRevision] productType] or 'iPhone'
  distance: Number, // [[sample totalDistance] doubleValueForUnit:[HKUnit mileUnit]]
  start: String, // [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
  end: String, // [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];
}
```
for other types:
```
{
  tracked: Boolean, // [[sample metadata][HKMetadataKeyWasUserEntered] intValue] !== 1
  sourceName: String, // [[[sample sourceRevision] source] name]
  sourceId: String, // [[[sample sourceRevision] source] bundleIdentifier]
  device: String, // [[sample sourceRevision] productType] or 'iPhone'
  start: String, // [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
  end: String, // [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];
  
  //based on required type, one of the following will be present. 
  distance: Number, // [[sample totalDistance] doubleValueForUnit:[HKUnit mileUnit]]
  calories: Number, // [[sample totalEnergyBurned] doubleValueForUnit:[HKUnit kilocalorieUnit]]
}
```
