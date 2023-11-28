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

  getWorkouts(
    query: WorkoutQuery
  ): Promise<Workout[]>;

  saveWorkout(
    workout: {
      activityType: WorkoutActivityType;
      startDate: string;
      endDate: string;
      totalEnergyBurned?: number;
      totalDistance?: number;
      metadata?: WorkoutMetadata;
    }
  ): Promise<boolean>;
}

export interface WorkoutQuery {
  startDate?: string;
  endDate?: string;
  activityTypes?: number[];
  ids?: string[];
  limit?: number;
  isUserEntered?: boolean;
}

export interface Workout {
  id: string;
  startDate: string;
  endDate: string;
  activityType: WorkoutActivityType;
  duration: number;
}

export interface QuantitySamplesQuery {
  type: HealthType;
  startDate?: string;
  endDate?: string;
  isUserEntered?: boolean;
  unit: HealthUnit | string;
  limit?: number;
  ids?: string[];
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
  option: StatisticsOption;
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

  // Workout
  Workout = 'workout',
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

export enum WorkoutActivityType {
  AmericanFootball = 1,
  Archery = 2,
  AustralianFootball = 3,
  Badminton = 4,
  Baseball = 5,
  Basketball = 6,
  Bowling = 7,
  Boxing = 8, // See also HKWorkoutActivityTypeKickboxing.,
  Climbing = 9,
  Cricket = 10,
  CrossTraining = 11, // Any mix of cardio and/or strength training. See also HKWorkoutActivityTypeCoreTraining and HKWorkoutActivityTypeFlexibility.,
  Curling = 12,
  Cycling = 13,
  Dance = 14,
  DanceInspiredTraining = 15, // This enum remains available to access older data.,
  Elliptical = 16,
  EquestrianSports = 17, // Polo, Horse Racing, Horse Riding, etc.,
  Fencing = 18,
  Fishing = 19,
  FunctionalStrengthTraining = 20, // Primarily free weights and/or body weight and/or accessories,
  Golf = 21,
  Gymnastics = 22,
  Handball = 23,
  Hiking = 24,
  Hockey = 25, // Ice Hockey, Field Hockey, etc.,
  Hunting = 26,
  Lacrosse = 27,
  MartialArts = 28,
  MindAndBody = 29, // Qigong, meditation, etc.,
  MixedMetabolicCardioTraining = 30, // This enum remains available to access older data.,
  PaddleSports = 31, // Canoeing, Kayaking, Outrigger, Stand Up Paddle Board, etc.,
  Play = 32, // Dodge Ball, Hopscotch, Tetherball, Jungle Gym, etc.,
  PreparationAndRecovery = 33, // Foam rolling, stretching, etc.,
  Racquetball = 34,
  Rowing = 35,
  Rugby = 36,
  Running = 37,
  Sailing = 38,
  SkatingSports = 39, // Ice Skating, Speed Skating, Inline Skating, Skateboarding, etc.,
  SnowSports = 40, // Sledding, Snowmobiling, Building a Snowman, etc. See also HKWorkoutActivityTypeCrossCountrySkiing, HKWorkoutActivityTypeSnowboarding, and HKWorkoutActivityTypeDownhillSkiing.,
  Soccer = 41,
  Softball = 42,
  Squash = 43,
  StairClimbing = 44, // See also HKWorkoutActivityTypeStairs and HKWorkoutActivityTypeStepTraining.,
  SurfingSports = 45, // Traditional Surfing, Kite Surfing, Wind Surfing, etc.,
  Swimming = 46,
  TableTennis = 47,
  Tennis = 48,
  TrackAndField = 49, // Shot Put, Javelin, Pole Vaulting, etc.,
  TraditionalStrengthTraining = 50, // Primarily machines and/or free weights,
  Volleyball = 51,
  Walking = 52,
  WaterFitness = 53,
  WaterPolo = 54,
  WaterSports = 55, // Water Skiing, Wake Boarding, etc.,
  Wrestling = 56,
  Yoga = 57,
  Barre = 58,
  CoreTraining = 59,
  CrossCountrySkiing = 60,
  DownhillSkiing = 61,
  Flexibility = 62,
  HighIntensityIntervalTraining = 63,
  JumpRope = 64,
  Kickboxing = 65,
  Pilates = 66,
  Snowboarding = 67,
  Stairs = 68,
  StepTraining = 69,
  WheelchairWalkPace = 70,
  WheelchairRunPace = 71,
  TaiChi = 72,
  MixedCardio = 73,
  HandCycling = 74,
  DiscSports = 75,
  FitnessGaming = 76,
  CardioDance = 77,
  SocialDance = 78,    // Dances done in social settings like swing, salsa and folk dances from different world regions.
  Pickleball = 79,
  Cooldown = 80,    // Low intensity stretching and mobility exercises following a more vigorous workout type
  SwimBikeRun = 81,
  Transition = 82,
  Other = 3000,
}

export enum WorkoutMetadataKey {
  ActivityType = "HKActivityType",
  AppleFitnessPlusSession = "HKAppleFitnessPlusSession",
  CoachedWorkout = "HKCoachedWorkout",
  GroupFitness = "HKGroupFitness",
  IndoorWorkout = "HKIndoorWorkout",
  WorkoutBrandName = "HKWorkoutBrandName",
  CyclingFunctionalThresholdPowerTestType = "HKCyclingFunctionalThresholdPowerTestType",
  FitnessMachineDuration = "HKFitnessMachineDuration",
  CrossTrainerDistance = "HKCrossTrainerDistance",
  IndoorBikeDistance = "HKIndoorBikeDistance",
  AverageMETs = "HKAverageMETs",
  PhysicalEffortEstimationType = "HKPhysicalEffortEstimationType",
  AlpineSlopeGrade = "HKAlpineSlopeGrade",
  ElevationAscended = "HKElevationAscended",
  ElevationDescended = "HKElevationDescended",
  AverageSpeed = "HKAverageSpeed",
  MaximumSpeed = "HKMaximumSpeed",
  SwimmingLocationType = "HKSwimmingLocationType",
  SwimmingStrokeStyle = "HKSwimmingStrokeStyle",
  LapLength = "HKLapLength",
  SWOLFScore = "HKSWOLFScore",
  WaterSalinity = "HKWaterSalinity",
}

export type QuantityType = {
  unit: HealthUnit | string;
  doubleValue: number;
}

export enum WaterSalinityType {
  freshWater = 0,
  saltWater = 1,
}

export type WorkoutMetadata = {
    // [WorkoutMetadataKey.ActivityType]?: string; // ?
    // [WorkoutMetadataKey.AppleFitnessPlusSession]?: string; // ?
    [WorkoutMetadataKey.CoachedWorkout]?: boolean;
    [WorkoutMetadataKey.GroupFitness]?: boolean;
    [WorkoutMetadataKey.IndoorWorkout]?: boolean;
    [WorkoutMetadataKey.WorkoutBrandName]?: string;  
    // [WorkoutMetadataKey.CyclingFunctionalThresholdPowerTestType]?: string; // ?
    [WorkoutMetadataKey.FitnessMachineDuration]?: QuantityType;
    [WorkoutMetadataKey.CrossTrainerDistance]?: QuantityType;
    [WorkoutMetadataKey.IndoorBikeDistance]?: QuantityType;
    [WorkoutMetadataKey.AverageMETs]?: QuantityType;
    // [WorkoutMetadataKey.PhysicalEffortEstimationType]?: string; // ?
    [WorkoutMetadataKey.AlpineSlopeGrade]?: QuantityType;
    [WorkoutMetadataKey.ElevationAscended]?: QuantityType;
    [WorkoutMetadataKey.ElevationDescended]?: QuantityType;
    [WorkoutMetadataKey.AverageSpeed]?: QuantityType;
    [WorkoutMetadataKey.MaximumSpeed]?: QuantityType;
    [WorkoutMetadataKey.SwimmingLocationType]?: number;
    [WorkoutMetadataKey.SwimmingStrokeStyle]?: number;
    [WorkoutMetadataKey.LapLength]?: QuantityType;
    // [WorkoutMetadataKey.SWOLFScore]?: string; // ?
    [WorkoutMetadataKey.WaterSalinity]?: WaterSalinityType;
};

// Reference:
// https://developer.apple.com/documentation/healthkit/hkworkout/workout_metadata_keys

export default RNHealthKitWrapper as RNHealthKit
