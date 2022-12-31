import { Activities, Observers, Permissions, Units } from './src/constants'
const { AppleHealthKit } = require('react-native').NativeModules
const { HealthKitContext, HealthKitProvider, useHealthKit} = require('./health.js');

// export const HealthKit = Object.assign({}, AppleHealthKit, {
//   Constants: {
//     Activities,
//     Observers,
//     Permissions,
//     Units
//   },HealthKitContext, HealthKitProvider, useHealthKit
// }, )


export const HealthKit = {AppleHealthKit, 
  Constants: {
    Activities,
    Observers,
    Permissions,
    Units
}, HealthKitContext, HealthKitProvider, useHealthKit }

// export { HealthKitContext, HealthKitProvider, useHealthKit }

module.exports = HealthKit
