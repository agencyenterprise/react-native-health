import {
  Activities,
  GenericStatisticsAggregators,
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
    Observers,
    Permissions,
    StatisticsIntervals,
    StepsStatisticsAggregators,
    Units,
  },
})

module.exports = HealthKit
