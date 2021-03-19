save a carbohydrate sample to Healthkit

`saveCarbohydratesSample` accepts an options object containing a value and unit:

```javascript
let options = {
  value: 16.7,
  date: new Date(2020, 1, 1).toISOString(),
  unit: 'gramUnit', // Optional, default is gram
}
```

```javascript
AppleHealthKit.saveCarbohydratesSample(
  (options: Object),
  (err: Object, results: HealthValue) => {
    if (err) {
      return
    }
    // blood glucose successfully saved
  },
)
```
