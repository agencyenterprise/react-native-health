# getMenstrualFlowSamples

Query for menstrual flow samples.


The options object is used to setup a query to retrieve relevant samples.
The options must contain `startDate` and may also optionally include `endDate`
and `limit` options

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  limit: 10, // optional; default no limit
}
```

```javascript
AppleHealthKit.getMenstrualFlowSamples(options, (err: Object, results: Array<HealthValue>) => {
  if (err) {
    return;
  }
  console.log(results).
});
```

`value` is one of those: https://developer.apple.com/documentation/healthkit/hkcategoryvaluemenstrualflow?language=objc

Example output:

```json
[ 
  { 
    value: 'LIGHT',
    sourceId: 'com.apple.Health',
    sourceName: 'Health',
    startDate: '2021-05-14T12:00:00.000+0300',
    endDate: '2021-05-14T12:00:00.000+0300'
  } 
]
```
