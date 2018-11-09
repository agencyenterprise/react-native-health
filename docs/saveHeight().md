save a numeric height value to Healthkit

`saveHeight` accepts an options object containing a numeric height value:
```javascript
let options = {
  value: 200 // Inches
}
```

```javascript
AppleHealthkit.saveHeight(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  // height successfully saved
});
```