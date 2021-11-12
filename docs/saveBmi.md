# saveBmi

save a numeric BMI value to Healthkit

`saveBmi` accepts an options object containing a numeric BMI value:

Example input options:

```javascript
let options = {
  value: 27.2,
}
```

Call the method:

```javascript
AppleHealthKit.saveBmi(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err) {
      return
    }
    // BMI successfully saved
  },
)
```

Example output:

```json
16.7
```
