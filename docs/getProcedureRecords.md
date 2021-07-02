# getProcedureRecords

Query for clinical procedure records. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getProcedureRecords(
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
    "displayName": "Appendectomy",
    "id": "DC522D97-5648-435E-8185-23303064D94F",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "code": {
        "text": "Appendectomy",
        "coding": [
          {
            "code": "80146002",
            "system": "http://snomed.info/sct"
          }
        ]
      },
      "id": "9",
      "status": "completed",
      "resourceType": "Procedure",
      "subject": {
        "display": "Candace Salinas",
        "reference": "Patient/1"
      },
      "performedDateTime": "2007-05-25"
    },
    "sourceName": "Sample Location A"
  },
  {
    "displayName": "ACL repair",
    "id": "CFEB0166-07D6-4988-9F69-7D973425F8FF",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Procedure",
      "code": {
        "text": "ACL repair",
        "coding": [
          {
            "system": "http://snomed.info/sct",
            "code": "239426007",
            "display": "Repair of anterior cruciate ligament of knee joint (procedure)"
          }
        ]
      },
      "id": "10",
      "status": "completed",
      "encounter": {
        "reference": "Encounter/2089375"
      },
      "subject": {
        "display": "Candace Salinas",
        "reference": "Patient/1"
      },
      "performedDateTime": "2014-06-09"
    },
    "sourceName": "Sample Location A"
  }
]
```
