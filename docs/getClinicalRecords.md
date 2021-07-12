# getClinicalRecords

Query to get records for a given clinical type.

Example input options:

```javascript
let options = {
  startDate: new Date(2021, 0, 0).toISOString(),
  endDate: new Date().toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit: 10, // optional; default no limit
  type: 'AllergyRecord', // one of: ['AllergyRecord', 'ConditionRecord', 'CoverageRecord', 'ImmunizationRecord', 'LabResultRecord', 'MedicationRecord', 'ProcedureRecord']
}
```

Call the method:

```javascript
AppleHealthKit.getClinicalRecords(options, (err: Object, results: HealthClinicalRecord[]) => {
  if (err) {
    return
  }
  console.log(results)
});
```

Example output:

```javascript
[
  {
    "displayName": "", // Short name for the record
    "id": "54D63F66-FB1E-4DF3-852F-6D8C4648CE81",
    "startDate": "2021-07-01T15:11:09.041-0400",
    "endDate": "2021-07-01T15:11:09.041-0400",
    "sourceId": "com.apple.public.health.clinical.B0734C79-CD39-D049-84F6-CBE9A5629AB8",
    "fhirData": {} // FHIR record for the requested data type
    "fhirRelease": "DSTU2", // HKFHIRRelease
    "fhirVersion": "1.0.2", // HKFHIRVersion.stringRepresentation
  }
]
```
