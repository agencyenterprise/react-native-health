# getInsulinDeliverySamples

Query for insulin delivery samples. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Insulin delivery samples are always in International Units.

```javascript
AppleHealthKit.getInsulinDeliverySamples(
    options,
    (callbackError: string, results: HealthValue[]) => {
        console.log(results)
    },
);
```

Example output:

```json
[
  {
    "id": "8DE6A905-02B7-41D2-BB6E-67D1DD82DD6F", // The universally unique identifier (UUID) for this HealthKit object.
    "endDate": "2021-03-22T16:19:00.000-0300",
    "sourceId": "com.apple.Health",
    "sourceName": "Health",
    "startDate": "2021-03-22T16:19:00.000-0300",
    "value": 5,
    "metadata": {
      "HKWasUserEntered": true,
      "HKInsulinDeliveryReason": 2, // Basal = 1, Bolus = 2
    }
  }
]
```