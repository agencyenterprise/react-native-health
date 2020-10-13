# Save Water

Save a specified amount consumed water to Healthkit

`saveWater` accepts an options object containing a numeric water value in liters. 
In the example below 200 ml of water are added to Healthkit.
```javascript
let options = {
  water: 0.2 // Amount in liters
}
```

```javascript
AppleHealthKit.saveWater(options: Object, (err: Object, results: Object) => {
    if (err) {
        console.log("Error saving water to Healthkit: ", err);
        return;
    }
    // Done
});
```
