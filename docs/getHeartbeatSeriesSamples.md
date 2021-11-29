# getHeartbeatSeriesSamples

Query for the beat-to-beat measurements used to compute the heart rate variability. Permission to HeartRateVariability and HeartbeatSeries is required to access this data.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getHeartbeatSeriesSamples(
  options,
  (err: Object, results: HeartbeatSeriesSampleValue[]) => {
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
    "id": "9728168D-CFD4-4946-BF94-2789ECD39A72",
    "sourceName": "Apple Watch",
    "startDate": "2021-07-10T08:55:31.307-0400",
    "endDate": "2021-07-10T08:56:34.731-0400",
    "sourceId": "com.apple.health",
    "heartbeatSeries": [
      {
        "timeSinceSeriesStart": 0.97265625,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 1.55859375,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 2.16015625,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 2.7421875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 3.3125,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 3.89453125,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 4.484375,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 5.10546875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 5.7421875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 6.40234375,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 7.0859375,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 7.78125,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 8.48046875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 9.16015625,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 9.8203125,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 10.48046875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 11.1171875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 11.73046875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 12.3359375,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 12.91796875,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 13.50390625,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 14.09765625,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 14.734375,
        "precededByGap": false
      },
      {
        "timeSinceSeriesStart": 15.90625,
        "precededByGap": true
      }
    ]
  }
]
```
