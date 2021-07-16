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
  Copper
  EnergyConsumed
  FatMonounsaturated
  FatPolyunsaturated
  FatSaturated
  FatTotal
  Fiber
  Folate
  Iodine
  Iron
  Magnesium
  Manganese
  Molybdenum
  Niacin
  PantothenicAcid
  Phosphorus
  Potassium
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
  Vo2Max
  Weight
  Workout
```

## Supported Apple Permissions

The available Healthkit identifiers are supported

| Permission             | Healthkit Identifier Type                                                                                                                                           | Read | Write |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---- | ----- |
| ActiveEnergyBurned     | [HKQuantityTypeIdentifierActiveEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615771-activeenergyburned?language=objc) | ✓    |       |
| BasalEnergyBurned      | [HKQuantityTypeIdentifierBasalEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615512-basalenergyburned?language=objc)   | ✓    |       |
| BiologicalSex          | [HKCharacteristicTypeIdentifierBiologicalSex](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierbiologicalsex?language=objc)            | ✓    |       |
| BloodType    | [HKCharacteristicTypeIdentifierBloodType](https://developer.apple.com/documentation/healthkit/hkcharacteristictypeidentifierbloodtype?language=objc)            | ✓    |     |
| BloodAlcoholContent    | [HKQuantityTypeIdentifierBloodAlcoholContent](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbloodalcoholcontent?language=objc)            | ✓    | ✓     |
| BloodGlucose           | [HKQuantityTypeIdentifierBloodGlucose](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbloodglucose?language=objc)                          | ✓    |       |
| BloodPressureDiastolic | [HKQuantityTypeIdentifierBloodPressureDiastolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressurediastolic?language=objc)  | ✓    | ✓     |
| BloodPressureSystolic  | [HKQuantityTypeIdentifierBloodPressureSystolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressuresystolic?language=objc)    | ✓    | ✓     |
| BodyMassIndex          | [HKQuantityTypeIdentifierBodyMassIndex](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymassindex?language=objc)                        | ✓    | ✓     |
| BodyTemperature        | [HKQuantityTypeIdentifierBodyTemperature](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodytemperature?language=objc)                    | ✓    |       |
| DateOfBirth            | [HKCharacteristicTypeIdentifierDateOfBirth](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierdateofbirth?language=objc)                | ✓    |       |
| DistanceCycling        | [HKQuantityTypeIdentifierDistanceCycling](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancecycling?language=objc)                    | ✓    | ✓     |
| DistanceWalkingRunning | [HKQuantityTypeIdentifierDistanceWalkingRunning](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancewalkingrunning?language=objc)      | ✓    | ✓     |
| FlightsClimbed         | [HKQuantityTypeIdentifierFlightsClimbed](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierflightsclimbed?language=objc)                      | ✓    | ✓     |
| HeartbeatSeries        | [HKDataTypeIdentifierHeartbeatSeries](https://developer.apple.com/documentation/healthkit/hkdatatypeidentifierheartbeatseries?language=objc) | ✓    |       |
| HeartRate              | [HKQuantityTypeIdentifierHeartRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheartrate?language=objc)                                | ✓    |       |
| Height                 | [HKQuantityTypeIdentifierHeight](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheight?language=objc)                                      | ✓    | ✓     |
| LeanBodyMass           | [HKQuantityTypeIdentifierLeanBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierleanbodymass?language=objc)                          | ✓    | ✓     |
| MindfulSession         | [HKCategoryTypeIdentifierMindfulSession](https://developer.apple.com/reference/healthkit/hkcategorytypeidentifiermindfulsession?language=objc)                      |      | ✓     |
| RespiratoryRate        | [HKQuantityTypeIdentifierRespiratoryRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierrespiratoryrate?language=objc)                    | ✓    |       |
| SleepAnalysis          | [HKCategoryTypeIdentifierSleepAnalysis](https://developer.apple.com/reference/Healthkit/hkcategorytypeidentifiersleepanalysis?language=objc)                        | ✓    |       |
| StepCount              | [HKQuantityTypeIdentifierStepCount](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierstepcount?language=objc)                                | ✓    | ✓     |
| Steps                  | [HKQuantityTypeIdentifierSteps](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifiersteps?language=objc)                                        | ✓    | ✓     |
| Weight                 | [HKQuantityTypeIdentifierBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymass?language=objc)                                  | ✓    | ✓     |
| BodyFatPercentage      | [HKQuantityTypeIdentifierBodyFatPercentage](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodyfatpercentage?language=objc)                | ✓    | ✓     |
