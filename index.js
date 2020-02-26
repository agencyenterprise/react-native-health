import { Permissions, Units, Activities } from './Constants'

const { AppleHealthKit } = require('react-native').NativeModules

const HealthKit = Object.assign({}, AppleHealthKit, {
	Constants: {
		Permissions,
		Units,
		Activities,
	},
})

export default HealthKit
module.exports = HealthKit