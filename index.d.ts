declare module 'react-native-health' {
  export interface HealthKitPermissions {
    permissions: {
      read: HealthPermission[]
      write: HealthPermission[]
    }
  }

  export interface Constants {
    Activities:    Record<HealthActivity,   HealthActivity>
    Observers:     Record<HealthObserver,   HealthObserver>
    Periods:       Record<string,           HealthPeriod>
    Permissions:   Record<HealthPermission, HealthPermission>
    SyncIntervals: Record<string,           SyncInterval>
    Units:         Record<HealthUnit,       HealthUnit>
  }

  export interface HKErrorResponse {
    message?: string
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

    getBloodType(
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
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
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
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveHeight(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestWaistCircumference(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getWaistCircumferenceSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveWaistCircumference(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestPeakFlow(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getPeakFlowSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    savePeakFlow(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveLeanBodyMass(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestBmi(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBmiSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveBmi(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getLatestBodyFatPercentage(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBodyFatPercentageSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getLatestLeanBodyMass(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getLeanBodyMassSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getStepCount(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getAnchoredWorkouts(
      options: HealthInputOptions,
      callback: (err: HKErrorResponse, results: AnchoredQueryResults) => void,
    ): void

    configureBackgroundSync(options: BackgroundSyncOptions): void

    getDeltaSamples(
      options: DeltaQueryOptions,
      callback: (err: HKErrorResponse, results: DeltaQueryResult) => void,
    ): void

    getDeltaSamplesForPermissions(
      requests: DeltaQueryOptions[],
      callback: (err: HKErrorResponse, results: Record<string, DeltaQueryResult>) => void,
    ): void

    getStepCountSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getDailyStepCountSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveSteps(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveWalkingRunningDistance(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getDistanceWalkingRunning(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceWalkingRunningSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getDistanceCycling(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceCyclingSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getFlightsClimbed(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyFlightsClimbedSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getEnergyConsumedSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getProteinSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getFiberSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getTotalFatSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveFood(
      options: HealthInputOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveWater(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getWater(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveHeartRateSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getWaterSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getHeartRateSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getRestingHeartRate(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getWalkingHeartRateAverage(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue[]) => void,
    ): void

    getActiveEnergyBurned(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getBasalEnergyBurned(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getAppleExerciseTime(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getAppleStandTime(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getVo2MaxSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getBodyTemperatureSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getBloodPressureSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<BloodPressureSampleValue>) => void,
    ): void

    saveBloodPressureSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<BloodPressureSampleValue>) => void,
    ): void

    getRespiratoryRateSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getHeartRateVariabilitySamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getHeartbeatSeriesSamples(
      options: HealthInputOptions,
      callback: (err: string, results: HeartbeatSeriesSampleValue[]) => void,
    ): void

    getRestingHeartRateSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getBloodGlucoseSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getCarbohydratesSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveBloodGlucoseSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    saveCarbohydratesSample(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    deleteBloodGlucoseSample(
      id: string,
      callback: (error: string, result: HealthValue) => void,
    ): void

    deleteCarbohydratesSample(
      id: string,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getSleepSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getInfo(
      options: HealthUnitOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getMindfulSession(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveMindfulSession(
      options: HealthValueOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getWorkoutRouteSamples(
      options: { id: string },
      callback: (err: string, results: WorkoutRouteQueryResults) => void,
    ): void

    saveWorkout(
      options: HealthActivityOptions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getAuthStatus(
      permissions: HealthKitPermissions,
      callback: (err: string, results: HealthStatusResult) => void,
    ): void

    getLatestBloodAlcoholContent(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getBloodAlcoholContentSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveBloodAlcoholContent(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDistanceSwimming(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getDailyDistanceSwimmingSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getOxygenSaturationSamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getElectrocardiogramSamples(
      options: HealthInputOptions,
      callback: (err: string, results: ElectrocardiogramSampleValue[]) => void,
    ): void

    saveBodyFatPercentage(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    saveBodyTemperature(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    getEnvironmentalAudioExposure(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue[]) => void,
    ): void

    getHeadphoneAudioExposure(
      options: HealthInputOptions,
      callback: (err: string, results: HealthValue[]) => void,
    ): void

    getClinicalRecords(
      options: HealthClinicalRecordOptions,
      callback: (err: string, results: Array<HealthClinicalRecord>) => void,
    ): void

    setObserver(options: HealthObserverOptions): void

    getActivitySummary(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthActivitySummary>) => void,
    ): void

    getInsulinDeliverySamples(
      options: HealthInputOptions,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    saveInsulinDeliverySample(
      options: HealthValueOptions,
      callback: (err: string, results: HealthValue) => void,
    ): void

    deleteInsulinDeliverySample(
      id: string,
      callback: (error: string, result: HealthValue) => void,
    ): void

    getMedicationRecords(
      options: HealthInputOptions | null,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getConditionRecords(
      options: HealthInputOptions | null,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getAllergyRecords(
      options: HealthInputOptions | null,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getImmunizationRecords(
      options: HealthInputOptions | null,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getProcedureRecords(
      options: HealthInputOptions | null,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getLabRecords(
      options: HealthInputOptions | null,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    getClinicalVitalRecords(
      options: HealthInputOptions | null,
      callback: (err: string, results: Array<HealthValue>) => void,
    ): void

    Constants: Constants
  }

  /* Inputs and Payloads */

  export interface HealthDateOfBirth {
    value: string
    age: number
  }
  export interface HKDevice {
    name?: string
    model?: string
    hardwareVersion?: string
    softwareVersion?: string
  }

  interface BaseValue {
    id?: string
    startDate: string
    endDate: string
    metadata?: RecordMetadata
    device?: HKDevice
  }

  export interface LocationValue {
    latitude: number
    longitude: number
    altitude: number
    timestamp: string
    speed: number
    speedAccuracy: number
  }

  export interface RecordMetadata {
    HKBloodGlucoseMealTime?: BloodGlucoseMealTime
    HKInsulinDeliveryReason?: InsulinDeliveryReason
    HKWasUserEntered?: boolean
    [key: string]: string | number | boolean | undefined
  }

  export interface HealthValue extends BaseValue {
    value: number
  }

  export interface BloodPressureSampleValue extends BaseValue {
    bloodPressureSystolicValue: number
    bloodPressureDiastolicValue: number
  }

  export interface HeartbeatSeriesSampleValue extends BaseValue {
    heartbeatSeries: {
      timeSinceSeriesStart: number
      precededByGap: boolean
    }[]
  }

  export interface HealthUnitOptions {
    unit?: HealthUnit
  }

  export interface HealthInputOptions extends HealthUnitOptions {
    startDate?: string
    endDate?: string
    limit?: number
    ascending?: boolean
    type?: HealthObserver
    date?: string
    includeManuallyAdded?: boolean
    period?: number
    anchor?: string
  }

  export interface HKWorkoutRouteSampleType {
    device?: HKDevice
    id: string
    metadata: any
    sourceName: string
    sourceId: string
    start: string
    end: string
    locations: LocationValue[]
  }

  export enum EventType {
    Pause = 'pause',
    Resume = 'resume',
    MotionPaused = 'motion paused',
    MotionResumed = 'motion resumed',
    PausedOrResumeRequest = 'pause or resume request',
    Lap = 'lap',
    Segment = 'segment',
    Marker = 'marker'
  }

  export type HKWorkoutEventType = {
    endDate: string
    startDate: string
    eventTypeInt: number
    eventType: EventType
  }

  export interface HKWorkoutQueriedSampleType {
    activityId: number
    activityName: string
    calories: number
    device?: HKDevice
    id: string
    tracked: boolean
    metadata: any
    sourceName: string
    sourceId: string
    distance: number
    start: string
    end: string
    duration: number
    workoutEvents: HKWorkoutEventType[]
  }

  export interface ElectrocardiogramSampleValue extends BaseValue {
    classification: ElectrocardiogramClassification
    averageHeartRate: number
    samplingFrequency: number
    algorithmVersion: number
    voltageMeasurements: number[][]
  }

  export interface HealthValueOptions extends HealthUnitOptions {
    value: number
    startDate?: string
    endDate?: string
    metadata?: RecordMetadata
  }

  export interface HealthActivityOptions
    extends Omit<Omit<HealthValueOptions, 'unit'>, 'value'> {
    type: HealthActivity
  }

  export interface HealthObserverOptions {
    type: HealthObserver
  }

  export interface HealthActivitySummary {
    activeEnergyBurned: number
    activeEnergyBurnedGoal: number
    appleExerciseTime: number
    appleExerciseTimeGoal: number
    appleStandHours: number
    appleStandHoursGoal: number
  }

  export interface HealthClinicalRecordOptions {
    startDate: string
    endDate?: string
    limit?: number
    ascending?: boolean
    type: ClinicalRecordType
  }

  export enum ClinicalRecordType {
    AllergyRecord = 'AllergyRecord',
    ConditionRecord = 'ConditionRecord',
    CoverageRecord = 'CoverageRecord',
    ImmunizationRecord = 'ImmunizationRecord',
    LabResultRecord = 'LabResultRecord',
    MedicationRecord = 'MedicationRecord',
    ProcedureRecord = 'ProcedureRecord',
    VitalSignRecord = 'VitalSignRecord',
  }

  export interface HealthClinicalRecord extends BaseValue {
    sourceName: string
    sourceId: string
    displayName: string
    fhirData: any
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
    CardioDance = 'CardioDance',
    Climbing = 'Climbing',
    Cooldown = 'Cooldown',
    Cricket = 'Cricket',
    CrossTraining = 'CrossTraining',
    Curling = 'Curling',
    Cycling = 'Cycling',
    Dance = 'Dance',
    DiscSports = 'DiscSports',
    Elliptical = 'Elliptical',
    EquestrianSports = 'EquestrianSports',
    Fencing = 'Fencing',
    FitnessGaming = 'FitnessGaming',
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
    Pickleball = 'Pickleball',
    PreparationAndRecovery = 'PreparationAndRecovery',
    Racquetball = 'Racquetball',
    Rowing = 'Rowing',
    Rugby = 'Rugby',
    Running = 'Running',
    Sailing = 'Sailing',
    SkatingSports = 'SkatingSports',
    SnowSports = 'SnowSports',
    Soccer = 'Soccer',
    SocialDance = 'SocialDance',
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
    ActivitySummary = 'ActivitySummary',
    AllergyRecord = 'AllergyRecord',
    AppleExerciseTime = 'AppleExerciseTime',
    AppleStandTime = 'AppleStandTime',
    BasalEnergyBurned = 'BasalEnergyBurned',
    BiologicalSex = 'BiologicalSex',
    BloodType = 'BloodType',
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
    ConditionRecord = 'ConditionRecord',
    Copper = 'Copper',
    CoverageRecord = 'CoverageRecord',
    EnergyConsumed = 'EnergyConsumed',
    EnvironmentalAudioExposure = 'EnvironmentalAudioExposure',
    FatMonounsaturated = 'FatMonounsaturated',
    FatPolyunsaturated = 'FatPolyunsaturated',
    FatSaturated = 'FatSaturated',
    FatTotal = 'FatTotal',
    Fiber = 'Fiber',
    Folate = 'Folate',
    HeadphoneAudioExposure = 'HeadphoneAudioExposure',
    ImmunizationRecord = 'ImmunizationRecord',
    InsulinDelivery = 'InsulinDelivery',
    Iodine = 'Iodine',
    Iron = 'Iron',
    LabResultRecord = 'LabResultRecord',
    Magnesium = 'Magnesium',
    Manganese = 'Manganese',
    MedicationRecord = 'MedicationRecord',
    Molybdenum = 'Molybdenum',
    Niacin = 'Niacin',
    OxygenSaturation = 'OxygenSaturation',
    PantothenicAcid = 'PantothenicAcid',
    Phosphorus = 'Phosphorus',
    Potassium = 'Potassium',
    ProcedureRecord = 'ProcedureRecord',
    Protein = 'Protein',
    Riboflavin = 'Riboflavin',
    Selenium = 'Selenium',
    Sodium = 'Sodium',
    Sugar = 'Sugar',
    Thiamin = 'Thiamin',
    VitalSignRecord = 'VitalSignRecord',
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
    DistanceSwimming = 'DistanceSwimming',
    DistanceWalkingRunning = 'DistanceWalkingRunning',
    Electrocardiogram = 'Electrocardiogram',
    FlightsClimbed = 'FlightsClimbed',
    HeartbeatSeries = 'HeartbeatSeries',
    HeartRate = 'HeartRate',
    RestingHeartRate = 'RestingHeartRate',
    HeartRateVariability = 'HeartRateVariability',
    Height = 'Height',
    LeanBodyMass = 'LeanBodyMass',
    MindfulSession = 'MindfulSession',
    NikeFuel = 'NikeFuel',
    PeakFlow = 'PeakFlow',
    RespiratoryRate = 'RespiratoryRate',
    SleepAnalysis = 'SleepAnalysis',
    StepCount = 'StepCount',
    Steps = 'Steps',
    Vo2Max = 'Vo2Max',
    WaistCircumference = 'WaistCircumference',
    WalkingHeartRateAverage = 'WalkingHeartRateAverage',
    Weight = 'Weight',
    Workout = 'Workout',
    WorkoutRoute = 'WorkoutRoute',
    RunningSpeed = 'RunningSpeed',
    RunningPower = 'RunningPower',
    RunningStrideLength = 'RunningStrideLength',
    RunningVerticalOscillation = 'RunningVerticalOscillation',
    RunningGroundContactTime = 'RunningGroundContactTime',
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
    kilocalorie = 'kilocalorie',
    meter = 'meter',
    mgPerdL = 'mgPerdL',
    mile = 'mile',
    minute = 'minute',
    mmhg = 'mmhg',
    literPerMinute = 'literPerMinute',
    mmolPerL = 'mmolPerL',
    percent = 'percent',
    pound = 'pound',
    second = 'second',
  }

  export enum HealthStatusCode {
    NotDetermined = 0,
    SharingDenied = 1,
    SharingAuthorized = 2,
  }

  export interface HealthStatusResult {
    permissions: {
      read: HealthStatusCode[]
      write: HealthStatusCode[]
    }
  }

  export interface AnchoredQueryResults {
    anchor: string
    data: Array<HKWorkoutQueriedSampleType>  // All workouts (backward compatible)
  }

  export interface WorkoutRouteQueryResults {
    anchor: string
    data: HKWorkoutRouteSampleType
  }

  export type HealthPeriod =
    | 'last24hours'   // rolling: now - 24h → now
    | 'today'         // calendar day: midnight → now
    | 'last7days'
    | 'last30days'
    | 'last3months'
    | 'last6months'
    | 'lastyear'

  /**
   * Minimum time between background delta fetches. Default: `'every24hours'`.
   * Pass a named alias or a raw positive number of **seconds** (e.g. `60` for 1 minute).
   * Floats are rounded to the nearest integer. Zero, negative, NaN, and Infinity fall back to `86400s` at runtime.
   */
  export type SyncInterval =
    | 'every1hour'
    | 'every6hours'
    | 'every12hours'
    | 'every24hours'
    | 'every48hours'
    | 'everyweek'
    | number // must be a positive finite value in seconds; zero, negative, NaN, and Infinity default to 86400s at runtime

  export interface BackgroundSyncOptions {
    enabled?:      boolean
    /** Positive seconds; floats rounded to nearest integer (min 1s). Zero, negative, NaN, or Infinity default to 86400s (24 hours). */
    syncInterval?: SyncInterval
  }

  export interface DeletedSample {
    id: string
  }

  export interface SleepSample {
    id: string
    value: 'INBED' | 'ASLEEP' | 'CORE' | 'DEEP' | 'REM' | 'AWAKE' | 'UNKNOWN'
    startDate: string
    endDate: string
    sourceName: string
    sourceId: string
    device?: HKDevice
    metadata: Record<string, unknown>
  }

  export interface BloodPressureSample {
    id: string
    bloodPressureSystolicValue: number
    bloodPressureDiastolicValue: number
    startDate: string
    endDate: string
    sourceName: string
    sourceId: string
    device?: HKDevice
    metadata: Record<string, unknown>
  }

  export interface ClinicalSample {
    id: string
    displayName: string
    fhirData: Record<string, unknown>
    fhirRelease: string
    fhirVersion: string
    startDate: string
    endDate: string
    sourceName: string
    sourceId: string
    device?: HKDevice
  }

  export type DeltaSample = HealthValue | SleepSample | BloodPressureSample | ClinicalSample

  export interface DeltaQueryResult {
    anchor:       string
    added:        DeltaSample[]
    deleted:      DeletedSample[]
    /** Number of samples skipped due to serialization errors or incomplete data (e.g. partial BloodPressure correlations). Only present when > 0. */
    serializationErrors?: number
  }

  export interface DeltaQueryOptions {
    /** @required Unique identifier for the health data type (e.g., 'HeartRate', 'StepCount', 'Workout') */
    type:                  HealthObserver
    /** Previous query result's anchor string to fetch only changes since last query */
    anchor?:               string
    /** Unit for quantity types */
    unit?:                 HealthUnit
    /** ISO 8601 start date string */
    startDate?:            string
    /** ISO 8601 end date string */
    endDate?:              string
    /** Preset period like 'today' or 'last7days' */
    period?:               HealthPeriod
    /** Maximum number of results to return */
    limit?:                number
    /** When false, samples manually entered by the user are excluded. Defaults to true. */
    includeManuallyAdded?: boolean
  }

  export enum HealthObserver {
    ActiveEnergyBurned = 'ActiveEnergyBurned',
    AllergyRecord = 'AllergyRecord',
    BasalEnergyBurned = 'BasalEnergyBurned',
    BloodGlucose = 'BloodGlucose',
    BloodPressure = 'BloodPressure',
    BodyFatPercentage = 'BodyFatPercentage',
    BodyMass = 'BodyMass',
    BodyMassIndex = 'BodyMassIndex',
    BodyTemperature = 'BodyTemperature',
    ConditionRecord = 'ConditionRecord',
    CoverageRecord = 'CoverageRecord',
    Cycling = 'Cycling',
    DietaryCholesterol = 'DietaryCholesterol',
    HeartRate = 'HeartRate',
    HeartRateVariabilitySDNN = 'HeartRateVariabilitySDNN',
    Height = 'Height',
    ImmunizationRecord = 'ImmunizationRecord',
    InsulinDelivery = 'InsulinDelivery',
    LabResultRecord = 'LabResultRecord',
    MedicationRecord = 'MedicationRecord',
    OxygenSaturation = 'OxygenSaturation',
    ProcedureRecord = 'ProcedureRecord',
    RespiratoryRate = 'RespiratoryRate',
    RestingHeartRate = 'RestingHeartRate',
    Running = 'Running',
    SleepAnalysis = 'SleepAnalysis',
    StairClimbing = 'StairClimbing',
    StepCount = 'StepCount',
    Swimming = 'Swimming',
    VitalSignRecord = 'VitalSignRecord',
    Vo2Max = 'Vo2Max',
    Walking = 'Walking',
    Workout = 'Workout',
  }

  export enum ElectrocardiogramClassification {
    NotSet = 'NotSet',
    SinusRhythm = 'SinusRhythm',
    AtrialFibrillation = 'AtrialFibrillation',
    InconclusiveLowHeartRate = 'InconclusiveLowHeartRate',
    InconclusiveHighHeartRate = 'InconclusiveHighHeartRate',
    InconclusivePoorReading = 'InconclusivePoorReading',
    InconclusiveOther = 'InconclusiveOther',
    Unrecognized = 'Unrecognized',
  }

  export enum BloodGlucoseMealTime {
    Preprandial = 1,
    Postprandial = 2,
  }

  export enum InsulinDeliveryReason {
    Basal = 1,
    Bolus = 2,
  }

  const appleHealthKit: AppleHealthKit

  export default appleHealthKit
}
