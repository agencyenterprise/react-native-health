A quantity sample type that measures the amount of time the user has spent standing.

```javascript
let d = new Date(2016,1,1);
let options = {
    startDate: (new Date(2016,10,1)).toISOString(), // required
    endDate: (new Date()).toISOString(), // optional; default now
};
```

```javascript
AppleHealthKit.getAppleStandTime(options: Object, (err: Object, results: Object) => {
    if (err) {
        return;
    }
    console.log(results)
});
```