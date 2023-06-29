# deleteInsulinDeliverySample

Delete a insulin delivery value from HealthKit.

`deleteInsulinDeliverySample` accepts an record's UUID string and a callback:

Example input object:

```javascript
let id = "A11E708A-63A4-42DF-B1E1-F5E2F88B6CA1"
```

Example usage:

```javascript
AppleHealthKit.deleteInsulinDeliverySample(
    id,
    (err: string, result: HealthValue) => {
        if (err) {
            console.log(err)
            return
        }
        // sample successfully deleted
      console.log(result)
    },
)
```

Example output (1 if deleted):

```json
1
```
