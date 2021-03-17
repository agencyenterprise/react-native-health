save a body temperature value to Healthkit

`saveBodyTemperature` accepts an options object containing a value:

```javascript
let options = {
  value: 96,
  date: new Date(2016, 5, 1).toISOString(), // optional; default now
  unit: 'celsius', // optional, default fahrenheit
}
```

```javascript
AppleHealthKit.saveBodyTemperature(
  (options: Object),
  (err: Object, results: Object) => {
    if (err) {
      return
    }
    // body fat percentage successfully saved
  },
)
```
