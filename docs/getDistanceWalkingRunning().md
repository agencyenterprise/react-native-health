Get the total distance walking/running on a specific day.

`getDistanceWalkingRunning` accepts an options object containing optional *`date: ISO8601Timestamp`* and *`unit: string`*. If `date` is not provided it will default to the current time. `unit` defaults to `meter`.

```javascript
let options = {
  unit: 'mile', // optional; default 'meter'
  date: (new Date(2016,5,1)).toISOString(), // optional; default now
};
```

```javascript
AppleHealthKit.getDistanceWalkingRunning(options: Object, (err: Object, results: Object) => {
    if (err) {
    	return;
    }
    console.log(results)
});
```

```javascript
{
	value: 1.45,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```