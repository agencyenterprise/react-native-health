# getStepCount

Get the aggregated total steps for a specific day (starting and ending at midnight).

An optional options object may be provided containing `date` field representing the selected day. If `date` is not set or an options object is not provided then the current day will be used.

Example input options:

```javascript
let options = {
    date: new Date().toISOString(), // optional; default now
    includeManuallyAdded: false. // optional: default true
};
```

Call the method:

```javascript
AppleHealthKit.getStepCount(
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
  "value": 213
}
```
