# getConditionRecords

Query for clinical condition records. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getConditionRecords(
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
    "displayName": "Asthma",
    "id": "EF8F1C8A-42C2-4545-858C-22E5AA2CCD8A",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Condition",
      "verificationStatus": "confirmed",
      "patient": {
        "display": "Salinas, Candace",
        "reference": "Patient/1"
      },
      "notes": "2 brief hospitalizations when a child, symptoms much improved as an adult",
      "id": "1",
      "code": {
        "text": "Asthma",
        "coding": [
          {
            "system": "http://snomed.info/sct",
            "code": "195967001",
            "display": "Asthma"
          }
        ]
      },
      "dateRecorded": "2012-01-02",
      "clinicalStatus": "active",
      "onsetDateTime": "1985-09-09",
      "category": {
        "coding": [
          {
            "code": "diagnosis",
            "system": "http://hl7.org/fhir/condition-category"
          }
        ]
      },
      "asserter": {
        "display": "Daren Estrada",
        "reference": "Practitioner/20"
      }
    },
    "sourceName": "Sample Location A"
  },
  {
    "displayName": "Seasonal Allergic Rhinitis",
    "id": "84397423-4872-4092-A2BD-A28CAED3E9FF",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Condition",
      "verificationStatus": "confirmed",
      "patient": {
        "reference": "Patient/1"
      },
      "notes": "Worse when visiting family in NC during the spring",
      "id": "2",
      "code": {
        "text": "Seasonal Allergic Rhinitis",
        "coding": [
          {
            "system": "http://snomed.info/sct",
            "code": "367498001",
            "display": "Seasonal allergic rhinitis"
          }
        ]
      },
      "dateRecorded": "2012-01-02",
      "clinicalStatus": "active",
      "onsetDateTime": "1994-05-12",
      "category": {
        "coding": [
          {
            "code": "diagnosis",
            "system": "http://hl7.org/fhir/condition-category"
          }
        ]
      },
      "asserter": {
        "display": "Daren Estrada",
        "reference": "Practitioner/20"
      }
    },
    "sourceName": "Sample Location A"
  },
  {
    "displayName": "Sinusitis",
    "id": "B6A1D80D-EF75-41A5-AD61-A1FC20869FF2",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Condition",
      "verificationStatus": "confirmed",
      "patient": {
        "display": "Candace Salinas",
        "reference": "Patient/1"
      },
      "id": "4",
      "code": {
        "text": "Sinusitis",
        "coding": [
          {
            "system": "http://snomed.info/sct",
            "code": "36971009",
            "display": "Sinusitis (disorder)"
          }
        ]
      },
      "dateRecorded": "2016-11-25",
      "clinicalStatus": "active",
      "category": {
        "coding": [
          {
            "code": "diagnosis",
            "system": "http://hl7.org/fhir/condition-category"
          }
        ]
      },
      "asserter": {
        "display": "Daren Estrada",
        "reference": "Practitioner/20"
      }
    },
    "sourceName": "Sample Location A"
  }
]
```
