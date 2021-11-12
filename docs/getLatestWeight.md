# getLatestWeight

Get the most recent weight sample.

On success, the callback function will be provided with a `weight` object containing the weight `value`, and the `startDate` and `endDate` of the weight sample. _Note: startDate and endDate will be the same as weight samples are saved at a specific point in time._

Example input options:

```javascript
let options = {
  unit: 'pound',
}
```

Call the method:

```javascript
AppleHealthKit.getLatestWeight(options, (err: string, results: HealthValue) => {
  if (err) {
    console.log('error getting latest weight: ', err)
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
