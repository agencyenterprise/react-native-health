# saveBodyFatPercentage

save a percentage body fat value to Healthkit

`saveBodyFatPercentage` accepts an options object containing a percent value:

Example input options:

```javascript
let options = {
  value: 16.7, // 16.7%
}
```

Call the method:

```javascript
AppleHealthKit.saveBodyFatPercentage(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err) {
      return
    }
    // body fat percentage successfully saved
  },
)
```

Example output:

```json
16.7
```
