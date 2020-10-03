save a percentage body fat value to Healthkit

`saveBodyFatPercentage` accepts an options object containing a percent value:
```javascript
let options = {
  value: 16.7 // 16.7%
}
```

```javascript
AppleHealthKit.saveBodyFatPercentage(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  // body fat percentage successfully saved
});
```
