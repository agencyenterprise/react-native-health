# getHeadphoneAudioExposure

A quantity sample type that measures audio exposure from headphones in dB(A)

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
AppleHealthKit.getHeadphoneAudioExposure(
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
    "value": 61.412803649902344,
    "sourceId": "com.apple.health",
    "id": "1962F2D4-45D9-4603-A3BB-4F199F024AE3",
    "sourceName": "Source",
    "startDate": "2021-07-12T19:05:14.964-0400",
    "endDate": "2021-07-12T19:05:17.304-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  },
  {
    "value": 56.37785331402696,
    "sourceId": "com.apple.health",
    "id": "304A8AEE-6B6B-4B54-BF0E-C6B8DCB4A232",
    "sourceName": "Source",
    "startDate": "2021-07-12T18:56:32.674-0400",
    "endDate": "2021-07-12T19:01:09.571-0400",
    "metadata": {
      "HKWasUserEntered": false
    }
  }
]
```