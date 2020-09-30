import { Activities, Observers, Permissions, Units } from './src/constants'

const { AppleHealthKit } = require('react-native').NativeModules

export const HealthKit = Object.assign({}, AppleHealthKit, {
  Constants: {
    Activities,
    Observers,
    Permissions,
    Units,
  },
})

module.exports = HealthKit
