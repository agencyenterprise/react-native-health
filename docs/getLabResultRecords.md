# getLabResultRecords

Query for clinical lab result records. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getLabResultRecords(
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
    "displayName": "Triglycerides",
    "id": "9A4C1D6A-84D6-4B14-A8C3-39B854BAC8E4",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Observation",
      "valueQuantity": {
        "code": "mg/dL",
        "system": "http://unitsofmeasure.org",
        "value": 86,
        "unit": "mg/dL"
      },
      "encounter": {
        "reference": "Encounter/355"
      },
      "referenceRange": [
        {
          "low": {
            "unit": "mg/dL",
            "value": 10,
            "system": "http://unitsofmeasure.org",
            "code": "mg/dL"
          },
          "high": {
            "unit": "mg/dL",
            "value": 250,
            "system": "http://unitsofmeasure.org",
            "code": "mg/dL"
          },
          "text": "10 to 250 mg/dL"
        }
      ],
      "code": {
        "text": "Triglycerides",
        "coding": [
          {
            "code": "3043-7",
            "system": "http://loinc.org"
          }
        ]
      },
      "id": "12",
      "status": "final",
      "issued": "2017-03-18T00:00:00Z",
      "category": {
        "text": "Laboratory",
        "coding": [
          {
            "code": "laboratory",
            "system": "http://hl7.org/fhir/observation-category"
          }
        ]
      }
    },
    "sourceName": "Sample Location A"
  },
  {
    "displayName": "Cholesterol HDL",
    "id": "99AB5C82-47E2-41F5-A5A8-24FB5B0D0969",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Observation",
      "valueQuantity": {
        "code": "mg/dL",
        "system": "http://unitsofmeasure.org",
        "value": 53.5,
        "unit": "mg/dL"
      },
      "encounter": {
        "reference": "Encounter/355"
      },
      "referenceRange": [
        {
          "low": {
            "unit": "mg/dL",
            "value": 35,
            "system": "http://unitsofmeasure.org",
            "code": "mg/dL"
          },
          "high": {
            "unit": "mg/dL",
            "value": 59,
            "system": "http://unitsofmeasure.org",
            "code": "mg/dL"
          },
          "text": "35 to 59 mg/dL"
        }
      ],
      "code": {
        "text": "Cholesterol HDL",
        "coding": [
          {
            "code": "2085-9",
            "system": "http://loinc.org"
          }
        ]
      },
      "id": "21",
      "status": "final",
      "issued": "2017-03-18T00:00:00Z",
      "category": {
        "text": "Laboratory",
        "coding": [
          {
            "code": "laboratory",
            "system": "http://hl7.org/fhir/observation-category"
          }
        ]
      }
    },
    "sourceName": "Sample Location A"
  }
]
```
