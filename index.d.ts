declare module 'react-native-health' {
  export interface HealthKitPermissions {
    permissions: {
      read: HealthPermission[]
      write: HealthPermission[]
    }
  }

  export interface Constants {
    Activities: HealthActivity
    Observers: HealthObserver
    Permissions: HealthPermission
    Units: HealthUnit
  }

  export interface AppleHealthKit {
    initHealthKit(
      permissions: HealthKitPermissions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    isAvailable(callback: (error: Object, results: boolean) => void): void

    getBiologicalSex(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDateOfBirth(
      options: any,
      callback: (err: string, results: HealthDateOfBirth) => void,
    ): void

    getLatestWeight(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getWeightSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveWeight(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestHeight(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getHeightSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveHeight(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestBmi(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveBmi(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestBodyFatPercentage(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getLatestLeanBodyMass(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getStepCount(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyStepCountSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveSteps(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getDistanceWalkingRunning(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceWalkingRunningSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDistanceCycling(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceCyclingSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getFlightsClimbed(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyFlightsClimbedSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveFood(
      options: Object,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveWater(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getHeartRateSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getRestingHeartRate(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getWalkingHeartRateAverage(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getActiveEnergyBurned(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBasalEnergyBurned(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getAppleExerciseTime(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getVo2MaxSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBodyTemperatureSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBloodPressureSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getRespiratoryRateSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getHeartRateVariabilitySamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getRestingHeartRateSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBloodGlucoseSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveBloodGlucoseSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getSleepSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getInfo(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getMindfulSession(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveMindfulSession(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getWorkout(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveWorkout(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getAuthStatus(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getLatestBloodAlcoholContent(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBloodAlcoholContentSamples(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveBloodAlcoholContent(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    setObserver(options: HealthObserverOptions): void

    Constants: Constants
  }

  /* Inputs and Payloads */

  export interface HealthDateOfBirth {
    value: string
    age: number
  }

  export interface HealthValue {
    value: number
    startDate: string
    endDate: string
  }

  export interface HealthUnitOptions {
    unit: HealthUnit
  }

  export interface HealthValueOptions extends HealthUnitOptions {
    value: number
    startDate?: string
    endDate?: string
    limit?: number
    ascending?: boolean
  }

  export interface HealthObserverOptions {
    type: HealthObserver
  }

  /* Health Constants */

  export enum HealthActivity {
    AmericanFootball = 'AmericanFootball',
    Archery = 'Archery',
    AustralianFootball = 'AustralianFootball',
    Badminton = 'Badminton',
    Baseball = 'Baseball',
    Basketball = 'Basketball',
    Bowling = 'Bowling',
    Boxing = 'Boxing',
    Climbing = 'Climbing',
    Cricket = 'Cricket',
    CrossTraining = 'CrossTraining',
    Curling = 'Curling',
    Cycling = 'Cycling',
    Dance = 'Dance',
    Elliptical = 'Elliptical',
    EquestrianSports = 'EquestrianSports',
    Fencing = 'Fencing',
    Fishing = 'Fishing',
    FunctionalStrengthTraining = 'FunctionalStrengthTraining',
    Golf = 'Golf',
    Gymnastics = 'Gymnastics',
    Handball = 'Handball',
    Hiking = 'Hiking',
    Hockey = 'Hockey',
    Hunting = 'Hunting',
    Lacrosse = 'Lacrosse',
    MartialArts = 'MartialArts',
    MindAndBody = 'MindAndBody',
    PaddleSports = 'PaddleSports',
    Play = 'Play',
    PreparationAndRecovery = 'PreparationAndRecovery',
    Racquetball = 'Racquetball',
    Rowing = 'Rowing',
    Rugby = 'Rugby',
    Running = 'Running',
    Sailing = 'Sailing',
    SkatingSports = 'SkatingSports',
    SnowSports = 'SnowSports',
    Soccer = 'Soccer',
    Softball = 'Softball',
    Squash = 'Squash',
    StairClimbing = 'StairClimbing',
    SurfingSports = 'SurfingSports',
    Swimming = 'Swimming',
    TableTennis = 'TableTennis',
    Tennis = 'Tennis',
    TrackAndField = 'TrackAndField',
    TraditionalStrengthTraining = 'TraditionalStrengthTraining',
    Volleyball = 'Volleyball',
    Walking = 'Walking',
    WaterFitness = 'WaterFitness',
    WaterPolo = 'WaterPolo',
    WaterSports = 'WaterSports',
    Wrestling = 'Wrestling',
    Yoga = 'Yoga',
    Barre = 'Barre',
    CoreTraining = 'CoreTraining',
    CrossCountrySkiing = 'CrossCountrySkiing',
    DownhillSkiing = 'DownhillSkiing',
    Flexibility = 'Flexibility',
    HighIntensityIntervalTraining = 'HighIntensityIntervalTraining',
    JumpRope = 'JumpRope',
    Kickboxing = 'Kickboxing',
    Pilates = 'Pilates',
    Snowboarding = 'Snowboarding',
    Stairs = 'Stairs',
    StepTraining = 'StepTraining',
    WheelchairWalkPace = 'WheelchairWalkPace',
    WheelchairRunPace = 'WheelchairRunPace',
    TaiChi = 'TaiChi',
    MixedCardio = 'MixedCardio',
    HandCycling = 'HandCycling',
  }

  export enum HealthPermission {
    ActiveEnergyBurned = 'ActiveEnergyBurned',
    AppleExerciseTime = 'AppleExerciseTime',
    BasalEnergyBurned = 'BasalEnergyBurned',
    BiologicalSex = 'BiologicalSex',
    BloodAlcoholContent = 'BloodAlcoholContent',
    BloodGlucose = 'BloodGlucose',
    BloodPressureDiastolic = 'BloodPressureDiastolic',
    BloodPressureSystolic = 'BloodPressureSystolic',
    BodyFatPercentage = 'BodyFatPercentage',
    BodyMass = 'BodyMass',
    BodyMassIndex = 'BodyMassIndex',
    BodyTemperature = 'BodyTemperature',
    DateOfBirth = 'DateOfBirth',
    Biotin = 'Biotin',
    Caffeine = 'Caffeine',
    Calcium = 'Calcium',
    Carbohydrates = 'Carbohydrates',
    Chloride = 'Chloride',
    Cholesterol = 'Cholesterol',
    Copper = 'Copper',
    EnergyConsumed = 'EnergyConsumed',
    FatMonounsaturated = 'FatMonounsaturated',
    FatPolyunsaturated = 'FatPolyunsaturated',
    FatSaturated = 'FatSaturated',
    FatTotal = 'FatTotal',
    Fiber = 'Fiber',
    Folate = 'Folate',
    Iodine = 'Iodine',
    Iron = 'Iron',
    Magnesium = 'Magnesium',
    Manganese = 'Manganese',
    Molybdenum = 'Molybdenum',
    Niacin = 'Niacin',
    PantothenicAcid = 'PantothenicAcid',
    Phosphorus = 'Phosphorus',
    Potassium = 'Potassium',
    Protein = 'Protein',
    Riboflavin = 'Riboflavin',
    Selenium = 'Selenium',
    Sodium = 'Sodium',
    Sugar = 'Sugar',
    Thiamin = 'Thiamin',
    VitaminA = 'VitaminA',
    VitaminB12 = 'VitaminB12',
    VitaminB6 = 'VitaminB6',
    VitaminC = 'VitaminC',
    VitaminD = 'VitaminD',
    VitaminE = 'VitaminE',
    VitaminK = 'VitaminK',
    Zinc = 'Zinc',
    Water = 'Water',
    DistanceCycling = 'DistanceCycling',
    DistanceWalkingRunning = 'DistanceWalkingRunning',
    FlightsClimbed = 'FlightsClimbed',
    HeartRate = 'HeartRate',
    RestingHeartRate = 'RestingHeartRate',
    HeartRateVariability = 'HeartRateVariability',
    Height = 'Height',
    LeanBodyMass = 'LeanBodyMass',
    MindfulSession = 'MindfulSession',
    NikeFuel = 'NikeFuel',
    RespiratoryRate = 'RespiratoryRate',
    SleepAnalysis = 'SleepAnalysis',
    StepCount = 'StepCount',
    Steps = 'Steps',
    Vo2Max = 'Vo2Max',
    Weight = 'Weight',
    Workout = 'Workout',
  }

  export enum HealthUnit {
    bpm = 'bpm',
    calorie = 'calorie',
    celsius = 'celsius',
    count = 'count',
    day = 'day',
    fahrenheit = 'fahrenheit',
    foot = 'foot',
    gram = 'gram',
    hour = 'hour',
    inch = 'inch',
    joule = 'joule',
    meter = 'meter',
    mgPerdL = 'mgPerdL',
    mile = 'mile',
    minute = 'minute',
    mmhg = 'mmhg',
    mmolPerL = 'mmolPerL',
    percent = 'percent',
    pound = 'pound',
    second = 'second',
  }

  export enum HealthObserver {
    Cycling = 'Cycling',
    HeartRate = 'HeartRate',
    RestingHeartRate = 'RestingHeartRate',
    Running = 'Running',
    StairClimbing = 'StairClimbing',
    Walking = 'Walking',
    Workout = 'Workout',
  }

  const appleHealthKit: AppleHealthKit

  export default appleHealthKit
}
