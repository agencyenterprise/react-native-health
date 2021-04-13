# getBloodType

Get the blood type. If the `BloodType` read permission is missing or the user has denied it then the value will be `unknown`. The possible values are:

| Value   | HKBiologicalSex       |
| ------- | --------------------- |
| unknown | HKBloodTypeNotSet     |
| A+      | HKBloodTypeAPositive  |
| A-      | HKBloodTypeANegative  |
| B+      | HKBloodTypeBPositive  |
| B-      | HKBloodTypeBNegative  |
| AB+     | HKBloodTypeABPositive |
| AB-     | HKBloodTypeABNegative |
| O+      | HKBloodTypeOPositive  |
| O+      | HKBloodTypeONegative  |

```javascript
AppleHealthKit.getBloodType(null, (err: Object, results: Object) => {
  if (err) {
    return
  }
  console.log(results)
})
```

Example output:

```json
{
  "value": "A-"
}
```
