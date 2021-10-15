# saveCarbohydratesSample

save a carbohydrate sample to Healthkit

`saveCarbohydratesSample` accepts an options object containing a value and unit:

Example input options:

```javascript
let options = {
  value: 16.7,
  date: new Date(2020, 1, 1).toISOString(),
  unit: 'gramUnit', // Optional, default is gram
  metadata: {
    HKWasUserEntered: true,
    anyOtherKey: 'some data', // supports string, number, boolean
  }
}
```

Call the method:

```javascript
AppleHealthKit.saveFood(
  (options: HealthInputOptions),
  (err: Object, results: string) => {
    if (err) {
      return
    }
    // blood glucose successfully saved
  },
)
```

Example output (record's UUID):

```json
"ba13089a-a311-4ffe-9352-f5c568936f16"
```
