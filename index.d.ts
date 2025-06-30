import {
  HealthActivity,
  HealthObserver,
  HealthPermission,
  HealthUnit,
} from './enums'

declare module 'react-native-health' {
  export interface HealthKitPermissions {
    permissions: {
      read: HealthPermission[]
      write: HealthPermission[]
    }
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

    Constants: {
      Activities: typeof HealthActivity
      Observers: typeof HealthObserver
      Permissions: typeof HealthPermission
      Units: typeof HealthUnit
    }
  }

  /* Inputs and Payloads */

  export interface HealthDateOfBirth {
    value: string
    age: number
  }
  interface BaseValue {
    id?: string
    startDate: string
    endDate: string
    metadata?: RecordMetadata
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
    device: string
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
    Marker = 'marker',
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
    device: string
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
    device: string
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

  export type HealthActivity = keyof typeof HealthActivity
  export type HealthPermission = keyof typeof HealthPermission
  export type HealthUnit = keyof typeof HealthUnit
  export type HealthObserver = keyof typeof HealthObserver

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
    data: Array<HKWorkoutQueriedSampleType>
  }

  export interface WorkoutRouteQueryResults {
    anchor: string
    data: HKWorkoutRouteSampleType
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

export const Constants = {
  Activities: HealthActivity,
  Observers: HealthObserver,
  Permissions: HealthPermission,
  Units: HealthUnit,
} as const
