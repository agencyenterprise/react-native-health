# getMedicationRecords

Query for clinical medication records. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getMedicationRecords(
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
    "displayName": "Albuterol HFA 90 mcg",
    "id": "8C4AE8B2-06DB-4FEB-A567-1290B93D7D9A",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "dosageInstruction": [
        {
          "text": "2 puffs every 2-4 hours"
        }
      ],
      "resourceType": "MedicationOrder",
      "dateWritten": "1985-10-11",
      "prescriber": {
        "display": "Daren Estrada",
        "reference": "Practitioner/20"
      },
      "patient": {
        "display": "Candace Salinas",
        "reference": "Patient/1"
      },
      "medicationCodeableConcept": {
        "text": "Albuterol HFA 90 mcg",
        "coding": [
          {
            "code": "329498",
            "system": "http://www.nlm.nih.gov/research/umls/rxnorm/"
          }
        ]
      },
      "id": "24",
      "note": "Please let me know if you need to use this more than three times per day",
      "status": "active"
    },
    "sourceName": "Sample Location A"
  },
  {
    "displayName": "Loratadine 10 mg",
    "id": "5A60E7CF-A52D-4BB2-85B5-26C54E93A66A",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "dosageInstruction": [
        {
          "text": "Once Daily"
        }
      ],
      "resourceType": "MedicationOrder",
      "dateWritten": "1994-02-26",
      "prescriber": {
        "display": "Daren Estrada",
        "reference": "Practitioner/20"
      },
      "patient": {
        "display": "Candace Salinas",
        "reference": "Patient/1"
      },
      "medicationCodeableConcept": {
        "text": "Loratadine 10 mg",
        "coding": [
          {
            "system": "http://www.nlm.nih.gov/research/umls/rxnorm/",
            "code": "316167",
            "display": "Loratadine 10 MG Oral Capsule"
          }
        ]
      },
      "id": "18",
      "note": "You only need to take this medication during pollen season",
      "status": "active"
    },
    "sourceName": "Sample Location A"
  }
]
```
