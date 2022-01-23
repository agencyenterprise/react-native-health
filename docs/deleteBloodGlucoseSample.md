# deleteBloodGlucoseSample

Delete a blood glucose value from HealthKit.

`deleteBloodGlucoseSample` accepts an record's UUID string and a callback:

Example input object:

```javascript
let id = "ba13089a-a311-4ffe-9352-f5c568936f16"
```

Example usage:

```javascript
AppleHealthKit.deleteBloodGlucoseSample(
  id,
  (err: Object, result: number) => {
    if (err) {
      return
    }
    // blood glucose successfully deleted
    console.log(result)
  },
)
```

Example output (1 if deleted):

```json
1
```
