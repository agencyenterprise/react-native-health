# getDistanceSwimming

Get the total distance swimming on a specific day.

Example input options:

```javascript
let options = {
  unit: 'mile', // optional; default 'meter'
  date: (new Date(2016,5,1)).toISOString(), // optional; default now
  includeManuallyAdded: false. // optional: default true
};
```

Call the method:

```javascript
AppleHealthKit.getDistanceSwimming(
  (options: HealthInputOptions),
  (err: Object, results: HealthValue) => {
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
  "value": 20.03,
  "startDate": "2016-07-08T12:00:00.000-0400",
  "endDate": "2016-07-08T12:00:00.000-0400"
}
```
