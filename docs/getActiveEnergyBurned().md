A quantity sample type that measures the amount of active energy the user has burned.

```javascript
let d = new Date(2016,1,1);
let options = {
    startDate: (new Date(2016,10,1)).toISOString(), // required
    endDate: (new Date()).toISOString(), // optional; default now
};
```

```javascript
AppleHealthKit.getActiveEnergyBurned(options: Object, (err: Object, results: Object) => {
    if (err) {
        return;
    }
    console.log(results)
});
```