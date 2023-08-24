import { NativeModules } from 'react-native'
const { RNHealthKitWrapper } = NativeModules

interface RNHealthKit {
  initHealthKit(
    read: HealthType[],
    write: HealthType[],
  ): Promise<boolean>;

  getQuantitySamples(
    query: QuantitySamplesQuery
  ): Promise<QuantitySample[]>;

  saveQuantitySample(
    type: HealthType,
    sample: QuantitySample
  ): Promise<boolean>;

  getQuantitySamplesStatistics(
    query: QuantitySamplesStatisticsQuery
  ): Promise<QuantitySamplesStatistics[]>;
}

export interface QuantitySamplesQuery {
  type: HealthType;
  startDate?: string;
  endDate?: string;
  isUserEntered?: boolean;
  unit: HealthUnit | string;
  limit?: number;
}

export interface QuantitySample {
  startDate: string;
  endDate: string;
  value: number;
  unit?: HealthUnit | string;
  metadata?: Object;
}

export interface QuantitySamplesStatisticsQuery {
  type: HealthType;
  startDate: string;
  endDate: string;
  interval?: Interval;
  anchorDate?: string;
  unit: HealthUnit | string;
  StatisticsOption: StatisticsOption;
}

export interface QuantitySamplesStatistics {
  startDate: string;
  endDate: string;
  value: number;
}

export enum Interval {
  Hour = 'hour',
  Day = 'day',
  Week = 'week',
  Month = 'month',
  Year = 'year',
}

export enum StatisticsOption {
  DiscreteAverage = 'discreteAverage',
  DiscreteMin = 'discreteMin',
  DiscreteMax = 'discreteMax',
  CumulativeSum = 'cumulativeSum',
  MostRecent = 'mostRecent',
  Duration = 'duration',
}

export enum HealthType {
  BasalBodyTemperature = 'BasalBodyTemperature',
  BloodAlcoholContent = 'BloodAlcoholContent',
  BloodGlucose = 'BloodGlucose',
  BloodPressureDiastolic = 'BloodPressureDiastolic',
  BloodPressureSystolic = 'BloodPressureSystolic',
  BodyFatPercentage = 'BodyFatPercentage',
  BodyMass = 'BodyMass',
  BodyMassIndex = 'BodyMassIndex',
  BodyTemperature = 'BodyTemperature',
  ElectrodermalActivity = 'ElectrodermalActivity',
  ForcedExpiratoryVolume1 = 'ForcedExpiratoryVolume1',
  ForcedVitalCapacity = 'ForcedVitalCapacity',
  HeartRate = 'HeartRate',
  HeartRateVariabilitySDNN = 'HeartRateVariabilitySDNN',
  Height = 'Height',
  LeanBodyMass = 'LeanBodyMass',
  OxygenSaturation = 'OxygenSaturation',
  PeakExpiratoryFlowRate = 'PeakExpiratoryFlowRate',
  PeripheralPerfusionIndex = 'PeripheralPerfusionIndex',
  RestingHeartRate = 'RestingHeartRate',
  RespiratoryRate = 'RespiratoryRate',
  UVExposure = 'UVExposure',
  VO2Max = 'VO2Max',
  WaistCircumference = 'WaistCircumference',
  WalkingHeartRateAverage = 'WalkingHeartRateAverage',

  SixMinuteWalkTestDistance = 'SixMinuteWalkTestDistance',
  StairAscentSpeed = 'StairAscentSpeed',
  StairDescentSpeed = 'StairDescentSpeed',
  WalkingSpeed = 'WalkingSpeed',
  WalkingDoubleSupportPercentage = 'WalkingDoubleSupportPercentage',
  WalkingAsymmetryPercentage = 'WalkingAsymmetryPercentage',
  WalkingStepLength = 'WalkingStepLength',

  AppleWalkingSteadiness = 'AppleWalkingSteadiness',

  AppleSleepingWristTemperature = 'AppleSleepingWristTemperature',
  AtrialFibrillationBurden = 'AtrialFibrillationBurden',
  HeartRateRecoveryOneMinute = 'HeartRateRecoveryOneMinute',
  RunningGroundContactTime = 'RunningGroundContactTime',
  RunningPower = 'RunningPower',
  RunningSpeed = 'RunningSpeed',
  RunningStrideLength = 'RunningStrideLength',
  RunningVerticalOscillation = 'RunningVerticalOscillation',
  UnderwaterDepth = 'UnderwaterDepth',
  WaterTemperature = 'WaterTemperature',

  // Cumulative
  ActiveEnergyBurned = 'ActiveEnergyBurned',
  AppleExerciseTime = 'AppleExerciseTime',
  BasalEnergyBurned = 'BasalEnergyBurned',
  DietaryBiotin = 'DietaryBiotin',
  DietaryCalcium = 'DietaryCalcium',
  DietaryCaffeine = 'DietaryCaffeine',
  DietaryCarbohydrates = 'DietaryCarbohydrates',
  DietaryChloride = 'DietaryChloride',
  DietaryCholesterol = 'DietaryCholesterol',
  DietaryChromium = 'DietaryChromium',
  DietaryCopper = 'DietaryCopper',
  DietaryEnergyConsumed = 'DietaryEnergyConsumed',
  DietaryFiber = 'DietaryFiber',
  DietaryFatMonounsaturated = 'DietaryFatMonounsaturated',
  DietaryFatPolyunsaturated = 'DietaryFatPolyunsaturated',
  DietaryFatSaturated = 'DietaryFatSaturated',
  DietaryFatTotal = 'DietaryFatTotal',
  DietaryFolate = 'DietaryFolate',
  DietaryIron = 'DietaryIron',
  DietaryIodine = 'DietaryIodine',
  DietaryMagnesium = 'DietaryMagnesium',
  DietaryManganese = 'DietaryManganese',
  DietaryMolybdenum = 'DietaryMolybdenum',
  DietaryNiacin = 'DietaryNiacin',
  DietaryPantothenicAcid = 'DietaryPantothenicAcid',
  DietaryPhosphorus = 'DietaryPhosphorus',
  DietaryPotassium = 'DietaryPotassium',
  DietaryProtein = 'DietaryProtein',
  DietaryRiboflavin = 'DietaryRiboflavin',
  DietarySelenium = 'DietarySelenium',
  DietarySodium = 'DietarySodium',
  DietarySugar = 'DietarySugar',
  DietaryThiamin = 'DietaryThiamin',
  DietaryVitaminA = 'DietaryVitaminA',
  DietaryVitaminB12 = 'DietaryVitaminB12',
  DietaryVitaminB6 = 'DietaryVitaminB6',
  DietaryVitaminC = 'DietaryVitaminC',
  DietaryVitaminD = 'DietaryVitaminD',
  DietaryVitaminE = 'DietaryVitaminE',
  DietaryVitaminK = 'DietaryVitaminK',
  DietaryWater = 'DietaryWater',
  DietaryZinc = 'DietaryZinc',
  DistanceCycling = 'DistanceCycling',
  DistanceDownhillSnowSports = 'DistanceDownhillSnowSports',
  DistanceSwimming = 'DistanceSwimming',
  DistanceWalkingRunning = 'DistanceWalkingRunning',
  DistanceWheelchair = 'DistanceWheelchair',
  FlightsClimbed = 'FlightsClimbed',
  InhalerUsage = 'InhalerUsage',
  InsulinDelivery = 'InsulinDelivery',
  NikeFuel = 'NikeFuel',
  NumberOfTimesFallen = 'NumberOfTimesFallen',
  PushCount = 'PushCount',
  StepCount = 'StepCount',
  SwimmingStrokeCount = 'SwimmingStrokeCount',

  AppleStandTime = 'AppleStandTime',

  AppleMoveTime = 'AppleMoveTime',

  NumberOfAlcoholicBeverages = 'NumberOfAlcoholicBeverages',

  // Continuous
  EnvironmentalAudioExposure = 'EnvironmentalAudioExposure',

  HeadphoneAudioExposure = 'HeadphoneAudioExposure',
}

export enum HealthUnit {
  Grams = 'g',
  Kilograms = 'kg',
  Milligrams = 'mg',
  Micrograms = 'mcg',

  Meter = 'm',
  Milimeter = 'mm',
  Centimeter = 'cm',
  Decimeter = 'dm',
  Kilometer = 'km',

  Liter = 'l',
  Mililiter = 'ml',
  Centiliter = 'cl',
  Deciliter = 'dl',

  Pascal = 'Pa',
  Hectopascal = 'hPa',
  Kilopascal = 'kPa',
  Megapascal = 'MPa',

  Seconds = 's',
  Milliseconds = 'ms',

  Joules = 'J',
  Kilojoules = 'kJ',

  Kelvin = 'K',

  Siemens = 'S',
  Millisiemens = 'mS',
  Microsiemens = 'mcS',

  Ounces = 'oz',
  Pounds = 'lb',
  Stones = 'st',
  Inches = 'in',
  Feet = 'ft',
  Yards = 'yd',
  Miles = 'mi',
  MillimitersOfMercury = 'mmHg',
  InchesOfMercury = 'inHg',
  CentimetersOfWater = 'cmAq',
  Atmospheres = 'atm',
  FluidOuncesUS = 'fl_oz_us',
  FluidOuncesImperial = 'fl_oz_imp',
  CupsUS = 'cup_us',
  CupsImperial = 'cup_imp',
  PintsUS = 'pt_us',
  PintsImperial = 'pt_imp',
  Minutes = 'min',
  Hours = 'hr',
  Days = 'd',
  Hertz = 'Hz',
  SmallCalories = 'cal',
  LargeCalories = 'Cal',
  Kilocalories = 'kcal',
  DecibelAWeightedSoundPressureLevel = 'dBASPL',
  DecibelHearingLevel = 'dBHL',
  Percent = '%',
  Count = 'count',
  DegreesCelsius = 'degC',
  DegreesFahrenheit = 'degF',
  InternationalUnits = 'IU',

  BeatsPerMinute = 'count/min',
  MilligramsPerDeciliter = 'mg/dL',
  MillimetersPerKilogramPerMinute = 'ml/(kg*min)',
  LitersPerMinute = 'l/min',
}

export default RNHealthKitWrapper as RNHealthKit
