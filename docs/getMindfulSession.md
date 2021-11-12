# getMindfulSession

Get the list of Mindful Sessions.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(),
  endDate: new Date().toISOString(),
}
```

Call the method:

```javascript
AppleHealthKit.getMindfulSession(
  options,
  (err: string, results: Array<HealthValue>) => {
    if (err) {
      console.log('error getting mindful session: ', err)
      return
    }
    // returns array of mindful session data
    console.log(results)
  },
)
```

Example output:

```json
[
  {
    "startDate": "2016-07-08T12:00:00.000-0400",
    "endDate": "2016-07-08T12:00:00.000-0400"
  },
  {
    "startDate": "2016-07-08T12:00:00.000-0400",
    "endDate": "2016-07-08T12:00:00.000-0400"
  }
]
```
