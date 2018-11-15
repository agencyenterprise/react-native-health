Get the biological sex (gender). If the `BiologicalSex` read permission is missing or the user has denied it then the value will be `unknown`. The possible values are:

| Value   | HKBiologicalSex       |
|---------|-----------------------|
| unknown | HKBiologicalSexNotSet |
| male    | HKBiologicalSexMale   |
| female  | HKBiologicalSexFemale |
| other   | HKBiologicalSexOther  |

```javascript
AppleHealthKit.getBiologicalSex(null, (err: Object, results: Object) => {
    if (this._handleHealthkitError(err, 'getBiologicalSex')) {
      return;
    }
    console.log(results)
});
```

```javascript
{
   value: 'female',
}
```