# getLatestLeanBodyMass

Get the most recent lean body mass. The value is a number representing the weight in pounds (lbs)

On success, the callback function will be provided with a `leanBodyMass` object containing the leanBodyMass `value`, and the `startDate` and `endDate` of the sample. _Note: startDate and endDate will be the same as leanBodyMass samples are saved at a specific point in time._

```javascript
AppleHealthKit.getLatestLeanBodyMass(
  null,
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
  "value": 176,
  "startDate": "2016-07-08T12:00:00.000-0400",
  "endDate": "2016-07-08T12:00:00.000-0400"
}
```
