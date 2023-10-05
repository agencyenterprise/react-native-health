# getWorkoutRouteSamples.md

Query for workout route samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  id: 'E621E1F8-C36C-495A-93FC-0C247A3E6E5F',  // required [UUID]
}
```

```javascript
AppleHealthKit.getWorkoutRouteSamples(
  options,
  (err: Object, results: Array<WorkoutRouteQueryResults>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output:

```json
  {
    anchor: String,
    data: {
      device: String,
      id: String,
      metadata: String,
      sourceName: String,
      sourceId: String,
      start: String,
      end: String,
      locations: [{
        latitude: Number,
        longitude: Number,
        altitude: Number,
        timestamp: String,
        speed: Number,
        speedAccuracy: Number,
      }]
    }
  }
```
