# Methods list

Query statistic (aggregated) biomarkers.

| Value                                       | Methods                            |
|---------------------------------------------|------------------------------------|
| bodyMass (body weight)                      | getStatisticBodyMass               |
| bloodPressureSystolic (systolic pressure)   | getStatisticBloodPressureSystolic  |
| bloodPressureDiastolic (diastolic pressure) | getStatisticBloodPressureDiastolic |
| bloodGlucose (blood glucose)                | getStatisticBloodGlucose           |
| bodyMassIndex (body mass index)             | getStatisticBodyMassIndex          |
| height (body height)                        | getStatisticHeight                 |
| stepCount (number of steps)                 | getStatisticStepCount              |
| heartRate (pulse)                           | getStatisticHeartRate              |
| bodyTemperature (body temperature)          | getStatisticBodyTemperature        |
| oxygenSaturation (oxygen saturation)        | getStatisticOxygenSaturation       |
| restingHeartRate (resting heart rate)       | getStatisticRestingHeartRate       |
| Dietary                                     |                                    |
| energyConsumed (energy value)               | getStatisticDietaryEnergyConsumed  |
| protein (protein)                           | getStatisticDietaryProtein         |
| fiber (cellulose)                           | getStatisticDietaryFiber           |
| totalFat (fats)                             | getStatisticDietaryTotalFat        |
| water                                       | getStatisticDietaryWater (water)   |
| sugar                                       | getStatisticDietarySugar (sugar)   |
| fatSaturated                                | getStatisticDietaryFatSaturated    |
| cholesterol                                 | getStatisticDietaryCholesterol     |
| carbohydrates                               | getStatisticDietaryCarbohydrates   |
| calcium                                     | getStatisticDietaryCalcium         |
| iron                                        | getStatisticDietaryIron            |
| potassium                                   | getStatisticDietaryPotassium       |
| sodium                                      | getStatisticDietarySodium          |
| vitaminA                                    | getStatisticDietaryVitaminA        |
| vitaminC                                    | getStatisticDietaryVitaminC        |
| vitaminD                                    | getStatisticDietarySugar           |
| Lab and Test Results                        ||
| insulinDelivery (insulin delivery)          | getStatisticInsulinDelivery        |



## Example call

```typescript
let options = {
  aggregator: HealthStatisticsCommonAggregatorType.AVERAGE,
  interval: HealthStatisticsIntervalType.DAY, // optional; default HealthStatisticsIntervalType.MONTH
  unit: 'pound', // optional;
  startDate: new Date(2021, 0, 0).toISOString(), // optional
  endDate: new Date().toISOString(), // optional; default now
}
```
For dietary and insulinDelivery:
```typescript
let options: HealthStatisticsDietaryInputOptions = {
        aggregator: HealthStatisticsDietaryAggregatorType.CUMULATIVE_SUM,
        interval: HealthStatisticsIntervalType.DAY, // optional; default HealthStatisticsIntervalType.MONTH
        unit: 'calorie', // optional
        startDate: new Date(2021, 0, 0).toISOString(),
        endDate: new Date().toISOString(),
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


## Request payload

|name|type|required|
|---|---|---|
|aggregator|HealthStatisticsCommonAggregatorType or HealthStatisticsStepsAggregatorType or HealthStatisticsDietaryAggregatorType|✓|
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

export type HealthStatisticsStepsAggregatorType = GenericAggregatorsType | CumulativeAggregatorsType;

export type HealthStatisticsDietaryAggregatorType = CumulativeAggregatorsType
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
