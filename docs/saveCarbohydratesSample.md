# saveCarbohydratesSample

save a carbohydrate sample to Healthkit

`saveCarbohydratesSample` accepts an options object containing a value and unit:

Example input options:

```javascript
let options = {
  value: 16.7,
  date: new Date(2020, 1, 1).toISOString(),
  unit: 'gramUnit', // Optional, default is gram
}
```

Call the method:

```javascript
AppleHealthKit.saveFood(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err) {
      return
    }
    // blood glucose successfully saved
  },
)
```

Example output:

```json
16.7
```
