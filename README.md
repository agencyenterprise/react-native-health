<img style="float: left;" src="https://i.imgur.com/q5PS8gU.png">

# React Native Health
A React Native package to interact with Apple HealthKit for iOS.

## Getting Started

### Automatic Installation

Install the react-native-health package from [npm](https://www.npmjs.com/package/react-native-health)

```
yarn add react-native-health
```

If you are using [CocoaPods](https://cocoapods.org/) you can run the following
from the `ios/` folder of your app

```
pod install
```

Or, if you need to manually link it, run

```
react-native link react-native-health
```

Update the `ios/<Project Name>/info.plist` file in your project
```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
```

To add Healthkit support to your application's `Capabilities`
* Open the `ios/` folder of your project in Xcode
* Select the project name in the left sidebar
* In the main view select '+ Capability' and double click 'HealthKit'

## Usage

In order to start collecting or saving data to HealthKit, you need to request
the user's permissions for the given data types. It can be done in the following
way

```typescript
import AppleHealthKit, { HealthValue, HealthKitPermissions } from 'react-native-health';

/* Permission options */
const permissions = {
  permissions: {
    read: [
      AppleHealthKit.Constants.Permissions.HeartRate,
    ],
    write: [
      AppleHealthKit.Constants.Permissions.Steps,
    ],
  }
} as HealthKitPermissions


AppleHealthKit.initHealthKit(permissions, (error: string) => {
  /* Called after we receive a response from the system */

  if (error) {
   console.log('[ERROR] Cannot grant permissions!')
  }

  /* Can now read or write to HealthKit */

  const options = {
    startDate: (new Date(2020, 1, 1)).toISOString(),
  }

  AppleHealthKit.getHeartRateSamples(options, (callbackError: string, results: HealthValue[]) => {
    /* Samples are now collected from HealthKit */
  });
}
```

## Documentation

All the documentation is under the [docs](/docs) folder. Additionally,
they are splitted in the following categories

### Constants
  * [Activities](/docs/activities.md)
  * [Observers](/docs/observers.md)
  * [Permissions](/docs/permissions.md)
  * [Units](/docs/units.md)

### Base Methods
  * [isAvailable](/docs/isAvailable.md)
  * [initHealthKit](/docs/initHealthKit.md)
  * [authorizationStatusForType](/docs/authorizationStatusForType.md)

### Background Methods
  * [initStepCountObserver](/docs/initStepCountObserver.md)
  * [setObserver](/docs/setObserver.md)

### Activity Methods
  * [getActiveEnergyBurned](/docs/getActiveEnergyBurned.md)
  * [getBasalEnergyBurned](/docs/getBasalEnergyBurned.md)

### Body Methods
  * [getLatestHeight](/docs/getLatestHeight.md)
  * [getLatestWeight](/docs/getLatestWeight.md)
  * [getHeightSamples](/docs/getHeightSamples.md)
  * [getWeightSamples](/docs/getWeightSamples.md)
  * [getBodyTemperatureSamples](/docs/getBodyTemperatureSamples.md)
  * [getLatestBodyFatPercentage](/docs/getLatestBodyFatPercentage.md)
  * [getBodyFatPercentageSamples](/docs/getBodyFatPercentageSamples.md)
  * [getLatestLeanBodyMass](/docs/getLatestLeanBodyMass.md)
  * [getLeanBodyMassSamples](/docs/getLeanBodyMassSamples.md)
  * [saveHeight](/docs/saveHeight.md)
  * [saveWeight](/docs/saveWeight.md)
  * [saveBodyFatPercentage](/docs/saveBodyFatPercentage.md)
  * [saveLeanBodyMass](/docs/saveLeanBodyMass.md)

### Characteristic Methods
  * [getBiologicalSex](/docs/getBiologicalSex.md)
  * [getDateOfBirth](/docs/getDateOfBirth.md)

### Dietary Methods
  * [saveFood](/docs/saveFood.md)
  * [saveWater](/docs/saveWater.md)

### Fitness Methods
  * [getDailyStepCountSamples](/docs/getDailyStepCountSamples.md)
  * [getStepCount](/docs/getStepCount.md)
  * [getSamples](docs/getSamples.md)
  * [getDailyDistanceWalkingRunningSamples](/docs/getDailyDistanceWalkingRunningSamples.md)
  * [getDistanceWalkingRunning](/docs/getDistanceWalkingRunning.md)
  * [getDistanceSwimming](/docs/getDistanceSwimming.md)
  * [getDailyDistanceCyclingSamples](/docs/getDailyDistanceCyclingSamples.md)
  * [getDistanceCycling](/docs/getDistanceCycling.md)
  * [getDailyFlightsClimbedSamples](/docs/getDailyFlightsClimbedSamples.md)
  * [getFlightsClimbed](/docs/getFlightsClimbed.md)
  * [saveSteps](/docs/saveSteps.md)

### Lab Tests Methods
  * [getBloodAlcoholContentSamples](/docs/getBloodAlcoholContentSamples.md)
  * [getBloodGlucoseSamples](/docs/getBloodglucoseSamples.md)
  * [getLatestBloodAlcoholContent](/docs/getLatestBloodAlcoholContent.md)
  * [saveBloodAlcoholContent](/docs/saveBloodAlcoholContent.md)
  * [saveBloodGlucoseSample](/docs/saveBloodGlucoseSample.md)

### Mindfulness Methods
  * [getMindfulSession](docs/getMindfulSession.md)
  * [saveMindfulSession](/docs/saveMindfulSession.md)

### Sleep Methods
  * [getSleepSamples](/docs/getSleepSamples.md)

#### Vitals Methods
  * [getBloodPressureSamples](/docs/getBloodPressureSamples.md)
  * [getHeartRateSamples](/docs/getHeartRateSamples.md)
  * [getHeartRateVariabilitySamples](/docs/getHeartRateVariabilitySamples.md)
  * [getRestingHeartRateSamples](/docs/getRestingHeartRateSamples.md)
  * [getVo2MaxSamples](/docs/getVo2MaxSamples.md)
  * [getLatestBmi](/docs/getLatestBmi.md)
  * [getRespiratoryRateSamples](/docs/getRespiratoryRateSamples.md)
  * [saveBmi](/docs/saveBmi.md)

#### Workout Methods
  * [getWorkout](/docs/getWorkout.md)
  * [saveWorkout](/docs/saveWorkout.md)

## Additional Information

### Permissions

Due to Apple's privacy model, if a user has previously denied a
specific permission they will not be prompted again for that permission.
The user will need to go into the Apple Health app and grant the
permission to your app.

For any data written to Healthkit, an authorization error can be caught. If
an authorization error occurs, you can prompt the user to set the
specific permission or add the permission to the options object when
initializing the library.

If extra read or write permissions are added to the options object, the
app will request for user's permission to them when the library is
initialized again.


### Manual Installation

1. Run `yarn add react-native-health`
2. In XCode, in the project navigator, right-click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `react-native-health` and add `RCTAppleHealthkit.xcodeproj`
4. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthkit.a`
to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Click `RCTAppleHealthkit.xcodeproj` in the project navigator and go
the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic').
In the `Search Paths` section, look for `Header Search Paths` and make sure
it contains both `$(SRCROOT)/../../react-native/React`
and `$(SRCROOT)/../../../React` - mark both as `recursive`.
6. Enable Healthkit in your application's `Capabilities`
![](https://i.imgur.com/Ql1kXCg.png "Xcode Capabilities Section")
7. Compile and run

## Contributing

We appreciate any additional request and/or contribution to `react-native-health`.
The [issues](https://github.com/agencyenterprise/react-native-health/issues) tracker
is used to keep a list of features and bugs to be worked on.

## References
- [Apple Healthkit Documentation](https://developer.apple.com/documentation/healthkit)

## Acknowledgement

> *This package is a fork of [rn-apple-healthkit](https://github.com/terrillo/rn-apple-healthkit)*

> *This package also inherits additional features from [Nutrisense](https://www.nutrisense.io/) fork*
