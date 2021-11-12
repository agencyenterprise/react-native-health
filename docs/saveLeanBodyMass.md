# saveLeanBodyMass

save a numeric lean body mass value to Healthkit

`saveLeanBodyMass` accepts an options object containing a numeric weight value:

Example input options:

```javascript
let options = {
  value: 155.6, // lbs
}
```

Call the method:

```javascript
AppleHealthKit.saveLeanBodyMass(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err) {
      console.log('error saving lean body mass to Healthkit: ', err)
      return
    }
    // lean body mass successfully saved
  },
)
```

Example output:

```json
155.6
```
