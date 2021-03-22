Get the list of Mindful Sessions.

```javascript
let options = {
  startDate: Date,
  endDate: Date,
  limit?: number
};
```

```javascript
AppleHealthKit.getMindfulSession(options, (err: string, results: Object) => {
  if (err) {
    console.log('error getting mindful session: ', err)
    return
  }
  // returns array of mindful session data
  console.log(results)
})
```

```javascript
;[
  {
    startDate: '2016-07-08T12:00:00.000-0400',
    endDate: '2016-07-08T12:00:00.000-0400',
  },
  {
    startDate: '2016-07-08T12:00:00.000-0400',
    endDate: '2016-07-08T12:00:00.000-0400',
  },
]
```
