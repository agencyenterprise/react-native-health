'use strict'

let { AppleHealthKit } = require('react-native').NativeModules;

import Constants from './constants';

let HealthKit = Object.assign({}, AppleHealthKit, {
	Constants: Constants
});

export default HealthKit
module.exports = HealthKit;
