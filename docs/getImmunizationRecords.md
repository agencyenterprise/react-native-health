# getImmunizationRecords

Query for clinical immunization records. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getImmunizationRecords(
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
    "displayName": "Influenza",
    "id": "833A7E03-A424-4960-95E7-EF0497DBA077",
    "startDate": "2021-07-02T11:34:47.542-0400",
    "endDate": "2021-07-02T11:34:47.542-0400",
    "sourceId": "com.apple.public.health.clinical.46D9A327-17C8-487B-7679-9B06CCC09FBC",
    "fhirData": {
      "resourceType": "Immunization",
      "reported": false,
      "requester": {
        "display": "Altick Kelly",
        "reference": "Practitioner/8"
      },
      "vaccineCode": {
        "text": "Influenza",
        "coding": [
          {
            "code": "135",
            "system": "CVX"
          }
        ]
      },
      "patient": {
        "display": "Candace Salinas",
        "reference": "Patient/100"
      },
      "encounter": {
        "reference": "Encounter/129837645"
      },
      "date": "2017-10-18",
      "id": "3",
      "wasNotGiven": false,
      "status": "completed"
    },
    "sourceName": "Sample Location B"
  },
  {
    "displayName": "DTaP",
    "id": "06A36AB8-CC2F-4857-82A4-753B4597F1F4",
    "startDate": "2021-07-02T11:34:47.542-0400",
    "endDate": "2021-07-02T11:34:47.542-0400",
    "sourceId": "com.apple.public.health.clinical.46D9A327-17C8-487B-7679-9B06CCC09FBC",
    "fhirData": {
      "resourceType": "Immunization",
      "reported": false,
      "requester": {
        "display": "Altick Kelly",
        "reference": "Practitioner/8"
      },
      "vaccineCode": {
        "text": "DTaP",
        "coding": [
          {
            "code": "115",
            "system": "CVX"
          }
        ]
      },
      "patient": {
        "display": "Candace Salinas",
        "reference": "Patient/100"
      },
      "encounter": {
        "reference": "Encounter/129837645"
      },
      "date": "2017-10-18",
      "id": "19",
      "wasNotGiven": false,
      "status": "completed"
    },
    "sourceName": "Sample Location B"
  }
]
```
