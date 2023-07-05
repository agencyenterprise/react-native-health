# getSixMinuteWalkTestDistance

Get the most recent six minute walk test distance sample.

On success, the callback function will be provided with a `sixMinuteWalkTestDistance` object containing the weight `value`, and the `startDate` and `endDate` of the weight sample. _Note: startDate and endDate will be the same as weight samples are saved at a specific point in time._

Example input options:

```javascript
let options = {
  unit: 'meter',
}
```

Call the method:

```javascript
AppleHealthKit.getSixMinuteWalkTestDistance(options, (err: string, results: HealthValue) => {
  if (err) {
    console.log('error getting latest sixMinuteWalkTestDistance: ', err)
    return
  }
  console.log(results)
})
```

Example output:

```json
{
  "value": 200,
  "startDate": "2016-07-08T12:00:00.000-0400",
  "endDate": "2016-07-08T12:00:00.000-0400"
}
```
