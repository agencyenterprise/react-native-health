import { Activities, Observers, Periods, Permissions, SyncIntervals, Units } from './src/constants'
import { Platform } from 'react-native'


const { AppleHealthKit } = require('react-native').NativeModules

export const HealthKit =
  Platform.OS !== 'ios'
    ? {}
    : {
        initHealthKit: AppleHealthKit.initHealthKit,
        isAvailable: AppleHealthKit.isAvailable,
        getBiologicalSex: AppleHealthKit.getBiologicalSex,
        getBloodType: AppleHealthKit.getBloodType,
        getDateOfBirth: AppleHealthKit.getDateOfBirth,
        getLatestWeight: AppleHealthKit.getLatestWeight,
        getWeightSamples: AppleHealthKit.getWeightSamples,
        saveWeight: AppleHealthKit.saveWeight,
        getLatestHeight: AppleHealthKit.getLatestHeight,
        getHeightSamples: AppleHealthKit.getHeightSamples,
        saveHeight: AppleHealthKit.saveHeight,
        getLatestWaistCircumference: AppleHealthKit.getLatestWaistCircumference,
        getWaistCircumferenceSamples:
          AppleHealthKit.getWaistCircumferenceSamples,
        saveWaistCircumference: AppleHealthKit.saveWaistCircumference,
        getLatestPeakFlow: AppleHealthKit.getLatestPeakFlow,
        getPeakFlowSamples: AppleHealthKit.getPeakFlowSamples,
        savePeakFlow: AppleHealthKit.savePeakFlow,
        saveLeanBodyMass: AppleHealthKit.saveLeanBodyMass,
        getLatestBmi: AppleHealthKit.getLatestBmi,
        getBmiSamples: AppleHealthKit.getBmiSamples,
        saveBmi: AppleHealthKit.saveBmi,
        getLatestBodyFatPercentage: AppleHealthKit.getLatestBodyFatPercentage,
        getBodyFatPercentageSamples: AppleHealthKit.getBodyFatPercentageSamples,
        getLatestLeanBodyMass: AppleHealthKit.getLatestLeanBodyMass,
        getLeanBodyMassSamples: AppleHealthKit.getLeanBodyMassSamples,
        getStepCount: AppleHealthKit.getStepCount,
        getSamples: AppleHealthKit.getSamples,
        getAnchoredWorkouts: AppleHealthKit.getAnchoredWorkouts,
        configureBackgroundSync: AppleHealthKit.configureBackgroundSync,
        getDeltaSamples: AppleHealthKit.getDeltaSamples,
        getDeltaSamplesForPermissions: function(requests, callback) {
          if (!requests || requests.length === 0) {
            callback(null, {})
            return
          }

          // Detect duplicate types up front — silent overwrite would lose data
          const seenTypes = new Set()
          for (const options of requests) {
            if (options && options.type) {
              if (seenTypes.has(options.type)) {
                callback(new Error('getDeltaSamplesForPermissions: duplicate type "' + options.type + '" in requests array'), null)
                return
              }
              seenTypes.add(options.type)
            }
          }

          const results = {}
          let pending = requests.length
          let settled = false

          requests.forEach(function(options) {
            if (settled) return
            if (!options.type || typeof options.type !== 'string' || options.type.length === 0) {
              settled = true
              callback(new Error('getDeltaSamplesForPermissions: missing required "type" field in request (expected non-empty string)'), null)
              return
            }
            const type = options.type
            AppleHealthKit.getDeltaSamples(options, function(err, result) {
              if (settled) return
              if (err) {
                settled = true
                callback(err, null)
                return
              }
              results[type] = result
              pending -= 1
              if (pending === 0) {
                settled = true
                callback(null, results)
              }
            })
          })
        },
        getStepCountSamples: AppleHealthKit.getStepCountSamples,
        getDailyStepCountSamples: AppleHealthKit.getDailyStepCountSamples,
        saveSteps: AppleHealthKit.saveSteps,
        saveWalkingRunningDistance: AppleHealthKit.saveWalkingRunningDistance,
        getDistanceWalkingRunning: AppleHealthKit.getDistanceWalkingRunning,
        getDailyDistanceWalkingRunningSamples:
          AppleHealthKit.getDailyDistanceWalkingRunningSamples,
        getDistanceCycling: AppleHealthKit.getDistanceCycling,
        getDailyDistanceCyclingSamples:
          AppleHealthKit.getDailyDistanceCyclingSamples,
        getFlightsClimbed: AppleHealthKit.getFlightsClimbed,
        getDailyFlightsClimbedSamples:
          AppleHealthKit.getDailyFlightsClimbedSamples,
        getEnergyConsumedSamples: AppleHealthKit.getEnergyConsumedSamples,
        getProteinSamples: AppleHealthKit.getProteinSamples,
        getFiberSamples: AppleHealthKit.getFiberSamples,
        getTotalFatSamples: AppleHealthKit.getTotalFatSamples,
        saveFood: AppleHealthKit.saveFood,
        saveWater: AppleHealthKit.saveWater,
        getWater: AppleHealthKit.getWater,
        saveHeartRateSample: AppleHealthKit.saveHeartRateSample,
        getWaterSamples: AppleHealthKit.getWaterSamples,
        getHeartRateSamples: AppleHealthKit.getHeartRateSamples,
        getRestingHeartRate: AppleHealthKit.getRestingHeartRate,
        getWalkingHeartRateAverage: AppleHealthKit.getWalkingHeartRateAverage,
        getActiveEnergyBurned: AppleHealthKit.getActiveEnergyBurned,
        getBasalEnergyBurned: AppleHealthKit.getBasalEnergyBurned,
        getAppleExerciseTime: AppleHealthKit.getAppleExerciseTime,
        getAppleStandTime: AppleHealthKit.getAppleStandTime,
        getVo2MaxSamples: AppleHealthKit.getVo2MaxSamples,
        getBodyTemperatureSamples: AppleHealthKit.getBodyTemperatureSamples,
        getBloodPressureSamples: AppleHealthKit.getBloodPressureSamples,
        saveBloodPressureSamples: AppleHealthKit.saveBloodPressureSamples,
        getRespiratoryRateSamples: AppleHealthKit.getRespiratoryRateSamples,
        getHeartRateVariabilitySamples:
          AppleHealthKit.getHeartRateVariabilitySamples,
        getHeartbeatSeriesSamples: AppleHealthKit.getHeartbeatSeriesSamples,
        getRestingHeartRateSamples: AppleHealthKit.getRestingHeartRateSamples,
        getBloodGlucoseSamples: AppleHealthKit.getBloodGlucoseSamples,
        getCarbohydratesSamples: AppleHealthKit.getCarbohydratesSamples,
        saveBloodGlucoseSample: AppleHealthKit.saveBloodGlucoseSample,
        saveCarbohydratesSample: AppleHealthKit.saveCarbohydratesSample,
        deleteBloodGlucoseSample: AppleHealthKit.deleteBloodGlucoseSample,
        deleteCarbohydratesSample: AppleHealthKit.deleteCarbohydratesSample,
        getSleepSamples: AppleHealthKit.getSleepSamples,
        getInfo: AppleHealthKit.getInfo,
        getMindfulSession: AppleHealthKit.getMindfulSession,
        saveMindfulSession: AppleHealthKit.saveMindfulSession,
        getWorkoutRouteSamples: AppleHealthKit.getWorkoutRouteSamples,
        saveWorkout: AppleHealthKit.saveWorkout,
        getAuthStatus: AppleHealthKit.getAuthStatus,
        getLatestBloodAlcoholContent:
          AppleHealthKit.getLatestBloodAlcoholContent,
        getBloodAlcoholContentSamples:
          AppleHealthKit.getBloodAlcoholContentSamples,
        saveBloodAlcoholContent: AppleHealthKit.saveBloodAlcoholContent,
        getDistanceSwimming: AppleHealthKit.getDistanceSwimming,
        getDailyDistanceSwimmingSamples:
          AppleHealthKit.getDailyDistanceSwimmingSamples,
        getOxygenSaturationSamples: AppleHealthKit.getOxygenSaturationSamples,
        getElectrocardiogramSamples: AppleHealthKit.getElectrocardiogramSamples,
        saveBodyFatPercentage: AppleHealthKit.saveBodyFatPercentage,
        saveBodyTemperature: AppleHealthKit.saveBodyTemperature,
        getEnvironmentalAudioExposure:
          AppleHealthKit.getEnvironmentalAudioExposure,
        getHeadphoneAudioExposure: AppleHealthKit.getHeadphoneAudioExposure,
        getClinicalRecords: AppleHealthKit.getClinicalRecords,
        getActivitySummary: AppleHealthKit.getActivitySummary,
        getInsulinDeliverySamples: AppleHealthKit.getInsulinDeliverySamples,
        saveInsulinDeliverySample: AppleHealthKit.saveInsulinDeliverySample,
        deleteInsulinDeliverySample: AppleHealthKit.deleteInsulinDeliverySample,
        getMedicationRecords: AppleHealthKit.getMedicationRecords,
        getConditionRecords: AppleHealthKit.getConditionRecords,
        getAllergyRecords: AppleHealthKit.getAllergyRecords,
        getImmunizationRecords: AppleHealthKit.getImmunizationRecords,
        getProcedureRecords: AppleHealthKit.getProcedureRecords,
        getLabRecords: AppleHealthKit.getLabRecords,
        getClinicalVitalRecords: AppleHealthKit.getClinicalVitalRecords,
        Constants: {
          Activities,
          Observers,
          Periods,
          Permissions,
          SyncIntervals,
          Units,
        },
      }

module.exports = HealthKit
