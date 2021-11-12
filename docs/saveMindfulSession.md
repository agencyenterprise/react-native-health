# saveMindfulSession

Each mindfulness sample represents a period of time with a startDate and an endDate.
the options must contain `startDate` and `endDate`

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
}
```

Call the method:

```javascript
AppleHealthKit.saveMindfulSession(
  (options: HealthInputOptions),
  (err: Object, results: number) => {
    if (err)
      return {
        return,
      }
    // mindfullSession successfully saved
  },
)
```

Example output:

```json
0
```
