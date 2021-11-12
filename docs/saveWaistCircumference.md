# saveWaistCircumference

save a numeric waist circumference value to Healthkit. Waist circumference is available in iOS 11.0+.

`saveWaistCircumference` accepts an options object containing a numeric waist circumference value:

Example input options:

```javascript
let options = {
  value: 39, // Inches
}
```

Call the method:

```javascript
AppleHealthKit.saveWaistCircumference(
  (options: HealthValueOptions),
  (err: Object, results: number) => {
    if (err) {
      return
    }
    // waist circumference successfully saved
  },
)
```

Example output:

```json
39
```
