import { Permissions, Units, Activities } from "./Constants";

const { AppleHealthKit } = require("react-native").NativeModules;

export const HealthKit = Object.assign({}, AppleHealthKit, {
  Constants: {
    Activities,
    Permissions,
    Units
  }
});

module.exports = HealthKit;
