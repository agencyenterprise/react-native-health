# getCoverageRecords

Query for clinical insurance coverage records. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getCoverageRecords(
  options,
  (err: Object, results: HealthClinicalRecord[]) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output:

```json
[]
```
*output unknown at this time*