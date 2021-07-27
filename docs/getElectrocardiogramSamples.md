# getElectrocardiogramSamples

Query for Electrocardiogram (ECG) samples and their associated voltage measurements.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 1, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getElectrocardiogramSamples(
  (options: HealthInputOptions),
  (err: Object, results: ElectrocardiogramSampleValue[]) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```
 
```javascript
[
  {
    "id": "5AF5F9E0-F27E-4BD7-8DBD-B7E00B9C68CF",
    "sourceName": "ECG",
    "sourceId": "com.apple.NanoHeartRhythm",
    "startDate": "2021-06-16T19:10:52.498-0400",
    "endDate": "2021-06-16T19:11:22.499-0400",
    "classification": "SinusRhythm", // see ElectrocardiogramClassification enum
    "averageHeartRate": 62,
    "samplingFrequency": 512.6171875,
    "device": "Watch4,1",
    "algorithmVersion": 2,
    "voltageMeasurements": [
      // [timeSinceSampleStart (s), voltage (V)]
      [0, -0.000007642375469207763],
      [0.0019507734511925627, -0.000005802469730377197],
      [0.0039015469023851255, -0.000003958822011947631],
      [0.005852320353577688, -0.0000021150546073913572],
      [0.007803093804770251, -2.747770547866821e-7],
      // ...
      [29.991191038634458, -0.00003649459075927734],
      [29.99314181208565, -0.000035267024993896485],
      [29.995092585536845, -0.000033975482940673826],
      [29.997043358988037, -0.00003262416076660156],
      [29.99899413243923, -0.000031217338562011714]
    ]
  }
]

```