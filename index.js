import {
  Activities,
  GenericStatisticsAggregators,
  MedianStatisticsDataTypes,
  Observers,
  Permissions,
  StatisticsIntervals,
  StepsStatisticsAggregators,
  Units,
} from './src/constants'

const { AppleHealthKit } = require('react-native').NativeModules

export const HealthKit = Object.assign({}, AppleHealthKit, {
  Constants: {
    Activities,
    GenericStatisticsAggregators,
    MedianStatisticsDataTypes,
    Observers,
    Permissions,
    StatisticsIntervals,
    StepsStatisticsAggregators,
    Units,
  },
})

module.exports = HealthKit
