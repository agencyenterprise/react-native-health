
# React Native Apple Healthkit
A React Native bridge module for interacting with Apple Healthkit data. Checkout the [full documentation](https://github.com/terrillo/rn-apple-healthkit/wiki)

## Installation

Install the [rn-apple-healthkit] package from npm:

- Run `npm install rn-apple-healthkit --save`
- Run `react-native link rn-apple-healthkit`

Update `info.plist` in your React Native project
```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
```

## Manual Installation

1. Run `npm install rn-apple-healthkit --save`
2. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `rn-apple-healthkit` and add `RCTAppleHealthkit.xcodeproj`
4. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthkit.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Click `RCTAppleHealthkit.xcodeproj` in the project navigator and go the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic'). In the `Search Paths` section, look for `Header Search Paths` and make sure it contains both `$(SRCROOT)/../../react-native/React` and `$(SRCROOT)/../../../React` - mark both as `recursive`.
6. Enable Healthkit in your application's `Capabilities`
![](https://i.imgur.com/eOCCCyv.png "Xcode Capabilities Section")
7. Compile and run


## Get Started
Initialize Healthkit. This will show the Healthkit permissions prompt for any read/write permissions set in the required `options` object.

Due to Apple's privacy model if an app user has previously denied a specific permission then they can not be prompted again for that same permission. The app user would have to go into the Apple Health app and grant the permission to your react-native app under *sources* tab.

For any data that is read from Healthkit the status/error is the same for both. This privacy restriction results in having no knowledge of whether the permission was denied (make sure it's added to the permissions options object), or the data for the specific request was nil (ex. no steps recorded today).

For any data written to Healthkit an authorization error can be caught. If an authorization error occurs you can prompt the user to set the specific permission or add the permission to the options object if not present.

If new read/write permissions are added to the options object then the app user will see the Healthkit permissions prompt with the new permissions to allow.

`initHealthKit` requires an options object with Healthkit permission settings
```javascript
let options = {
    permissions: {
        read: ["Height", "Weight", "StepCount", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "StepCount", "BodyMassIndex"]
    }
};
```

```javascript
import AppleHealthKit from 'rn-apple-healthkit';

AppleHealthKit.initHealthKit(options: Object, (err: string, results: Object) => {
    if (err) {
        console.log("error initializing Healthkit: ", err);
        return;
    }

    // Height Example
    AppleHealthKit.getDateOfBirth(null, (err: Object, results: Object) => {
    if (this._handleHealthkitError(err, 'getDateOfBirth')) {
      return;
    }
      console.log(results)
    });

});
```

```javascript
{
	value: '1986-09-01T00:00:00.000-0400',
	age: 29
}
```

## Changelog 
0.6.1v
- HKQuantityTypeIdentifierActiveEnergyBurned

## Wiki
  * [Installation](https://github.com/terrillo/rn-apple-healthkit/wiki/Install)
  * [Documentation](#documentation)
    * [Permissions](#permissions)
    * [Units](#units)
    * Base Methods
      * [isAvailable](https://github.com/terrillo/rn-apple-healthkit/wiki/isAvailable())
      * [initHealthKit](https://github.com/terrillo/rn-apple-healthkit/wiki/initHealthKit())
    * Realtime Methods
      * [initStepCountObserver](https://github.com/terrillo/rn-apple-healthkit/wiki/initStepCountObserver())
    * Read Methods
      * [getActiveEnergyBurned](https://github.com/terrillo/rn-apple-healthkit/wiki/getActiveEnergyBurned())
      * [getBiologicalSex](https://github.com/terrillo/rn-apple-healthkit/wiki/getBiologicalSex())
      * [getBloodGlucoseSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getbloodglucosesamples())
      * [getBloodPressureSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getbloodpressuresamples())
      * [getBodyTemperatureSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getbodytemperaturesamples())
      * [getDailyStepCountSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getDailyStepCountSamples())
      * [getDateOfBirth](https://github.com/terrillo/rn-apple-healthkit/wiki/getDateOfBirth())
      * [getDistanceCycling](https://github.com/terrillo/rn-apple-healthkit/wiki/getdistancecycling())
      * [getDistanceWalkingRunning](https://github.com/terrillo/rn-apple-healthkit/wiki/getDistanceWalkingRunning())
      * [getFlightsClimbed](https://github.com/terrillo/rn-apple-healthkit/wiki/getflightsclimbed())
      * [getHeartRateSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getheartratesamples())
      * [getHeightSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getheightsamples())
      * [getLatestBmi](https://github.com/terrillo/rn-apple-healthkit/wiki/getlatestbmi())
      * [getLatestBodyFatPercentage](https://github.com/terrillo/rn-apple-healthkit/wiki/getlatestbodyfatpercentage())
      * [getLatestHeight](https://github.com/terrillo/rn-apple-healthkit/wiki/getlatestheight())
      * [getLatestLeanBodyMass](https://github.com/terrillo/rn-apple-healthkit/wiki/getlatestleanbodymass())
      * [getLatestWeight](https://github.com/terrillo/rn-apple-healthkit/wiki/getlatestweight())
      * [getRespiratoryRateSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getrespiratoryratesamples())
      * [getSleepSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getsleepsamples())
      * [getStepCount](https://github.com/terrillo/rn-apple-healthkit/wiki/getStepCount())
      * [getWeightSamples](https://github.com/terrillo/rn-apple-healthkit/wiki/getweightsamples())
    * Write Methods
      * [saveBmi](https://github.com/terrillo/rn-apple-healthkit/wiki/savebmi())
      * [saveHeight](https://github.com/terrillo/rn-apple-healthkit/wiki/saveheight())
      * [saveMindfulSession](https://github.com/terrillo/rn-apple-healthkit/wiki/saveMindfulSession())
      * [saveWeight](https://github.com/terrillo/rn-apple-healthkit/wiki/saveweight())
      * [saveSteps](https://github.com/terrillo/rn-apple-healthkit/wiki/saveSteps())
  * [References](#references)

## Supported Apple Permissions

The available Healthkit permissions to use with `initHealthKit`

| Permission             | Healthkit Identifier Type                                                                                                                                          | Read | Write |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|-------|
| ActiveEnergyBurned          | [HKCharacteristicTypeIdentifierActiveEnergyBurned](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/1615771-activeenergyburned?language=objc)           | ✓    |       |
| BiologicalSex          | [HKCharacteristicTypeIdentifierBiologicalSex](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierbiologicalsex?language=objc)           | ✓    |       |
| BloodGlucose           | [HKQuantityTypeIdentifierBloodGlucose](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbloodglucose?language=objc)                         | ✓    |       |
| BloodPressureDiastolic | [HKQuantityTypeIdentifierBloodPressureDiastolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressurediastolic?language=objc) | ✓    | ✓     |
| BloodPressureSystolic  | [HKQuantityTypeIdentifierBloodPressureSystolic](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifierbloodpressuresystolic?language=objc)   | ✓    | ✓     |
| BodyMassIndex          | [HKQuantityTypeIdentifierBodyMassIndex](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymassindex?language=objc)                       | ✓    | ✓     |
| BodyTemperature        | [HKQuantityTypeIdentifierBodyTemperature](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodytemperature?language=objc)                   | ✓    |       |
| DateOfBirth            | [HKCharacteristicTypeIdentifierDateOfBirth](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierdateofbirth?language=objc)               | ✓    |       |
| DistanceCycling        | [HKQuantityTypeIdentifierDistanceCycling](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancecycling?language=objc)                   | ✓    | ✓     |
| DistanceWalkingRunning | [HKQuantityTypeIdentifierDistanceWalkingRunning](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancewalkingrunning?language=objc)     | ✓    | ✓     |
| FlightsClimbed         | [HKQuantityTypeIdentifierFlightsClimbed](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierflightsclimbed?language=objc)                     | ✓    | ✓     |
| HeartRate              | [HKQuantityTypeIdentifierHeartRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheartrate?language=objc)                               | ✓    |       |
| Height                 | [HKQuantityTypeIdentifierHeight](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheight?language=objc)                                     | ✓    | ✓     |
| LeanBodyMass           | [HKQuantityTypeIdentifierLeanBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierleanbodymass?language=objc)                         | ✓    | ✓     |
| MindfulSession         | [HKCategoryTypeIdentifierMindfulSession](https://developer.apple.com/reference/healthkit/hkcategorytypeidentifiermindfulsession?language=objc)                     |      |  ✓    |
| RespiratoryRate        | [HKQuantityTypeIdentifierRespiratoryRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierrespiratoryrate?language=objc)                   | ✓    |       |
| SleepAnalysis          | [HKCategoryTypeIdentifierSleepAnalysis](https://developer.apple.com/reference/Healthkit/hkcategorytypeidentifiersleepanalysis?language=objc)                       | ✓    |       |
| StepCount              | [HKQuantityTypeIdentifierStepCount](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierstepcount?language=objc)                               | ✓    | ✓     |
| Steps                  | [HKQuantityTypeIdentifierSteps](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifiersteps?language=objc)                                       | ✓    | ✓     |
| Weight                 | [HKQuantityTypeIdentifierBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymass?language=objc)                                 | ✓    | ✓     |

These permissions are exported as constants of the `rn-apple-healthkit` module.

```javascript
import AppleHealthKit from 'rn-apple-healthkit';

// get the available permissions from AppleHealthKit.Constants object
const PERMS = AppleHealthKit.Constants.Permissions;

// setup healthkit read/write permissions using PERMS
const healthKitOptions = {
    permissions: {
        read:  [
            PERMS.StepCount,
            PERMS.Height,
        ],
        write: [
            PERMS.StepCount
        ],
    }
};
```

## Units
- bpm
- calorie
- celsius
- count
- day
- fahrenheit
- foot
- gram
- hour
- inch
- joule
- meter
- mgPerdL
- mile
- minute
- mmhg
- mmolPerL
- percent
- pound
- second


## References
- Apple Healthkit Documentation [https://developer.apple.com/Healthkit/](https://developer.apple.com/Healthkit/)

> *This package is an original fork of [react-native-apple-Healthkit](https://github.com/GregWilson/react-native-apple-Healthkit)*
