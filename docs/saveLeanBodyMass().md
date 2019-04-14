save a numeric lean body mass value to Healthkit

`saveLeanBodyMass` accepts an options object containing a numeric weight value:
```javascript
let options = {
  value: 155.6 // lbs
}
```

```javascript
AppleHealthKit.saveLeanBodyMass(options: Object, (err: Object, results: Object) => {
    if (err) {
        console.log("error saving lean body mass to Healthkit: ", err);
        return;
    }
    // Done
});
```
