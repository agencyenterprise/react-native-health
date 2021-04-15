# getAnchoredWorkouts Query

Query to get all workouts of any given type by a given anchor (a physical memory address) OR for a specific date range. If succesful, this method will return an object that contains all of the workouts for that specific query and a new anchor for subsequent calls. Workouts returned are unsorted. 

## Params:

- If the startDate is *nil*, the getAnchoredQuery will return *ALL* available workouts, as well as the base64 encoded anchor.

- If both a stardDate and endDate are provided but without an anchor, results will be an array of unsorted workouts from that range and as well as a base64 encoded anchor (the last workout). 

- If an anchor is provided along with a startDate and endDate, and the resulting workouts will be of any additions after the anchor (provided they are within the range of that date). 

- If an anchor is provided but without a time range. Thus, if the anchor points to a workout done today, but the user adds a workout in Apple Health that happens 2 years ago, the query will return that workout since it was added to healthkit after the anchor provided.

```ts
let options = {
  startDate?: (new Date(2016,4,27)).toISOString(), // 
  endDate?: (new Date()).toISOString(),
  queryAnchor?: 'base64encodedstring',
  type: 'Workout', // one of: ['Walking', 'StairClimbing', 'Running', 'Cycling', 'Workout']
};
```

## Response

If an anchor was given, all of the entries added after that anchor will be returned, regardless of date. The resulting response of this query will look as following:

```ts
interface AnchoredQueryResults {
    anchor: string
    data: Array<HKWorkoutQueriedSampleType>
  }
```

The callback function will be called with a `samples` array containing objects with *value*, *queryAnchor*, *startDate*, and *endDate* fields

```ts
AppleHealthKit.getAnchoredWorkouts(options, (err: Object, results: AnchoredQueryResults) => {
  if (err) {
    return;
  }
  console.log(results.data)
  console.log(results.anchor)
});
```

The resulting workouts in the array will look as the following:

```ts
{
  activityId: Number, // [NSNumber numberWithInt:[sample workoutActivityType]]
  activityName: Number, // [RCTAppleHealthKit stringForHKWorkoutActivityType:[sample workoutActivityType]]
  metadata: String, 
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
