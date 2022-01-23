# getWaistCircumferenceSamples

Query for waist circumference samples. The options object is used to setup a query to retrieve relevant samples. Waist circumference is available in iOS 11.0+.

Example input options:

```javascript
let options = {
  unit: 'inch', // optional; default 'inch'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getWaistCircumferenceSamples(
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
    "value": 39.02,
    "startDate": "2016-06-29T17:55:00.000-0400",
    "endDate": "2016-06-29T17:55:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  },
  {
    "value": 39,
    "startDate": "2016-03-12T13:22:00.000-0400",
    "endDate": "2016-03-12T13:22:00.000-0400",
    "metadata": {
      "HKWasUserEntered": true,
    }
  }
]
```
