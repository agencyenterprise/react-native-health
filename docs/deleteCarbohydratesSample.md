# deleteCarbohydratesSample

Delete a carbohydrate value from HealthKit.

`deleteCarbohydratesSample` accepts an record's UUID string and a callback:

Example input object:

```javascript
let id = "ba13089a-a311-4ffe-9352-f5c568936f16"
```

Example usage:

```javascript
AppleHealthKit.deleteCarbohydratesSample(
  id,
  (err: Object, result: number) => {
    if (err) {
      return
    }
    // carbohydrate successfully deleted
    console.log(result)
  },
)
```

Example output (1 if deleted):

```json
1
```
