# saveBloodAlcoholContent

save a blood alcohol value to Healthkit

`saveBloodAlcoholContent` accepts an options object containing a percent value:

Example input options:

```javascript
let options = {
    value: 16.7 // 16.7%
    startDate: '2016-07-08T12:00:00.000-0400', // Optional, default now
    unit: 'percent', // Optional, default is percent
}
```

Call the method:

```javascript
AppleHealthKit.saveBloodAlcoholContent(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err) {
      return
    }
    // blood alcohol successfully saved
  },
)
```

Example output:

```json
16.7
```
