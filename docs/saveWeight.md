# saveWeight

save a numeric weight value to Healthkit

`saveWeight` accepts an options object containing a numeric weight value:

Example input options:

```javascript
let options = {
  value: 200,
}
```

Call the method:

```javascript
AppleHealthKit.saveWeight(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err) {
      console.log('error saving weight to Healthkit: ', err)
      return
    }
    // weight successfully saved
  },
)
```

Example output:

```json
200
```
