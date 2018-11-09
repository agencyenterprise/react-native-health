Each mindfulness sample represents a period of time with a startDate and an endDate.
the options must contain `startDate` and `endDate`

```javascript
let options = {
    startDate: (new Date(2016,10,1)).toISOString(), // required
    endDate: (new Date()).toISOString(), // optional; default now
};

```

```
AppleHealthKit.saveMindfulSession(options, (err, res) => {
  if (err) return {
    return
  }
  console.log('Mindful session saved')
});
```