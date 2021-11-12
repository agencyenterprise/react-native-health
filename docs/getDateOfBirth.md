# getDateOfBirth

Get the date of birth.

On success, the callback function will be provided with a `res` object containing dob `value: string` (ISO timestamp), and `age: number` (age in years):

```javascript
AppleHealthKit.getDateOfBirth(
  null,
  (err: Object, results: HealthDateOfBirth) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output:

```json
{
  "value": "1986-09-01T00:00:00.000-0400",
  "age": 29
}
```
