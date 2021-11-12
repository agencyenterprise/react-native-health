<img style="float: left;" src="https://i.imgur.com/q5PS8gU.png">

# React Native Health

A React Native package to interact with Apple HealthKit for iOS.

## Getting Started

> 🚨 Expo: This package is not available in the [Expo Go](https://expo.io/client) app. Learn how you can use it with [custom dev clients](/docs/Expo.md).

### Automatic Installation

1. Install the react-native-health package from [npm](https://www.npmjs.com/package/react-native-health)

```
yarn add react-native-health
```

2. If you are using [CocoaPods](https://cocoapods.org/) you can run the following
   from the `ios/` folder of your app

```
pod install
```

Or, if you need to manually link it, run

```
react-native link react-native-health
```

3. Update the `ios/<Project Name>/info.plist` file in your project

```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
<!-- Below is only required if requesting clinical health data -->
<key>NSHealthClinicalHealthRecordsShareUsageDescription</key>
<string>Read and understand clinical health data.</string>
```

To add Healthkit support to your application's `Capabilities`

- Open the `ios/` folder of your project in Xcode
- Select the project name in the left sidebar
- In the main view select '+ Capability' and double click 'HealthKit'

To enable access to clinical data types, check the `Clinical Health Records` box.

## Usage

In order to start collecting or saving data to HealthKit, you need to request
the user's permissions for the given data types. It can be done in the following
way

```typescript
import AppleHealthKit, {
  HealthValue,
  HealthKitPermissions,
} from 'react-native-health'

/* Permission options */
const permissions = {
  permissions: {
    read: [AppleHealthKit.Constants.Permissions.HeartRate],
    write: [AppleHealthKit.Constants.Permissions.Steps],
  },
} as HealthKitPermissions

AppleHealthKit.initHealthKit(permissions, (error: string) => {
  /* Called after we receive a response from the system */

  if (error) {
    console.log('[ERROR] Cannot grant permissions!')
  }

  /* Can now read or write to HealthKit */

  const options = {
    startDate: new Date(2020, 1, 1).toISOString(),
  }

  AppleHealthKit.getHeartRateSamples(
    options,
    (callbackError: string, results: HealthValue[]) => {
      /* Samples are now collected from HealthKit */
    },
  )
})
```

### Background Processing

For background capabilities, Apple allows developers to setup long running observer
queries for the health types needed.

To setup that in your app, in XCode open your `ios/AppDelegate.m` file and add the
following statements:

```objective-c
#import "AppDelegate.h"

...

/* Add the library import at the top of AppDelegate.m */
#import "RCTAppleHealthKit.h"

...

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self
                                            launchOptions:launchOptions];

  ...

  /* Add Background initializer for HealthKit  */
  [[RCTAppleHealthKit new] initializeBackgroundObservers:bridge];

  ...

  return YES;
}
```

After that you can start listening for data updates using the React Native
client. For more information, see [background observers](/docs/background.md).

## Documentation

There is a gitbook version for the documentation on this [link](https://docs.react-native-health.com/).

All the documentation is under the [docs](/docs) folder. Additionally,
they are splitted in the following categories

### Constants

- [Activities](/docs/activities.md)
- [Observers](/docs/observers.md)
- [Permissions](/docs/permissions.md)
- [Units](/docs/units.md)

### Base Methods

- [isAvailable](/docs/isAvailable.md)
- [initHealthKit](/docs/initHealthKit.md)
- [getAuthStatus](/docs/getAuthStatus.md)

### Background Methods

- [background observers](/docs/background.md)
- [initStepCountObserver](/docs/initStepCountObserver.md) - _DEPRECATED_
- [setObserver](/docs/setObserver.md) - _DEPRECATED_

### Activity Methods

- [getActiveEnergyBurned](/docs/getActiveEnergyBurned.md)
- [getBasalEnergyBurned](/docs/getBasalEnergyBurned.md)
- [getAppleStandTime](/docs/getAppleStandTime.md)

### Body Methods

- [getLatestHeight](/docs/getLatestHeight.md)
- [getLatestWeight](/docs/getLatestWeight.md)
- [getHeightSamples](/docs/getHeightSamples.md)
- [getWeightSamples](/docs/getWeightSamples.md)
- [getBodyTemperatureSamples](/docs/getBodyTemperatureSamples.md)
- [getLatestBodyFatPercentage](/docs/getLatestBodyFatPercentage.md)
- [getBodyFatPercentageSamples](/docs/getBodyFatPercentageSamples.md)
- [getLatestLeanBodyMass](/docs/getLatestLeanBodyMass.md)
- [getLeanBodyMassSamples](/docs/getLeanBodyMassSamples.md)
- [saveHeight](/docs/saveHeight.md)
- [saveWeight](/docs/saveWeight.md)
- [saveBodyFatPercentage](/docs/saveBodyFatPercentage.md)
- [saveBodyTemperature](/docs/saveBodyTemperature.md)
- [saveLeanBodyMass](/docs/saveLeanBodyMass.md)

### Characteristic Methods

- [getBiologicalSex](/docs/getBiologicalSex.md)
- [getDateOfBirth](/docs/getDateOfBirth.md)

### Clinical Records Methods

- [getClinicalRecords](/docs/getClinicalRecords.md)

### Dietary Methods

- [getEnergyConsumedSamples](/docs/getEnergyConsumedSamples.md)
- [getProteinSamples](/docs/getProteinSamples.md)
- [getTotalFatSamples](/docs/getTotalFatSamples.md)
- [saveFood](/docs/saveFood.md)
- [saveWater](/docs/saveWater.md)
- [getWater](/docs/getWater.md)

### Fitness Methods

- [getDailyStepCountSamples](/docs/getDailyStepCountSamples.md)
- [getStepCount](/docs/getStepCount.md)
- [getSamples](docs/getSamples.md)
- [getDailyDistanceWalkingRunningSamples](/docs/getDailyDistanceWalkingRunningSamples.md)
- [getDistanceWalkingRunning](/docs/getDistanceWalkingRunning.md)
- [getDailyDistanceSwimmingSamples](/docs/getDailyDistanceSwimmingSamples.md)
- [getDistanceSwimming](/docs/getDistanceSwimming.md)
- [getDailyDistanceCyclingSamples](/docs/getDailyDistanceCyclingSamples.md)
- [getDistanceCycling](/docs/getDistanceCycling.md)
- [getDailyFlightsClimbedSamples](/docs/getDailyFlightsClimbedSamples.md)
- [getFlightsClimbed](/docs/getFlightsClimbed.md)
- [saveSteps](/docs/saveSteps.md)

### Hearing Methods

- [getEnvironmentalAudioExposure](/docs/getEnvironmentalAudioExposure.md)
- [getHeadphoneAudioExposure](/docs/getHeadphoneAudioExposure.md)

### Lab Tests Methods

- [getBloodAlcoholContentSamples](/docs/getBloodAlcoholContentSamples.md)
- [getBloodGlucoseSamples](/docs/getBloodGlucoseSamples.md)
- [getLatestBloodAlcoholContent](/docs/getLatestBloodAlcoholContent.md)
- [saveBloodAlcoholContent](/docs/saveBloodAlcoholContent.md)
- [saveBloodGlucoseSample](/docs/saveBloodGlucoseSample.md)
- [deleteBloodGlucoseSample](/docs/deleteBloodGlucoseSample.md)

### Nutrition

- [getCarbohydratesSamples](/docs/getCarbohydratesSamples.md)
- [saveCarbohydratesSample](/docs/saveCarbohydratesSample.md)
- [deleteCarbohydratesSample](/docs/deleteCarbohydratesSample.md)

### Mindfulness Methods

- [getMindfulSession](docs/getMindfulSession.md)
- [saveMindfulSession](/docs/saveMindfulSession.md)

### Sleep Methods

- [getSleepSamples](/docs/getSleepSamples.md)

#### Vitals Methods

- [getBloodPressureSamples](/docs/getBloodPressureSamples.md)
- [getElectrocardiogramSamples](/docs/getElectrocardiogramSamples.md)
- [getHeartRateSamples](/docs/getHeartRateSamples.md)
- [getHeartRateVariabilitySamples](/docs/getHeartRateVariabilitySamples.md)
- [getHeartbeatSeriesSamples](/docs/getHeartbeatSeriesSamples.md)
- [getOxygenSaturationSamples](/docs/getOxygenSaturationSamples.md)
- [getRestingHeartRateSamples](/docs/getRestingHeartRateSamples.md)
- [getVo2MaxSamples](/docs/getVo2MaxSamples.md)
- [getLatestBmi](/docs/getLatestBmi.md)
- [getBmiSamples](/docs/getBmiSamples.md)
- [getRespiratoryRateSamples](/docs/getRespiratoryRateSamples.md)
- [getWalkingHeartRateAverage](/docs/getWalkingHeartRateAverage.md)
- [saveBmi](/docs/saveBmi.md)

#### Workout Methods

- [getSamples](docs/getSamples.md)
- [getAnchoredWorkouts](/docs/getAnchoredWorkouts.md)
- [saveWorkout](/docs/saveWorkout.md)

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
   ![](https://i.imgur.com/Ql1kXCg.png 'Xcode Capabilities Section')
7. Compile and run

## Contributing

We appreciate any additional request and/or contribution to `react-native-health`.
The [issues](https://github.com/agencyenterprise/react-native-health/issues) tracker
is used to keep a list of features and bugs to be worked on. Please see our
[contributing documentation](https://github.com/agencyenterprise/react-native-health/blob/master/CONTRIBUTING.md)
for some tips on getting started.

## References

- [Apple Healthkit Documentation](https://developer.apple.com/documentation/healthkit)

## Acknowledgement

> _This package is a fork of [rn-apple-healthkit](https://github.com/terrillo/rn-apple-healthkit)_

> _This package also inherits additional features from [Nutrisense](https://www.nutrisense.io/) fork_
