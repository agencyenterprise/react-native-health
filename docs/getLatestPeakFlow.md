# getLatestPeakFlow

Get the most recent Peak Flow rate value.

On success, the callback function will be provided with a `peakFlow` object containing the Peak Flow Expiratory rate `value`, and the `startDate` and `endDate` of the Peak Flow sample. _Note: startDate and endDate will be the same as samples are saved at a specific point in time._

```javascript
AppleHealthKit.getLatestPeakFlow({}, (err: string, results: HealthValue) => {
  if (err) {
    console.log('error getting latest Peak Flow rate: ', err)
    return
  }
  console.log(results)
})
```

Example output:

```json
{
  "value": 608,
  "startDate": "2021-07-21T11:08:05.366+0100",
  "endDate": "2021-07-21T11:08:05.366+0100"
}
```
