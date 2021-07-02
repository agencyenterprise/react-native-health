# getAllergyRecords

Query for clinical allergy records. The options object is used to setup a query to retrieve relevant samples.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(), // required
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
}
```

Call the method:

```javascript
AppleHealthKit.getAllergyRecords(
  options,
  (err: Object, results: HealthClinicalRecord[]) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```

Example output:

```json
[
  {
    "displayName": "Peanuts",
    "id": "54D63F66-FB1E-4DF3-852F-6D8C4648CE81",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "AllergyIntolerance",
      "recordedDate": "2015-02-18",
      "substance": {
        "text": "Peanuts",
        "coding": [
          {
            "code": "256349002",
            "system": "http://snomed.info/sct"
          }
        ]
      },
      "onset": "1995",
      "patient": {
        "display": "Candace Salinas",
        "reference": "Patient/1"
      },
      "reaction": [
        {
          "onset": "2015-02-17",
          "manifestation": [
            {
              "text": "Wheezing"
            }
          ],
          "severity": "severe"
        }
      ],
      "id": "2",
      "status": "active"
    },
    "sourceName": "Sample Location A"
  }
]
```
