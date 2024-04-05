# Methods list

Query statistic (aggregated) biomarkers.

| Value                                       | Methods                                   |
|---------------------------------------------|-------------------------------------------|
| bodyMass (body weight)                      | getStatisticBodyMass                      |
| bloodPressureSystolic (systolic pressure)   | getStatisticBloodPressureSystolic         |
| bloodPressureDiastolic (diastolic pressure) | getStatisticBloodPressureDiastolic        |
| bloodGlucose (blood glucose)                | getStatisticBloodGlucose                  |
| bodyMassIndex (body mass index)             | getStatisticBodyMassIndex                 |
| height (body height)                        | getStatisticHeight                        |
| stepCount (number of steps)                 | getStatisticStepCount                     |
| heartRate (pulse)                           | getStatisticHeartRate                     |
| bodyTemperature (body temperature)          | getStatisticBodyTemperature               |
| oxygenSaturation (oxygen saturation)        | getStatisticOxygenSaturation              |
| restingHeartRate (resting heart rate)       | getStatisticRestingHeartRate              |
| Dietary                                     |                                           |
| Macronutrients                              |                                           |
| energyConsumed (energy value)               | getStatisticDietaryEnergyConsumed         |
| protein (protein)                           | getStatisticDietaryProtein                |
| fiber (cellulose)                           | getStatisticDietaryFiber                  |
| totalFat (fats)                             | getStatisticDietaryTotalFat               |
| sugar                                       | getStatisticDietarySugar (sugar)          |
| fatSaturated                                | getStatisticDietaryFatSaturated           |
| fatMonounsaturated                          | getStatisticDietaryFatMonounsaturated     |
| fatPolyunsaturated                          | getStatisticDietaryFatPolyunsaturated     |
| cholesterol                                 | getStatisticDietaryCholesterol            |
| carbohydrates                               | getStatisticDietaryCarbohydrates          |
| Vitamins                                    |                                           |
| vitaminA                                    | getStatisticDietaryVitaminA               |
| vitaminC                                    | getStatisticDietaryVitaminC               |
| vitaminD                                    | getStatisticDietaryVitaminD               |
| thiamin                                     | getStatisticDietaryThiamin                |
| riboflavin                                  | getStatisticDietaryRiboflavin             |
| niacin                                      | getStatisticDietaryNiacin                 |
| pantothenicAcid                             | getStatisticDietaryPantothenicAcid        |
| vitaminB6                                   | getStatisticDietaryVitaminB6              |
| biotin                                      | getStatisticDietaryBiotin                 |
| vitaminB12                                  | getStatisticDietaryVitaminB12             |
| vitaminE                                    | getStatisticDietaryVitaminE               |
| vitaminK                                    | getStatisticDietaryVitaminK               |
| folate                                      | getStatisticDietaryFolate                 |
| calcium                                     | getStatisticDietaryCalcium                |
| iron                                        | getStatisticDietaryIron                   |
| potassium                                   | getStatisticDietaryPotassium              |
| sodium                                      | getStatisticDietarySodium                 |
| Minerals                                    |                                           |
| calcium                                     | getStatisticDietaryCalcium                |
| chloride                                    | getStatisticDietaryChloride               |
| iron                                        | getStatisticDietaryIron                   |
| magnesium                                   | getStatisticDietaryMagnesium              |
| phosphorus                                  | getStatisticDietaryPhosphorus             |
| potassium                                   | getStatisticDietaryPotassium              |
| sodium                                      | getStatisticDietarySodium                 |
| zinc                                        | getStatisticDietaryZinc                   |
| Hydration                                   |                                           |
| water                                       | getStatisticDietaryWater                  |
| Caffeination                                |                                           |
| caffeine                                    | getStatisticDietaryCaffeine               |
| Ultratrace Minerals                         |                                           |
| chromium                                    | getStatisticDietaryChromium               |
| copper                                      | getStatisticDietaryCopper                 |
| iodine                                      | getStatisticDietaryIodine                 |
| manganese                                   | getStatisticDietaryManganese              |
| molybdenum                                  | getStatisticDietaryMolybdenum             |
| selenium                                    | getStatisticDietarySelenium               |
| Lab and Test Results                        |                                           |
| insulinDelivery (insulin delivery)          | getStatisticInsulinDelivery               |
| numberOfTimesFallen                         | getStatisticNumberOfTimesFallen           |
| peakExpiratoryFlowRate                      | getStatisticPeakExpiratoryFlowRate        |
| peripheralPerfusionIndex                    | getStatisticPeripheralPerfusionIndex      |
| Activity                                    |                                           |
| distanceWheelchair                          | getStatisticDistanceWheelchair            |
| appleExerciseTime                           | getStatisticAppleExerciseTime             |
| Body Measurments                            |                                           |
| appleSleepingWristTemperature               | getStatisticAppleSleepingWristTemperature |
| Vital Signs                                 |                                           |
| heartRateRecoveryOneMinute                  | getStatisticHeartRateRecoveryOneMinute    |
| atrialFibrillationBurden                    | getStatisticAtrialFibrillationBurden      |
| UV Exposure                                 |                                           |
| uvExposure                                  | getStatisticUvExposure                    |


## Example call

```typescript
let options = {
  aggregator: HealthStatisticsCommonAggregatorType.AVERAGE,
  interval: HealthStatisticsIntervalType.DAY, // optional; default HealthStatisticsIntervalType.MONTH
  startDate: new Date(2021, 0, 0).toISOString(), // optional
  endDate: new Date().toISOString(), // optional; default now
}
```

Method call example:

```typescript
AppleHealthKit.getStatisticBodyMass(
  options,
  (err: Object, results: Array<HealthValue>) => {
    if (err) {
      return
    }
    console.log(results)
  },
)
```
For dietary biomarkers (Macronutrients, Vitamins, Minerals, Hydration, Caffeination, Ultratrace Minerals types) could be calculated average or cumulative values.

## Request payload

|name|type|required|
|---|---|---|
|aggregator|HealthStatisticsCommonAggregatorType or HealthStatisticsStepsAggregatorType or CumulativeAggregatorsType|✓|
|interval|HealthStatisticsIntervalType||
|unit|string||
|startDate|string|✓|
|endDate|string|✓|

```typescript
enum GenericAggregatorsType {
  MIN = 0,
  MAX = 1,
  FIRST = 4,
  LAST = 5,
}

enum AverageAggregatorsType {
  AVERAGE = 2,
}

enum CumulativeAggregatorsType {
  CUMULATIVE_SUM = 3,
}

export type HealthStatisticsCommonAggregatorType = GenericAggregatorsType | AverageAggregatorsType;

export type HealthStatisticsStepsAggregatorType = GenericAggregatorsType | CumulativeAggregatorsType

```

## Response

```json
[
  {
    "value": 160,
    "startDate": "2016-07-09T00:00:00.000-0400",
    "endDate": "2016-07-10T00:00:00.000-0400"
  },
  {
    "value": 161,
    "startDate": "2016-07-08T00:00:00.000-0400",
    "endDate": "2016-07-09T00:00:00.000-0400"
  },
  {
    "value": 165,
    "startDate": "2016-07-07T00:00:00.000-0400",
    "endDate": "2016-07-08T00:00:00.000-0400"
  }
]
```
