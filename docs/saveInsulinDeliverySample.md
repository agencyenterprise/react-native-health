# saveInsulinDeliverySample

Save a insulin delivery value to HealthKit.

`saveInsulinDeliverySample` accepts an options object containing insulin sample data and a callback:

Example input object:

```javascript
let input = {
    value: 10, // IU
    startDate: '2021-03-22T16:19:00.000-0300', // Optional, defaults to now
    endDate: '2021-03-22T16:19:00.000-0300', // Optional, defaults to startDate
    metadata: {
      HKBloodGlucoseMealTime: 1, //Basal = 1, Bolus = 2
      anyOtherKey: 'some data', // supports string, number, boolean
    }
}
```

Insulin delivery samples are always in International Units.

Example usage:

```javascript
AppleHealthKit.saveInsulinDeliverySample(
  input,
  (err: Object, result: string) => {
    if (err) {
      return
    }
    // insulin delivery successfully saved
    console.log(result)
  },
)
```

Example output (record's UUID):

```json
"619E37D3-C675-4186-B6A4-395EBFC6F46D"
```
