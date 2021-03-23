# getLatestBmi

Get the most recent BMI sample.

On success, the callback function will be provided with a `bmi` object containing the BMI `value`, and the `startDate` and `endDate` of the sample. _Note: startDate and endDate will be the same as bmi samples are saved at a specific point in time._

```javascript
AppleHealthKit.getLatestBmi(null, (err: string, results: HealthValue) => {
  if (err) {
    console.log('error getting latest bmi data: ', err)
    return
  }
  console.log(results)
})
```

Example output:

```json
{
  "value": 27.2,
  "startDate": "2016-07-08T12:00:00.000-0400",
  "endDate": "2016-07-08T12:00:00.000-0400"
}
```
