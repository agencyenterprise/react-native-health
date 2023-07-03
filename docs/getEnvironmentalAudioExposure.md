# getEnvironmentalAudioExposure

A quantity sample type that measures audio exposure to sounds in the environment in dB(A).

Example input options:

```javascript
let options = {
  startDate: new Date(2018, 10, 1).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getEnvironmentalAudioExposure(
  (options: HealthInputOptions),
  (err: Object, results: HealthValue[]) => {
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
    "value": 69.14085783652334,
    "sourceId": "com.apple.health",
    "id": "FACC239C-F822-4BF6-BEC5-F5AB03346497",
    "sourceName": "Source",
    "startDate": "2021-07-12T20:09:00.699-0400",
    "endDate": "2021-07-12T20:38:55.700-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "value": 58.22141899831717,
    "sourceId": "com.apple.health",
    "id": "64323F3B-EF8D-41EA-BA6E-7215DC4F9055",
    "sourceName": "Source",
    "startDate": "2021-07-12T19:39:05.699-0400",
    "endDate": "2021-07-12T20:09:00.699-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```