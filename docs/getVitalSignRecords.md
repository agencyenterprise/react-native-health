# getVitalSignRecords

Query for clinical vital sign records. The options object is used to setup a query to retrieve relevant samples.

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
AppleHealthKit.getVitalSignRecords(
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
    "displayName": "BMI-body mass index",
    "id": "27244E1E-6A72-4D41-BC12-3E6F722D124E",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Observation",
      "valueQuantity": {
        "code": "kg/m^2",
        "system": "http://unitsofmeasure.org",
        "value": 26.2,
        "unit": "kg/m^2"
      },
      "encounter": {
        "reference": "Encounter/355"
      },
      "code": {
        "text": "BMI-body mass index",
        "coding": [
          {
            "code": "39156-5",
            "system": "http://loinc.org"
          }
        ]
      },
      "id": "4",
      "status": "final",
      "subject": {
        "reference": "Patient/1"
      },
      "issued": "2017-03-18T00:00:00Z",
      "category": {
        "text": "Vital Signs",
        "coding": [
          {
            "code": "vital-signs",
            "system": "http://hl7.org/fhir/observation-category"
          }
        ]
      }
    },
    "sourceName": "Sample Location A"
  },
  {
    "displayName": "Temperature",
    "id": "E8D68145-8F57-4028-8B3B-5626468B4421",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Observation",
      "valueQuantity": {
        "code": "Cel",
        "system": "http://unitsofmeasure.org",
        "value": 37.6,
        "unit": "Cel"
      },
      "encounter": {
        "reference": "Encounter/355"
      },
      "code": {
        "text": "Temperature",
        "coding": [
          {
            "code": "8310-5",
            "system": "http://loinc.org"
          }
        ]
      },
      "id": "14",
      "status": "final",
      "subject": {
        "reference": "Patient/1"
      },
      "issued": "2017-03-18T00:00:00Z",
      "category": {
        "text": "Vital Signs",
        "coding": [
          {
            "code": "vital-signs",
            "system": "http://hl7.org/fhir/observation-category"
          }
        ]
      }
    },
    "sourceName": "Sample Location A"
  },
  {
    "displayName": "Pulse",
    "id": "B7E7C6C8-9D3D-4018-A9DB-012A0A18DB9E",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {
      "resourceType": "Observation",
      "valueQuantity": {
        "code": "/min",
        "system": "http://unitsofmeasure.org",
        "value": 77,
        "unit": "/min"
      },
      "encounter": {
        "reference": "Encounter/355"
      },
      "code": {
        "text": "Pulse",
        "coding": [
          {
            "code": "8867-4",
            "system": "http://loinc.org"
          }
        ]
      },
      "id": "7",
      "status": "final",
      "subject": {
        "reference": "Patient/1"
      },
      "issued": "2017-03-18T00:00:00Z",
      "category": {
        "text": "Vital Signs",
        "coding": [
          {
            "code": "vital-signs",
            "system": "http://hl7.org/fhir/observation-category"
          }
        ]
      }
    },
    "sourceName": "Sample Location A"
  }
]
```
