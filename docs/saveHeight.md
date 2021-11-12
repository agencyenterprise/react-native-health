# saveHeight

save a numeric height value to Healthkit

`saveHeight` accepts an options object containing a numeric height value:

Example input options:

```javascript
let options = {
  value: 200, // Inches
}
```

Call the method:

```javascript
AppleHealthKit.saveHeight(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err) {
      return
    }
    // height successfully saved
  },
)
```

Example output:

```json
200
```
