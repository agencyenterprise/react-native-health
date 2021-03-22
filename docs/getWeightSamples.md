# getWeightSamples

Query for weight samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'pound', // optional; default 'pound'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getWeightSamples(
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
    "value": 160,
    "startDate": "2016-07-09T00:00:00.000-0400",
    "endDate": "2016-07-10T00:00:00.000-0400"
  },
  {
    "value": 161,
    "startDate": "2016-07-08T00:00:00.000-0400",
    "endDate": "2016-07-09T00:00:00.000-0400"
  },
  {
    "value": 165,
    "startDate": "2016-07-07T00:00:00.000-0400",
    "endDate": "2016-07-08T00:00:00.000-0400"
  }
]
```
