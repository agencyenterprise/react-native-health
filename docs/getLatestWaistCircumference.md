# getLatestWaistCircumference

Get the most recent waist circumference value. Waist circumference is available in iOS 11.0+.

On success, the callback function will be provided with a `waistCircumference` object containing the waist circumference `value`, and the `startDate` and `endDate` of the waist circumference sample. _Note: startDate and endDate will be the same as waist circumference samples are saved at a specific point in time._

```javascript
AppleHealthKit.getLatestWaistCircumference({}, (err: string, results: HealthValue) => {
  if (err) {
    console.log('error getting latest waist circumference: ', err)
    return
  }
  console.log(results)
})
```

Example output:

```json
{
  "value": 39,
  "startDate": "2021-06-15T11:08:05.366+0100",
  "endDate": "2021-06-15T11:08:05.366+0100"
}
```
