# getPeakFlowSamples

Query for Peak Flow Expiratory rate samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  unit: 'literPerMinute', // optional; default 'literPerMinute'
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getPeakFlowSamples(
  options,
  (err: Object, results: Array<HealthValue>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output:

Note the first item in the sample was saved from the app using `.savePeakFlow` hence it has the _sourceId_ and _sourceName_ of the app. The others have _Apple Health_ as a _sourceId_ since they were saved in Apple Health directly.

```json
[{
	"endDate": "2021-07-21T09:32:24.222+0100",
	"id": "16C5F196-AB1D-4F84-9642-7178F05849A3",
	"sourceId": "com.mycompany.myapp",
	"sourceName": "MyApp",
	"startDate": "2021-07-21T09:32:24.222+0100",
	"value": 602
}, {
	"endDate": "2021-07-19T15:42:00.000+0100",
	"id": "803E42FC-2E5B-4C4B-A5DA-4DA74D870F18",
	"sourceId": "com.apple.Health",
	"sourceName": "Health",
	"startDate": "2021-07-19T15:42:00.000+0100",
	"value": 608
}, {
	"endDate": "2021-07-16T15:42:00.000+0100",
	"id": "93421AF8-5CCE-40D5-87D1-3E26404D139B",
	"sourceId": "com.apple.Health",
	"sourceName": "Health",
	"startDate": "2021-07-16T15:42:00.000+0100",
	"value": 605
}]
```
