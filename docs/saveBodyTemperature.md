# saveBodyTemperature

save a body temperature value to Healthkit

`saveBodyTemperature` accepts an options object containing a value:

Example input options:

```javascript
let options = {
  value: 96,
  date: new Date(2016, 5, 1).toISOString(), // optional; default now
  unit: 'celsius', // optional, default fahrenheit
}
```

Call the method:

```javascript
AppleHealthKit.saveBodyTemperature(
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
96
```
