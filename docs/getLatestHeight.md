# getLatestHeight

Get the most recent height value.

On success, the callback function will be provided with a `height` object containing the height `value`, and the `startDate` and `endDate` of the height sample. _Note: startDate and endDate will be the same as height samples are saved at a specific point in time._

```javascript
AppleHealthKit.getLatestHeight(null, (err: string, results: HealthValue) => {
  if (err) {
    console.log('error getting latest height: ', err)
    return
  }
  console.log(results)
})
```

Example output:

```json
{
  "value": 72,
  "startDate": "2016-07-08T12:00:00.000-0400",
  "endDate": "2016-07-08T12:00:00.000-0400"
}
```
