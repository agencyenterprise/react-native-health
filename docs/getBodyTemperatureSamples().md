Query for body temperature samples. the options object is used to setup a query to retrieve relevant samples.

```javascript
let options = {
  unit: 'celsius', // optional; default 'celsius'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10,	// optional; default no limit
};
```
Available units are: `'fahrenheit'`, `'celsius'`.

The callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields.

```javascript
AppleHealthKit.getBodyTemperatureSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
		return;
	}
	console.log(results)
});
```

```javascript
[
	{ value: 74.02, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400' },
	{ value: 74, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
```