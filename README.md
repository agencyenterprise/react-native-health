# React Native Apple Healthkit
A React Native bridge module for interacting with [Apple Healthkit] data.

![Alt text](https://devimages.apple.com.edgekey.net/assets/elements/icons/Healthkit/Healthkit-64x64.png "Apple Healthkit")

## Table of Contents
  * [Getting Started](#getting-started)
    * [Installation](#installation)
    * [Usage](#usage)
  * [Documentation](#documentation)
    * [Permissions](#permissions)
    * [Methods](#methods)
      * [isAvailable](#isavailable)
      * [initHealthkit](#initHealthkit)
      * [getBiologicalSex](#getbiologicalsex)
      * [getDateOfBirth](#getdateofbirth)
      * [getStepCount](#getstepcount)
      * [getDailyStepCountSamples](#getdailystepcountsamples)
      * [initStepCountObserver](#initstepcountobserver)
      * [saveSteps](#savesteps)
      * [getDistanceWalkingRunning](#getdistancewalkingrunning)
      * [getDistanceCycling](#getdistancecycling)
      * [getFlightsClimbed](#getflightsclimbed)
      * [getLatestWeight](#getlatestweight)
      * [getWeightSamples](#getweightsamples)
      * [saveWeight](#saveweight)
      * [getLatestHeight](#getlatestheight)
      * [getHeightSamples](#getheightsamples)
      * [saveHeight](#saveheight)
      * [getLatestBmi](#getlatestbmi)
      * [saveBmi](#savebmi)
      * [getLatestBodyFatPercentage](#getlatestbodyfatpercentage)
      * [getLatestLeanBodyMass](#getlatestleanbodymass)
      * [getHeartRateSamples](#getheartratesamples)
      * [getBodyTemperatureSamples](#getbodytemperaturesamples)
      * [getBloodPressureSamples](#getbloodpressuresamples)
      * [getRespiratoryRateSamples](#getrespiratoryratesamples)
      * [getBloodGlucoseSamples](#getbloodglucosesamples)
      * [getSleepSamples](#getsleepsamples)
      * [saveMindfulSession](#saveMindfulSession)

## References
- Apple Healthkit Documentation [https://developer.apple.com/Healthkit/](https://developer.apple.com/Healthkit/)

## Getting started

###  Installation

Install the [rn-apple-Healthkit] package from npm:

- Run `npm install rn-apple-healthkit --save`
- Run `react-native link rn-apple-Healthkit`

Update `info.plist` in your React Native project
```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
```

### Manual Installation

1. Run `npm install rn-apple-healthkit --save`
2. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `rn-apple-Healthkit` and add `RCTAppleHealthkit.xcodeproj`
4. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthkit.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Click `RCTAppleHealthkit.xcodeproj` in the project navigator and go the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic'). In the `Search Paths` section, look for `Header Search Paths` and make sure it contains both `$(SRCROOT)/../../react-native/React` and `$(SRCROOT)/../../../React` - mark both as `recursive`.
6. Enable Healthkit in your application's `Capabilities`
![Alt text](/examples/images/Capabilities_Healthkit.png "Xcode Capabilities Section")
7. Compile and run

### Usage

Just `import` the `rn-apple-Healthkit` module and you're ready to go!

```javascript
import AppleHealthkit from 'rn-apple-Healthkit';

let options = {
    permissions: {
        read: ["Height", "Weight", "StepCount", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "StepCount", "BodyMassIndex"]
    }
};

AppleHealthkit.initHealthkit(options: Object, (err: Object, results: Object) => {
    if (err) {
        console.log("error initializing Healthkit: ", err);
        return;
    }
    // Healthkit initialized...
});


```

When the module has been successfully initialized you can read and write Healthkit data

```javascript
import AppleHealthkit from 'rn-apple-Healthkit';

AppleHealthkit.initHealthkit(null: Object, (err: string, results: Object) => {

  ...

  AppleHealthkit.getLatestWeight(null, (err: Object, weight: Object) => {
      if(err){
          console.log("error getting current weight: ", err);
          return;
      }
      // use weight.value
  });

  ...

  let options = {
    value: 200
  };
  AppleHealthkit.saveWeight(options: Object, (err: Object, results: Object) => {
      if (err) {
          console.log("error saving weight to Healthkit: ", err);
          return;
      }
      // weight successfully saved
  });

}


```


## Documentation

### Permissions

The available Healthkit permissions to use with `initHealthkit`

| Permission             | Healthkit Identifier Type                                                                                                                                      | Read | Write |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|------|-------|
<<<<<<< HEAD
| ActiveEnergyBurned     | [HKQuantityTypeIdentifierActiveEnergyBurned](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifieractiveenergyburned?language=objc)         | ✓    | ✓     |
| AppleExerciseTime      | [HKQuantityTypeIdentifierAppleExerciseTime](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierappleexercisetime?language=objc)           | ✓    |       |
| BasalEnergyBurned      | [HKQuantityTypeIdentifierBasalEnergyBurned](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbasalenergyburned?language=objc)           | ✓    | ✓     |
| BiologicalSex          | [HKCharacteristicTypeIdentifierBiologicalSex](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierbiologicalsex?language=objc)       | ✓    |       |
| BloodGlucose           | [HKQuantityTypeIdentifierBloodGlucose](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbloodglucose?language=objc)                     | ✓    |       |
| BodyMassIndex          | [HKQuantityTypeIdentifierBodyMassIndex](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymassindex?language=objc)                   | ✓    | ✓     |
| BodyTemperature        | [HKQuantityTypeIdentifierBodyTemperature](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodytemperature?language=objc)               | ✓    |       |
| DateOfBirth            | [HKCharacteristicTypeIdentifierDateOfBirth](https://developer.apple.com/reference/Healthkit/hkcharacteristictypeidentifierdateofbirth?language=objc)           | ✓    |       |
| DietaryEnergy          | [HKQuantityTypeIdentifierDietaryEnergyConsumed](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdietaryenergyconsumed?language=objc)   | ✓    | ✓     |
| DistanceCycling        | [HKQuantityTypeIdentifierDistanceCycling](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancecycling?language=objc)               | ✓    | ✓     |
| DistanceWalkingRunning | [HKQuantityTypeIdentifierDistanceWalkingRunning](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierdistancewalkingrunning?language=objc) | ✓    | ✓     |
| FlightsClimbed         | [HKQuantityTypeIdentifierFlightsClimbed](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierflightsclimbed?language=objc)                 | ✓    | ✓     |
| HeartRate              | [HKQuantityTypeIdentifierHeartRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheartrate?language=objc)                           | ✓    |       |
| Height                 | [HKQuantityTypeIdentifierHeight](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierheight?language=objc)                                 | ✓    | ✓     |
| LeanBodyMass           | [HKQuantityTypeIdentifierLeanBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierleanbodymass?language=objc)                     | ✓    | ✓     |
| NikeFuel               | [HKQuantityTypeIdentifierNikeFuel](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifiernikefuel?language=objc)                             | ✓    |       |
| RespiratoryRate        | [HKQuantityTypeIdentifierRespiratoryRate](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierrespiratoryrate?language=objc)               | ✓    |       |
| SleepAnalysis          | [HKCategoryTypeIdentifierSleepAnalysis](https://developer.apple.com/reference/Healthkit/hkcategorytypeidentifiersleepanalysis?language=objc)                   | ✓    |       |
| StepCount              | [HKQuantityTypeIdentifierStepCount](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierstepcount?language=objc)                           | ✓    | ✓     |
| Steps                  | [HKQuantityTypeIdentifierSteps](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifiersteps?language=objc)                                   | ✓    | ✓     |
| Weight                 | [HKQuantityTypeIdentifierBodyMass](https://developer.apple.com/reference/Healthkit/hkquantitytypeidentifierbodymass?language=objc)                             | ✓    | ✓     |

These permissions are exported as constants of the `rn-apple-Healthkit` module.


## Methods
=======
| DateOfBirth            | [HKCharacteristicTypeIdentifierDateOfBirth](https://developer.apple.com/reference/healthkit/hkcharacteristictypeidentifierdateofbirth?language=objc)           | ✓    |       |
| BiologicalSex          | [HKCharacteristicTypeIdentifierBiologicalSex](https://developer.apple.com/reference/healthkit/hkcharacteristictypeidentifierbiologicalsex?language=objc)       | ✓    |       |
| Height                 | [HKQuantityTypeIdentifierHeight](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierheight?language=objc)                                 | ✓    | ✓     |
| Weight                 | [HKQuantityTypeIdentifierBodyMass](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbodymass?language=objc)                             | ✓    | ✓     |
| BodyFatPercentage      | [HKQuantityTypeIdentifierBodyFatPercentage](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbodyfatpercentage?language=objc)           | ✓    | ✓     |
| BodyMassIndex          | [HKQuantityTypeIdentifierBodyMassIndex](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbodymassindex?language=objc)                   | ✓    | ✓     |
| LeanBodyMass           | [HKQuantityTypeIdentifierLeanBodyMass](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierleanbodymass?language=objc)                     | ✓    | ✓     |
| StepCount              | [HKQuantityTypeIdentifierStepCount](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierstepcount?language=objc)                           | ✓    | ✓     |
| DistanceWalkingRunning | [HKQuantityTypeIdentifierDistanceWalkingRunning](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierdistancewalkingrunning?language=objc) | ✓    | ✓     |
| DistanceCycling        | [HKQuantityTypeIdentifierDistanceCycling](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierdistancecycling?language=objc)               | ✓    | ✓     |
| BasalEnergyBurned      | [HKQuantityTypeIdentifierBasalEnergyBurned](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbasalenergyburned?language=objc)           | ✓    | ✓     |
| ActiveEnergyBurned     | [HKQuantityTypeIdentifierActiveEnergyBurned](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifieractiveenergyburned?language=objc)         | ✓    | ✓     |
| FlightsClimbed         | [HKQuantityTypeIdentifierFlightsClimbed](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierflightsclimbed?language=objc)                 | ✓    | ✓     |
| NikeFuel               | [HKQuantityTypeIdentifierNikeFuel](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifiernikefuel?language=objc)                             | ✓    |       |
| AppleExerciseTime      | [HKQuantityTypeIdentifierAppleExerciseTime](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierappleexercisetime?language=objc)           | ✓    |       |
| DietaryEnergy          | [HKQuantityTypeIdentifierDietaryEnergyConsumed](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierdietaryenergyconsumed?language=objc)   | ✓    | ✓     |
| HeartRate              | [HKQuantityTypeIdentifierHeartRate](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierheartrate?language=objc)                           | ✓    |       |
| BodyTemperature        | [HKQuantityTypeIdentifierBodyTemperature](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbodytemperature?language=objc)               | ✓    |       |
| BloodPressureSystolic  | [HKQuantityTypeIdentifierBloodPressureSystolic](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbloodpressuresystolic?language=objc)   | ✓    |       |
| BloodPressureDiastolic | [HKQuantityTypeIdentifierBloodPressureDiastolic](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbloodpressurediastolic?language=objc) | ✓    |       |
| RespiratoryRate        | [HKQuantityTypeIdentifierRespiratoryRate](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierrespiratoryrate?language=objc)               | ✓    |       |
| BloodGlucose           | [HKQuantityTypeIdentifierBloodGlucose](https://developer.apple.com/reference/healthkit/hkquantitytypeidentifierbloodglucose?language=objc)                     | ✓    |       
|
| SleepAnalysis          | [HKCategoryTypeIdentifierSleepAnalysis](https://developer.apple.com/reference/healthkit/hkcategorytypeidentifiersleepanalysis?language=objc)                   | ✓    |     
| MindfulSession         | [HKCategoryTypeIdentifierMindfulSession](https://developer.apple.com/reference/healthkit/hkcategorytypeidentifiermindfulsession?language=objc)                 |      |  ✓    |



These permissions are exported as constants of the `react-native-apple-healthkit` module.

```javascript
import AppleHealthKit from 'react-native-apple-healthkit';

...

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

...
```


Options
-------


Methods
-------
>>>>>>> 5adade4a95b5b3cd1816a8d203c1e36a702cfa8a

#### **`isAvailable`**
Check if Healthkit is available on the device.
```javascript
import AppleHealthkit from 'rn-apple-Healthkit';

AppleHealthkit.isAvailable((err: Object, available: boolean) => {
    if (available) {
        // ...
    }
});
```
___

#### **`initHealthkit`**
Initialize Healthkit. This will show the Healthkit permissions prompt for any read/write permissions set in the required `options` object.

Due to Apple's privacy model if an app user has previously denied a specific permission then they can not be prompted again for that same permission. The app user would have to go into the Apple Health app and grant the permission to your react-native app under *sources* tab.

For any data that is read from Healthkit the status/error is the same for both. This privacy restriction results in having no knowledge of whether the permission was denied (make sure it's added to the permissions options object), or the data for the specific request was nil (ex. no steps recorded today).

For any data written to Healthkit an authorization error can be caught. If an authorization error occurs you can prompt the user to set the specific permission or add the permission to the options object if not present.

If new read/write permissions are added to the options object then the app user will see the Healthkit permissions prompt with the new permissions to allow.

`initHealthkit` requires an options object with Healthkit permission settings
```javascript
let options = {
    permissions: {
        read: ["Height", "Weight", "StepCount", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "StepCount", "BodyMassIndex"]
    }
};
```

```javascript
AppleHealthkit.initHealthkit(options: Object, (err: string, results: Object) => {
    if (err) {
        console.log("error initializing Healthkit: ", err);
        return;
    }
    // Healthkit is initialized...
    // now safe to read and write Healthkit data...
});
```

___

#### **`getBiologicalSex`**
Get the biological sex (gender). If the `BiologicalSex` read permission is missing or the user has denied it then the value will be `unknown`. The possible values are:

| Value   | HKBiologicalSex       |
|---------|-----------------------|
| unknown | HKBiologicalSexNotSet |
| male    | HKBiologicalSexMale   |
| female  | HKBiologicalSexFemale |
| other   | HKBiologicalSexOther  |

```javascript
AppleHealthkit.getBiologicalSex(null, (err: Object, results: Object) => {
    if (this._handleHealthkitError(err, 'getBiologicalSex')) {
      return;
    }
    console.log(results)
});
```

```javascript
{
	value: 'female',
}
```

___

#### **`getDateOfBirth`**
Get the date of birth.

On success, the callback function will be provided with a `res` object containing dob `value: string` (ISO timestamp), and `age: number` (age in years):
```javascript
AppleHealthkit.getDateOfBirth(null, (err: Object, results: Object) => {
    if (this._handleHealthkitError(err, 'getDateOfBirth')) {
        return;
    }
    console.log(results)
});
```

```javascript
{
	value: '1986-09-01T00:00:00.000-0400',
	age: 29
}
```

___

#### **`getStepCount`**
Get the aggregated total steps for a specific day (starting and ending at midnight).

An optional options object may be provided containing `date` field representing the selected day. If `date` is not set or an options object is not provided then the current day will be used.
```javascript
let d = new Date(2016,1,1);
let options = {
    date: d.toISOString()
};
```

```javascript
AppleHealthkit.getStepCount(options: Object, (err: Object, results: Object) => {
    if (this._handleHealthkitError(err, 'getStepCount')) {
        return;
    }
    console.log(results)
});
```

```javascript
{
	value: 213,
}
```

___

#### **`getDailyStepCountSamples`**
Get the total steps per day over a specified date range.

`getDailyStepCountSamples` accepts an options object containing required *`startDate: ISO8601Timestamp`* and optional *`endDate: ISO8601Timestamp`*. If `endDate` is not provided it will default to the current time
```javascript
let options = {
    startDate: (new Date(2016,1,1)).toISOString() // required
    endDate:   (new Date()).toISOString() // optional; default now
};
```

```javascript
 AppleHealthkit.getDailyStepCountSamples(options: Object, (err: Object, results: Array<Object>) => {
    if (this._handleHealthkitError(err, 'getDailyStepCountSamples')) {
        return;
    }
    console.log(results)
});
```

The function will be called with an array of elements. Each element is an object containing `value`, `startDate`, and `endDate` fields:
```javascript
[
  { value: 8, startDate: '2016-07-09T00:00:00.000-0400', endDate: '2016-07-10T00:00:00.000-0400' },
  { value: 1923, startDate: '2016-07-08T00:00:00.000-0400', endDate: '2016-07-09T00:00:00.000-0400' },
  { value: 1802, startDate: '2016-07-07T00:00:00.000-0400', endDate: '2016-07-08T00:00:00.000-0400' },
]
```

___

#### **`initStepCountObserver`**
Setup an HKObserverQuery for step count (HKQuantityTypeIdentifierStepCount) that will
trigger an event listenable on react-native `NativeAppEventEmitter` when the
Healthkit step count has changed.

The `initStepCountObserver` method must be called before adding a listener to
NativeAppEventEmitter. After the step count observer has been initialized you can
listen to the NativeAppEventEmitter `change:steps` event and re-fetch relevent
step count data in the event handler.

The `initStepCountObserver` method should be called after Healthkit has been
successfully initialized (AppleHealthkit.initHealthkit has been called without
error).

```javascript
// import NativeAppEventEmitter from react-native
import {
  Navigator,
  View,
  NativeAppEventEmitter,
} from 'react-native';
```


```javascript
AppleHealthkit.initHealthkit(HKOPTIONS, (err, res) => {
  if (this._handleHKError(err, 'initHealthkit')) {
    return;
  }

  // initialize the step count observer
  AppleHealthkit.initStepCountObserver({}, () => {});

  // add event listener for 'change:steps' and handle the
  // event in the event handler function.
  //
  // when adding a listener, a 'subscription' object is
  // returned that must be used to remove the listener
  // when the component unmounts. The subscription object
  // must be accessible to any function/method/instance
  // that will be unsubscribing from the event.
  this.sub = NativeAppEventEmitter.addListener(
    'change:steps',
    (evt) => {
      // a 'change:steps' event has been received. step
      // count data should be re-fetched from Healthkit.
      this._fetchStepCountData();
    }
  );

  // other tasks to perform after Healthkit has been
  // initialized (fetch relevant Healthkit data).
  this._fetchStepCountData();
  this._fetchOtherRelevantHealthkitData();
  // ...
});

...

// when the component where the listener was added unmounts
// (or whenever the listener should be removed), call the
// 'remove' method of the subscription object.
componentWillUnmount() {
  this.sub.remove();
}
```

___

#### **`saveSteps`**
Save a step count sample.

A step count sample represents the number of steps during a specific period of time. A sample should be a precise as possible, with startDate and endDate representing the range of time the steps were taken in.

`saveSteps` accepts an options object containing required *`value: number`*, *`startDate: ISO8601Timestamp`*, and *`endDate: ISO8601Timestamp`*.
```javascript
// startDate and endDate are 30 minutes apart.
// this means the step count value occurred within those 30 minutes.
let options = {
  value: 100,
  startDate: (new Date(2016,6,2,6,0,0)).toISOString(),
  endDate: (new Date(2016,6,2,6,30,0)).toISOString()
};
```

```javascript
AppleHealthkit.saveSteps(options, (err, res) => {
  if (this._handleHKError(err, 'saveSteps')) {
    return;
  }
  // step count sample successfully saved
});
```

___

#### **`getDistanceWalkingRunning`**
Get the total distance walking/running on a specific day.

`getDistanceWalkingRunning` accepts an options object containing optional *`date: ISO8601Timestamp`* and *`unit: string`*. If `date` is not provided it will default to the current time. `unit` defaults to `meter`.

```javascript
let options = {
  unit: 'mile', // optional; default 'meter'
  date: (new Date(2016,5,1)).toISOString(), // optional; default now
};
```

```javascript
AppleHealthkit.getDistanceWalkingRunning(options: Object, (err: Object, results: Object) => {
    if (this._handleHKError(err, 'getDistanceWalkingRunning')) {
    	return;
    }
    console.log(results)
});
```

```javascript
{
	value: 1.45,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`getDistanceCycling`**
Get the total distance cycling on a specific day.

`getDistanceCycling` accepts an options object containing optional *`date: ISO8601Timestamp`* and *`unit: string`*. If `date` is not provided it will default to the current time. `unit` defaults to `meter`
```javascript
let options = {
  unit: 'mile', // optional; default 'meter'
  date: (new Date(2016,5,1)).toISOString(), // optional; default now
};
```

```javascript
AppleHealthkit.getDistanceCycling(options: Object, (err: Object, results: Object) => {
    if (err) {
    	return;
    }
    console.log(results)
});
```

```javascript
{
	value: 11.45,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`getFlightsClimbed`**
get the total flights climbed (1 flight is ~10ft of elevation) on a specific day.

`getFlightsClimbed` accepts an options object containing optional *`date: ISO8601Timestamp`*. if `date` is not provided it will default to the current time.
```javascript
let options = {
    date: (new Date(2016,5,1)).toISOString(), // optional; default now
};
```

```javascript
AppleHealthkit.getFlightsClimbed(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
{
	value: 15,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`getLatestWeight`**
Get the most recent weight sample.

On success, the callback function will be provided with a `weight` object containing the weight `value`, and the `startDate` and `endDate` of the weight sample. *Note: startDate and endDate will be the same as weight samples are saved at a specific point in time.*

```javascript
let options = {
  unit: 'pound'
};
```

```javascript
AppleHealthkit.getLatestWeight(options, (err: string, results: Object) => {
  if (err) {
    console.log("error getting latest weight: ", err);
    return;
  }
  console.log(results)
});
```

```javascript
{
	value: 200,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`getWeightSamples`**
query for weight samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'pound', // optional; default 'pound'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
};
```

```javascript
AppleHealthkit.getWeightSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
  { value: 160, startDate: '2016-07-09T00:00:00.000-0400', endDate: '2016-07-10T00:00:00.000-0400' },
  { value: 161, startDate: '2016-07-08T00:00:00.000-0400', endDate: '2016-07-09T00:00:00.000-0400' },
  { value: 165, startDate: '2016-07-07T00:00:00.000-0400', endDate: '2016-07-08T00:00:00.000-0400' },
]
```

___

#### **`saveWeight`**
save a numeric weight value to Healthkit

`saveWeight` accepts an options object containing a numeric weight value:
```javascript
let options = {
  value: 200
}
```

```javascript
AppleHealthkit.saveWeight(options: Object, (err: Object, results: Object) => {
    if (err) {
        console.log("error saving weight to Healthkit: ", err);
        return;
    }
    // Done
});
```

___

#### **`getLatestHeight`**
Get the most recent height value.

On success, the callback function will be provided with a `height` object containing the height `value`, and the `startDate` and `endDate` of the height sample. *Note: startDate and endDate will be the same as height samples are saved at a specific point in time.*

```javascript
AppleHealthkit.getLatestHeight(null, (err: string, results: Object) => {
    if (err) {
        console.log("error getting latest height: ", err);
        return;
    }
    console.log(results)
});
```

```javascript
{
	value: 72,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`getHeightSamples`**
query for height samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'inch', // optional; default 'inch'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10, // optional; default no limit
};
```

```javascript
AppleHealthkit.getHeightSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

The callback function will be called with a `samples` array containing objects with `value`, `startDate`, and `endDate` fields
```javascript
[
	{ value: 74.02, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400' },
	{ value: 74, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
```

___

#### **`saveHeight`**
save a numeric height value to Healthkit

`saveHeight` accepts an options object containing a numeric height value:
```javascript
let options = {
  value: 200
}
```

```javascript
AppleHealthkit.saveHeight(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  // height successfully saved
});
```

___

#### **`getLatestBmi`**
Get the most recent BMI sample.

On success, the callback function will be provided with a `bmi` object containing the BMI `value`, and the `startDate` and `endDate` of the sample. *Note: startDate and endDate will be the same as bmi samples are saved at a specific point in time.*
```javascript
AppleHealthkit.getLatestBmi(null, (err: string, results: Object) => {
    if (err) {
        console.log("error getting latest bmi data: ", err);
        return;
    }
    console.log(results)
});
```

```javascript
{
	value: 27.2,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`saveBmi`**
save a numeric BMI value to Healthkit

`saveBmi` accepts an options object containing a numeric BMI value:
```javascript
let options = {
  value: 27.2
}
```
```javascript
AppleHealthkit.saveBmi(options: Object, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  // BMI successfully saved
});
```

___

#### **`getLatestBodyFatPercentage`**
Get the most recent body fat percentage. The percentage value is a number between 0 and 100.

On success, the callback function will be provided with a `bodyFatPercentage` object containing the body fat percentage `value`, and the `startDate` and `endDate` of the sample. *Note: startDate and endDate will be the same as bodyFatPercentage samples are saved at a specific point in time.*

```javascript
AppleHealthkit.getLatestBodyFatPercentage(null, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
{
	value: 20,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`getLatestLeanBodyMass`**
Get the most recent lean body mass. The value is a number representing the weight in pounds (lbs)

On success, the callback function will be provided with a `leanBodyMass` object containing the leanBodyMass `value`, and the `startDate` and `endDate` of the sample. *Note: startDate and endDate will be the same as leanBodyMass samples are saved at a specific point in time.*

```javascript
 AppleHealthkit.getLatestLeanBodyMass(null, (err: Object, results: Object) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
{
	value: 176,
	startDate: '2016-07-08T12:00:00.000-0400',
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

___

#### **`getHeartRateSamples`**
query for heart rate samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'bpm', // optional; default 'bpm'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10, // optional; default no limit
};
```

the callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields
```javascript
AppleHealthkit.getHeartRateSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
	{ value: 74.02, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400' },
	{ value: 74, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
```

___

#### **`getBodyTemperatureSamples`**
query for body temperature samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'celsius', // optional; default 'celsius'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10,	// optional; default no limit
};
```
available units are: `'fahrenheit'`, `'celsius'`.

the callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields.

```javascript
AppleHealthkit.getBodyTemperatureSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
		return;
	}
	console.log(results)
});
```

```javascript
[
	{ value: 74.02, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400' },
	{ value: 74, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
```

___

#### **`getBloodPressureSamples`**
query for blood pressure samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'mmhg',	// optional; default 'mmhg'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(),	// optional; default now
  ascending: false,	// optional; default false
  limit:10, // optional; default no limit
};
```

the callback function will be called with a `samples` array containing objects with *bloodPressureSystolicValue*, *bloodPressureDiastolicValue*, *startDate*, and *endDate* fields

```javascript
AppleHealthkit.getBloodPressureSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

```javascript
[
  { bloodPressureSystolicValue: 120, bloodPressureDiastolicValue: 81, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400' },
  { bloodPressureSystolicValue: 119, bloodPressureDiastolicValue: 77, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400' },
]
```


___

#### **`getRespiratoryRateSamples`**
query for respiratory rate samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'bpm', // optional; default 'bpm'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10, // optional; default no limit
};
```

the callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields

```javascript
AppleHealthkit.getRespiratoryRateSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

___

#### **`getBloodGlucoseSamples`**
query for blood glucose samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
  unit: 'mmolPerL',	// optional; default 'mmolPerL'
  startDate: (new Date(2016,4,27)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  ascending: false, // optional; default false
  limit:10,	// optional; default no limit
};
```
available units are: `'mmolPerL'`, `'mgPerdL'`.

the callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields

```javascript
AppleHealthkit.getBloodGlucoseSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results)
});
```

___

#### **`getSleepSamples`**
query for sleep samples.

each sleep sample represents a period of time with a startDate and an endDate.
the sample's value will be either `INBED` or `ASLEEP`. these values should overlap,
meaning that two (or more) samples represent a single nights sleep activity. see
[Healthkit SleepAnalysis] reference documentation

the options object is used to setup a query to retrieve relevant samples.
the options must contain `startDate` and may also optionally include `endDate`
and `limit` options
```javascript
let options = {
  startDate: (new Date(2016,10,1)).toISOString(), // required
  endDate: (new Date()).toISOString(), // optional; default now
  limit:10, // optional; default no limit
};
```

The callback function will be called with a `samples` array containing objects
with *value*, *startDate*, and *endDate* fields

```javascript
AppleHealthkit.getSleepSamples(options, (err: Object, results: Array<Object>) => {
  if (err) {
    return;
  }
  console.log(results).
});
```

#### **`saveMindfulSession`**

each mindfulness sample represents a period of time with a startDate and an endDate.
the options must contain `startDate` and `endDate`

```javascript
let options = {
    startDate: (new Date(2016,10,1)).toISOString(), // required
    endDate: (new Date()).toISOString(), // optional; default now
};

```

```
AppleHealthKit.saveMindfulSession(options, (err, res) => {
  if (err) return {
    return
  }
  console.log('Mindful session saved')
});
```

> *This package is fork from [react-native-apple-Healthkit](https://github.com/GregWilson/react-native-apple-Healthkit)*
