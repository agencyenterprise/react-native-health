save a numeric weight value to Healthkit

`saveWeight` accepts an options object containing a numeric weight value:
```javascript
let options = {
  value: 200
}
```

```javascript
AppleHealthKit.saveWeight(options: Object, (err: Object, results: Object) => {
    if (err) {
        console.log("error saving weight to Healthkit: ", err);
        return;
    }
    // Done
});
```