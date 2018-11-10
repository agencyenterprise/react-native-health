query for height samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'inch', // optional; default 'inch'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10, // optional; default no limit
};
```

```javascript
AppleHealthKit.getHeightSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

The callback function will be called with a `samples` array containing objects with `value`, `startDate`, and `endDate` fields
```javascript
[
	{ value: 74.02, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400' },
	{ value: 74, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
```