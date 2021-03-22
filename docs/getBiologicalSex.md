# getBiologicalSex

Get the biological sex (gender). If the `BiologicalSex` read permission is missing or the user has denied it then the value will be `unknown`. The possible values are:

| Value   | HKBiologicalSex       |
| ------- | --------------------- |
| unknown | HKBiologicalSexNotSet |
| male    | HKBiologicalSexMale   |
| female  | HKBiologicalSexFemale |
| other   | HKBiologicalSexOther  |

```javascript
AppleHealthKit.getBiologicalSex(null, (err: Object, results: Object) => {
  if (err) {
    return
  }
  console.log(results)
})
```

Example output:

```json
{
  "value": "female"
}
```
