save a numeric BMI value to Healthkit

`saveBmi` accepts an options object containing a numeric BMI value:
```javascript
let options = {
  value: 27.2
}
```
```javascript
AppleHealthKit.saveBmi(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  // BMI successfully saved
});
```