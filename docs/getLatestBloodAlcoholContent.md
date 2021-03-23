# getLatestBloodAlcoholContent

Get the most recent blood alcohol content value.

On success, the callback function will be provided with a `blood alcohol content` object containing the blood alcohol content `value`, and the `startDate` and `endDate` of the blood alcohol content sample. _Note: startDate and endDate will be the same as blood alcohol content samples are saved at a specific point in time._

```javascript
AppleHealthKit.getLatestBloodAlcoholContent(
  null,
  (err: string, results: HealthValue) => {
    if (err) {
      console.log('error getting latest blood alcohol content: ', err)
      return
    }
    console.log(results)
  },
)
```

Example output, value is on percent:

```json
{
  "value": 0.001,
  "startDate": "2016-07-08T12:00:00.000-0400",
  "endDate": "2016-07-08T12:00:00.000-0400"
}
```
