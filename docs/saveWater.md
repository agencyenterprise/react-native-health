# Save Water

Add a specified amount of consumed water to Healthkit

`saveWater` accepts an options object containing a numeric water value in liters.
In the example below 200 ml of water are added to Healthkit.

```javascript
let options = {
  water: 0.2 // Amount in liters
  date: (new Date(2018,10,1)).toISOString(), // Optional, time when the water amount was consumed
}
```

```javascript
AppleHealthKit.saveWater((options: Object), (err: Object, results: Object) => {
  if (err) {
    console.log('Error saving water to Healthkit: ', err)
    return
  }
  // Done
})
```
