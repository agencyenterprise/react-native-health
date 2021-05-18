# getBasalBodyTemperatureSamples

Query for basal body temperature samples in Reproductive Health. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'celsius', // optional; default 'celsius'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getBasalBodyTemperatureSamples(
  options,
  (err: Object, results: Array<HealthValue>) => {
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
    "endDate": "2021-05-17T18:15:00.000+0300",
    "sourceId": "com.apple.Health", 
    "sourceName": "Health", 
    "startDate": "2021-05-17T18:15:00.000+0300", 
    "value": 37
  }
]
```
