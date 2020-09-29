import Permissions from './Constants/Permissions'

declare module 'react-native-health' {
  export interface HealthKitPermissions {
    permissions: {
      read: string[]
      write: string[]
    }
  }

  export interface Constants {
    Permissions: typeof Permissions
  }

  export interface MindfulSessionData {
    startDate?: Date
    endDate?: Date
    limit?: number
  }

  export interface AppleHealthKit {
    initHealthKit(
      permissions: HealthKitPermissions,
      callback: (error: string, result: HealthValue) => void,
    ): void

    isAvailable(callback: (error: Object, results: boolean) => void): void

    // initStepCountObserver
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
      options: MindfulSessionData,
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

    Constants: Constants
  }

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

  export interface HealthValueOptions extends HealthUnitOptions{
    value: number
    startDate?: string
    endDate?: string
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

  const appleHealthKit: AppleHealthKit

  export default appleHealthKit
}
