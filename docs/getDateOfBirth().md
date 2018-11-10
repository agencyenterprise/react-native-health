Get the date of birth.

On success, the callback function will be provided with a `res` object containing dob `value: string` (ISO timestamp), and `age: number` (age in years):
```javascript
AppleHealthKit.getDateOfBirth(null, (err: Object, results: Object) => {
    if (this._handleHealthkitError(err, 'getDateOfBirth')) {
        return;
    }
    console.log(results)
});
```

```javascript
{
	value: '1986-09-01T00:00:00.000-0400',
	age: 29
}
```