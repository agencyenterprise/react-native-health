# Permissions

These permissions are exported as constants of the `react-native-health` module.

```typescript
import AppleHealthKit, { HealthValue, HealthKitPermissions } from 'react-native-health';

/* Permission options */
const permissions = {
  permissions: {
    read: [
      AppleHealthKit.Constants.Permissions.HeartRate,
    ],
    write: [
      AppleHealthKit.Constants.Permissions.Steps,
    ],
  }
} as HealthKitPermissions


AppleHealthKit.initHealthKit(permissions, (error: string) => {
  /* Called after we receive a response from the system */
```

## Available Permissions

```
  ActiveEnergyBurned
  ActivitySummary
  AllergyRecord
  AppleExerciseTime
  AppleStandTime
  BasalEnergyBurned
  BiologicalSex
  BloodType
  BloodAlcoholContent
  BloodGlucose
  BloodPressureDiastolic
  BloodPressureSystolic
  BodyFatPercentage
  BodyMass
  BodyMassIndex
  BodyTemperature
  DateOfBirth
  Biotin
  Caffeine
  Calcium
  Carbohydrates
  Chloride
  Cholesterol
  ConditionRecord
  Copper
  CoverageRecord
  Electrocardiogram
  EnergyConsumed
  EnvironmentalAudioExposure
  FatMonounsaturated
  FatPolyunsaturated
  FatSaturated
  FatTotal
  Fiber
  Folate
  HeadphoneAudioExposure
  ImmunizationRecord
  Iodine
  Iron
  LabResultRecord
  Magnesium
  Manganese
  MedicationRecord
  Molybdenum
  Niacin
  PantothenicAcid
  Phosphorus
  Potassium
  ProcedureRecord
  Protein
  Riboflavin
  Selenium
  Sodium
  Sugar
  Thiamin
  VitaminA
  VitaminB12
  VitaminB6
  VitaminC
  VitaminD
  VitaminE
  VitaminK
  Zinc
  Water
  DistanceCycling
  DistanceSwimming
  DistanceWalkingRunning
  FlightsClimbed
  HeartbeatSeries
  HeartRate
  RestingHeartRate
  HeartRateVariability
  Height
  LeanBodyMass
  MindfulSession
  NikeFuel
  RespiratoryRate
  SleepAnalysis
  StepCount
  Steps
  VitalSignRecord
  Vo2Max
  WalkingHeartRateAverage
  Weight
  Workout
```

## Supported Apple Permissions

The available Healthkit identifiers are supported

| Permission             | Healthkit Identifier Type                                                                                                                                           | Read | Write |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---- | ----- |
| ActiveEnergyBurned     | [HKQuantityTypeIdentifierActiveEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615771-activeenergyburned?language=objc) | ✓    |       |
| ActivitySummary        | [HKActivitySummaryType](https://developer.apple.com/documentation/healthkit/hkactivitysummarytype?language=objc) | ✓    |       |
| AllergyRecord          | [HKClinicalTypeIdentifierAllergyRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifierallergyrecord?language=objc) | ✓    |       |
| BasalEnergyBurned      | [HKQuantityTypeIdentifierBasalEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615512-basalenergyburned?language=objc)   | ✓    |       |
| BiologicalSex          | [HKCharacteristicTypeIdentifierBiologicalSex](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierbiologicalsex?language=objc)            | ✓    |       |
| BloodType    | [HKCharacteristicTypeIdentifierBloodType](https://developer.apple.com/documentation/healthkit/hkcharacteristictypeidentifierbloodtype?language=objc)            | ✓    |     |
| BloodAlcoholContent    | [HKQuantityTypeIdentifierBloodAlcoholContent](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbloodalcoholcontent?language=objc)            | ✓    | ✓     |
| BloodGlucose           | [HKQuantityTypeIdentifierBloodGlucose](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbloodglucose?language=objc)                          | ✓    |       |
| BloodPressureDiastolic | [HKQuantityTypeIdentifierBloodPressureDiastolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressurediastolic?language=objc)  | ✓    | ✓     |
| BloodPressureSystolic  | [HKQuantityTypeIdentifierBloodPressureSystolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressuresystolic?language=objc)    | ✓    | ✓     |
| BodyFatPercentage      | [HKQuantityTypeIdentifierBodyFatPercentage](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodyfatpercentage?language=objc)                | ✓    | ✓     |
| BodyMassIndex          | [HKQuantityTypeIdentifierBodyMassIndex](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymassindex?language=objc)                        | ✓    | ✓     |
| BodyTemperature        | [HKQuantityTypeIdentifierBodyTemperature](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodytemperature?language=objc)                    | ✓    |       |
| ConditionRecord        | [HKClinicalTypeIdentifierConditionRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifierconditionrecord?language=objc) | ✓    |       |
| CoverageRecord         | [HKClinicalTypeIdentifierCoverageRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifiercoveragerecord?language=objc) | ✓    |       |
| DateOfBirth            | [HKCharacteristicTypeIdentifierDateOfBirth](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierdateofbirth?language=objc)                | ✓    |       |
| DistanceCycling        | [HKQuantityTypeIdentifierDistanceCycling](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancecycling?language=objc)                    | ✓    | ✓     |
| DistanceWalkingRunning | [HKQuantityTypeIdentifierDistanceWalkingRunning](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancewalkingrunning?language=objc)      | ✓    | ✓     |
| Electrocardiogram | [HKObjectType.electrocardiogramType](https://developer.apple.com/documentation/healthkit/hkobjecttype/3552035-electrocardiogramtype?language=objc)      | ✓    |      |
| EnvironmentalAudioExposure | [HKQuantityTypeIdentifierEnvironmentalAudioExposure](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierenvironmentalaudioexposure?language=objc)                | ✓    |      |
| FlightsClimbed         | [HKQuantityTypeIdentifierFlightsClimbed](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierflightsclimbed?language=objc)                      | ✓    | ✓     |
| HeadphoneAudioExposure | [HKQuantityTypeIdentifierHeadphoneAudioExposure](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierheadphoneaudioexposure?language=objc)                | ✓    |      |
| HeartbeatSeries        | [HKDataTypeIdentifierHeartbeatSeries](https://developer.apple.com/documentation/healthkit/hkdatatypeidentifierheartbeatseries?language=objc) | ✓    |       |
| HeartRate              | [HKQuantityTypeIdentifierHeartRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheartrate?language=objc)                                | ✓    |       |
| Height                 | [HKQuantityTypeIdentifierHeight](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheight?language=objc)                                      | ✓    | ✓     |
| ImmunizationRecord     | [HKClinicalTypeIdentifierImmunizationRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifierimmunizationrecord?language=objc) | ✓    |       |
| LabResultRecord        | [HKClinicalTypeIdentifierLabResultRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifierlabresultrecord?language=objc) | ✓    |       |
| LeanBodyMass           | [HKQuantityTypeIdentifierLeanBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierleanbodymass?language=objc)                          | ✓    | ✓     |
| MindfulSession         | [HKCategoryTypeIdentifierMindfulSession](https://developer.apple.com/reference/healthkit/hkcategorytypeidentifiermindfulsession?language=objc)                      |      | ✓     |
| MedicationRecord       | [HKClinicalTypeIdentifierMedicationRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifiermedicationrecord?language=objc) | ✓    |       |
| ProcedureRecord        | [HKClinicalTypeIdentifierProcedureRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifierprocedurerecord?language=objc) | ✓    |       |
| RespiratoryRate        | [HKQuantityTypeIdentifierRespiratoryRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierrespiratoryrate?language=objc)                    | ✓    |       |
| SleepAnalysis          | [HKCategoryTypeIdentifierSleepAnalysis](https://developer.apple.com/reference/Healthkit/hkcategorytypeidentifiersleepanalysis?language=objc)                        | ✓    |       |
| StepCount              | [HKQuantityTypeIdentifierStepCount](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierstepcount?language=objc)                                | ✓    | ✓     |
| Steps                  | [HKQuantityTypeIdentifierSteps](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifiersteps?language=objc)                                        | ✓    | ✓     |
| VitalSignRecord        | [HKClinicalTypeIdentifierVitalSignRecord](https://developer.apple.com/documentation/healthkit/hkclinicaltypeidentifiervitalsignrecord?language=objc) | ✓    |       |
| Weight                 | [HKQuantityTypeIdentifierBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymass?language=objc)                                  | ✓    | ✓     |
| BodyFatPercentage      | [HKQuantityTypeIdentifierBodyFatPercentage](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodyfatpercentage?language=objc)                | ✓    | ✓     |
| WalkingHeartRateAverage | [HKQuantityTypeIdentifierWalkingHeartRateAverage](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierwalkingheartrateaverage?language=objc)                | ✓    |      |
