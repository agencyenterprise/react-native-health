# react-native-apple-healthkit
A React Native bridge module for interacting with [Apple HealthKit] data. 

![Alt text](https://devimages.apple.com.edgekey.net/assets/elements/icons/healthkit/healthkit-64x64.png "Apple HealthKit")


#### Notice
> *This package is undergoing rapid development and should be considered unstable for the time being.*
> *<strong>Use at your own risk</strong>*

## Table of Contents
  * [Getting Started](#getting-started)
    * [Installation](#installation)
    * [Usage](#usage)
  * [Documentation](#documentation)
    * [Permissions](#permissions)
    * [Methods](#methods)
      * [isAvailable](#isavailable)
      * [initHealthKit](#inithealthkit)
      * [getBiologicalSex](#getbiologicalsex)
      * [getDateOfBirth](#getdateofbirth)
      * [getStepCount](#getstepcount)
      * ~~[getStepCountForToday](#getstepcountfortoday)~~
      * ~~[getStepCountForDay](#getstepcountforday)~~
      * [getDailyStepCountSamples](#getdailystepcountsamples)
      * ~~[getMultiDayStepCounts](#getmultidaystepcounts)~~
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
  * [Examples](#examples)
  

## Getting started

###  Installation

Install the [react-native-apple-healthkit] package from npm:

`npm install react-native-apple-healthkit --save`

##### Xcode
  
1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-apple-healthkit` and add `RCTAppleHealthKit.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthKit.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Click `RCTAppleHealthKit.xcodeproj` in the project navigator and go the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic'). In the `Search Paths` section, look for `Header Search Paths` and make sure it contains both `$(SRCROOT)/../../react-native/React` and `$(SRCROOT)/../../../React` - mark both as `recursive`.
5. Enable HealthKit in your application's `Capabilities`
![Alt text](/examples/images/Capabilities_HealthKit.png "Xcode Capabilities Section")

6. Compile and run

### Usage

Just `require` the `react-native-apple-healthkit` module and you're ready to go!
```javascript
var AppleHealthKit = require('react-native-apple-healthkit');

...

let options = {
    permissions: {
        read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "Steps", "BodyMassIndex"]
    }
};

AppleHealthKit.initHealthKit(options: Object, (err: Object, res: Object) => {
    if(err) {
        console.log("error initializing healthkit: ", err);
        return;
    }
    // healthkit initialized...
});


```

When the module has been successfully initialized you can read and write HealthKit data

```javascript
var AppleHealthKit = require('react-native-apple-healthkit');
var _ = require('lodash');

...

AppleHealthKit.getLatestWeight(null, (err: Object, weight: Object) => {
    if(err){
        console.log("error getting current weight: ", err);
        return;
    }
    // use weight.value ...
});

...

let options = {value: 200};
AppleHealthKit.saveWeight(options: Object, (err: Object, res: Object) => {
    if(err){
        console.log("error saving weight to healthkit: ", err);
        return;
    }
    // weight successfully saved
});


```



## Documentation

Permissions
-----------

The available HealthKit permissions to use with `initHealthKit` 

| Permission             | HealthKit Identifier Type                                                                                                                                      | Read | Write |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|------|-------|
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

These permissions are exported as constants of the `react-native-apple-healthkit` module.

```javascript
import AppleHealthKit from 'react-native-apple-healthkit';

...

// get the available permissions from AppleHealthKit.Constants object
const PERMS = AppleHealthKit.Constants.Permissions;

// setup healthkit read/write permissions from PERMS
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

#### **`isAvailable`** 
Check if HealthKit is available on the device.
```javascript
AppleHealthKit.isAvailable((err: Object, available: boolean) => {
    if(available){
        // ...
    }
});
```
___

#### **`initHealthKit`** 
Initialize HealthKit. This will show the HealthKit permissions prompt for any read/write permissions set in the required `options` object. 

Due to Apple's privacy model if an app user has previously denied a specific permission then they can not be prompted again for that same permission. The app user would have to go into the Apple Health app and grant the permission to your react-native app under *sources* tab. 

For any data that is read from HealthKit the status/error is the same for both. This privacy restriction results in having no knowledge of whether the permission was denied (make sure it's added to the permissions options object), or the data for the specific request was nil (ex. no steps recorded today).

For any data written to HealthKit an authorization error can be caught. If an authorization error occurs you can prompt the user to set the specific permission or add the permission to the options object if not present.

If new read/write permissions are added to the options object then the app user will see the HealthKit permissions prompt with the new permissions to allow.

`initHealthKit` requires an options object with HealthKit permission settings
```javascript
let options = {
    permissions: {
        read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "Steps", "BodyMassIndex"]
    }
};
```

```javascript
AppleHealthKit.initHealthKit(options: Object, (err: string, res: Object) => {
    if(err) {
        console.log("error initializing healthkit: ", err);
        return;
    }
    // healthkit is initialized...
    // now safe to read and write healthkit data...
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
AppleHealthKit.getBiologicalSex(null, (err: Object, bioSex: string) => {
    if(this._handleHealthKitError(err, 'getBiologicalSex')){
        return;
    }
    // use bioSex ...
});
```

___

#### **`getDateOfBirth`**
Get the date of birth. This will be an ISO timestamp

```javascript
AppleHealthKit.getDateOfBirth(null, (err: Object, dob: string) => {
    if(this._handleHealthKitError(err, 'getDateOfBirth')){
        return;
    }
    // use dob ... (ex: '1986-09-01T12:20:30-04:00')
});
```

___

#### **`getStepCount`**
Get the aggregated total steps for a specific day (starting and ending at midnight). 

An optional options object may be provided containing `date` field representing the selected day. If `date` is not set or an options object is not provided then the current day will be used. 
```javascript
let d = new Date(2016,5,27);
let options = {
    date: d.toISOString()
};
```

```javascript
AppleHealthKit.getStepCount(options: Object, (err: Object, steps: Object) => {
    if(this._handleHealthKitError(err, 'getStepCount')){
        return;
    }
    // steps.value is the step count for day 'd'
});
```

___

#### ~~**`getStepCountForToday`**~~
**removed** - replaced by `getStepCount`

get the aggregated total steps for the current day starting and ending at midnight
```javascript
AppleHealthKit.getStepCountForToday(null, (err: Object, steps: number) => {
    if(this._handleHealthKitError(err, 'getStepCountForToday')){
        return;
    }
    // use steps...
});
```

___

#### ~~**`getStepCountForDay`**~~
**removed** - replaced by `getStepCount`

get the the aggregated total steps for the day provided as `date` in options object. the `date` field expects an ISO date string as its value
```javascript
let d = new Date(2016,5,27);
let options = {
    date: d.toISOString()
};
AppleHealthKit.getStepCountForDay(options: Object, (err: Object, steps: number) => {
    if(this._handleHealthKitError(err, 'getStepCountForDay')){
        return;
    }
    // steps is the step count for day 'd'
});
```

___

#### **`getDailyStepCountSamples`**
Get the total steps per day over a specified date range. 

`getDailyStepCountSamples` accepts an options object containing required *`startDate: ISO8601Timestamp`* and optional *`endDate: ISO8601Timestamp`*. If `endDate` is not provided it will default to the current time
```javascript
let options = {
    startDate: (new Date(2016,5,1)).toISOString()  // required
    endDate:   (new Date()).toISOString()          // optional; default now
};
```
The function will be called with an array of elements. Each element is an object containing `value`, `startDate`, and `endDate` fields:
```javascript
[ 
  { value: 8, startDate: '2016-07-09T00:00:00.000-0400', endDate: '2016-07-10T00:00:00.000-0400' },
  { value: 1923, startDate: '2016-07-08T00:00:00.000-0400', endDate: '2016-07-09T00:00:00.000-0400' },
  { value: 1802, startDate: '2016-07-07T00:00:00.000-0400', endDate: '2016-07-08T00:00:00.000-0400' },
  ...
]
```


```javascript
 AppleHealthKit.getDailyStepCountSamples(options: Object, (err: Object, res: Array<Object>) => {
    if(this._handleHealthKitError(err, 'getDailyStepCountSamples')){
        return;
    }
    // 'res' is array of {value: number, startDate: string, endDate: string} objects
    // sorted ascending from startDate through endDate
    for(let i=0; i<res.length; ++i){
        let elem = res[i];
        let stepCount = elem.value;
        let day = elem.startDate;
		// ...
    }
});
```

___

#### ~~**`getMultiDayStepCounts`**~~
**removed** - replaced by `getDailyStepCountSamples`

Get the total steps per day over a specified date range. 

`getMultiDayStepCounts` accepts an options object containing required *`startDate: ISO8601Timestamp`* and optional *`endDate: ISO8601Timestamp`*. if `endDate` is not provided it will default to the current time
```javascript
let options = {
    startDate: (new Date(2016,5,1)).toISOString()  // required
    endDate:   (new Date()).toISOString()          // optional; default now
};
```
the function will be called with an array of elements `res` containing date and step count information
```javascript
 AppleHealthKit.getMultiDayStepCounts(options: Object, (err: Object, res: Array<Array<string|number>>) => {
    if(this._handleHealthKitError(err, 'getMultiDayStepCounts')){
        return;
    }
    // 'res' is array of [ISOTimestamp: string, stepCount: number] arrays
    // sorted ascending from startDate through endDate
    for(let i=0; i<res.length; ++i){
        let elem = res[i];
        // elem[0] is ISOTimestamp : string
        // elem[1] is step count   : number
    }
});
```

___

#### **`saveSteps`**
Save a step count sample.

A step count sample represents the number of steps during a specific period of time. A sample should be a precise as possible, with startDate and endDate representing the range of time the steps were taken in.

`saveSteps` accepts an options object containing required *`value: number`*, *`startDate: ISO8601Timestamp`*, and *`endDate: ISO8601Timestamp`*.
```javascript
// startDate and endDate are 30 minutes apart. 
// this means the step count value occured within those 30 minutes.
let options = {
	value: 100,
	startDate: (new Date(2016,6,2,6,0,0)).toISOString(),
	endDate: (new Date(2016,6,2,6,30,0)).toISOString()
};
```

```javascript
AppleHealthKit.saveSteps(options, (err, res) => {
	if(this._handleHKError(err, 'saveSteps')){
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
	unit: 'mile',									// optional; default 'meter'
    date: (new Date(2016,5,1)).toISOString(),  		// optional; default now
};
```

```javascript
AppleHealthKit.getDistanceWalkingRunning(options: Object, (err: Object, distance: number) => {
    if(this._handleHKError(err, 'getDistanceWalkingRunning')){
    	return;
    }
	// use distance ...
});
```

___

#### **`getDistanceCycling`**
Get the total distance cycling on a specific day. 

`getDistanceCycling` accepts an options object containing optional *`date: ISO8601Timestamp`* and *`unit: string`*. If `date` is not provided it will default to the current time. `unit` defaults to `meter`
```javascript
let options = {
	unit: 'meter',									// optional; default 'meter'
    date: (new Date(2016,5,1)).toISOString(),  		// optional; default now
};
```

```javascript
AppleHealthKit.getDistanceCycling(options: Object, (err: Object, distance: number) => {
    if(this._handleHKError(err, 'getDistanceCycling')){
    	return;
    }
	// use distance ...
});
```

___

#### **`getFlightsClimbed`**
get the total flights climbed (1 flight is ~10ft of elevation) on a specific day. 

`getFlightsClimbed` accepts an options object containing optional *`date: ISO8601Timestamp`*. if `date` is not provided it will default to the current time.
```javascript
let options = {
    date: (new Date(2016,5,1)).toISOString(),  		// optional; default now
};
```

```javascript
AppleHealthKit.getFlightsClimbed(options: Object, (err: Object, flights: number) => {
    if(this._handleHKError(err, 'getFlightsClimbed')){
    	return;
    }
	// use flights ...
});
```

___

#### **`getLatestWeight`**
Get the most recent weight sample.

On success, the callback function will be provided with a `weight` object containing the weight `value`, and the `startDate` and `endDate` of the weight sample. *Note: startDate and endDate will be the same as weight samples are saved at a specific point in time.*
```javascript
{
	value: 200,
	startDate: '2016-07-08T12:00:00.000-0400', 
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

```javascript
AppleHealthKit.getLatestWeight(null, (err: string, weight: Object) => {
    if(err){
        console.log("error getting latest weight: ", err);
        return;
    }
    // use weight.value, weight.startDate, etc ...
});
```

___

#### **`getWeightSamples`**
query for weight samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
    unit: 'pound',										// optional; default 'pound'
    startDate: (new Date(2016,4,27)).toISOString(),		// required
	endDate: (new Date()).toISOString(),				// optional; default now
    ascending: false,									// optional; default false
    limit:10,											// optional; default no limit
};
```

```javascript
AppleHealthKit.getWeightSamples(options, (err: Object, samples: Array<Object>) => {
	if(this._handleHealthKitError(err, 'getWeightSamples')){
		return;
	}
	// use samples ...
});
```

___

#### **`saveWeight`**
save a numeric weight value to HealthKit

`saveWeight` accepts an options object containing a numeric weight value:
```javascript
let options = {value: 200}
```
```javascript
AppleHealthKit.saveWeight(options: Object, (err: Object, res: Object) => {
    if(err){
        console.log("error saving weight to healthkit: ", err);
        return;
    }
    // weight successfully saved
});
```

___

#### **`getLatestHeight`**
Get the most recent height value.

On success, the callback function will be provided with a `height` object containing the height `value`, and the `startDate` and `endDate` of the height sample. *Note: startDate and endDate will be the same as height samples are saved at a specific point in time.*
```javascript
{
	value: 72,
	startDate: '2016-07-08T12:00:00.000-0400', 
	endDate: '2016-07-08T12:00:00.000-0400'
}
```


```javascript
AppleHealthKit.getLatestHeight(null, (err: string, height: Object) => {
    if(err){
        console.log("error getting latest height: ", err);
        return;
    }
    // use height.value, height.startDate, etc ...
});
```

___

#### **`getHeightSamples`**
query for height samples. the options object is used to setup a query to retrieve relevant samples.
```javascript
let options = {
    unit: 'inch',										// optional; default 'inch'
    startDate: (new Date(2016,4,27)).toISOString(),		// required
	endDate: (new Date()).toISOString(),				// optional; default now
    ascending: false,									// optional; default false
    limit:10,											// optional; default no limit
};
```

the callback function will be called with a `samples` array containing objects with *value*, *startDate*, and *endDate* fields
```javascript
// samples is array of objects
[
	{value: 74.02, startDate:'2016-06-29T17:55:00.000-0400', endDate:'2016-06-29T17:55:00.000-0400'},
	{value: 74, startDate:'2016-03-12T13:22:00.000-0400', endDate:'2016-03-12T13:22:00.000-0400'},
	...
]
```
*example usage*
```javascript
AppleHealthKit.getHeightSamples(options, (err: Object, samples: Array<Object>) => {
	if(this._handleHealthKitError(err, 'getHeightSamples')){
		return;
	}
	// use samples ...
});
```

___

#### **`saveHeight`**
save a numeric height value to HealthKit

`saveHeight` accepts an options object containing a numeric height value:
```javascript
let options = {value: 200}
```
```javascript
AppleHealthKit.saveHeight(options: Object, (err: Object, res: Object) => {
    if(this._handleHealthKitError(err, 'saveHeight')){
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
{
	value: 27.2,
	startDate: '2016-07-08T12:00:00.000-0400', 
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

```javascript
AppleHealthKit.getLatestBmi(null, (err: string, bmi: Object) => {
    if(err){
        console.log("error getting latest bmi data: ", err);
        return;
    }
    let d = bmi.startDate
    let val = bmi.value;
    // ...
});
```

___

#### **`saveBmi`**
save a numeric BMI value to HealthKit

`saveBmi` accepts an options object containing a numeric BMI value:
```javascript
let options = {value: 27.2}
```
```javascript
AppleHealthKit.saveBmi(options: Object, (err: Object, res: Object) => {
    if(this._handleHealthKitError(err, 'saveBmi')){
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
{
	value: 20,
	startDate: '2016-07-08T12:00:00.000-0400', 
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

```javascript
AppleHealthKit.getLatestBodyFatPercentage(null, (err: Object, bodyFatPercentage: Object) => {
    if(this._handleHealthKitError(err, 'getLatestBodyFatPercentage')){
        return;
    }
    // use bodyFatPercentage.value, bodyFatPercentage.startDate, etc ...
});
```

___

#### **`getLatestLeanBodyMass`**
Get the most recent lean body mass. The value is a number representing the weight in pounds (lbs)

On success, the callback function will be provided with a `leanBodyMass` object containing the leanBodyMass `value`, and the `startDate` and `endDate` of the sample. *Note: startDate and endDate will be the same as leanBodyMass samples are saved at a specific point in time.*
```javascript
{
	value: 176,
	startDate: '2016-07-08T12:00:00.000-0400', 
	endDate: '2016-07-08T12:00:00.000-0400'
}
```

```javascript
 AppleHealthKit.getLatestLeanBodyMass(null, (err: Object, leanBodyMass: Object) => {
    if(this._handleHealthKitError(err, 'getLatestLeanBodyMass')){
        return;
    }
    // use leanBodyMass.value, leanBodyMass.startDate, etc ...
});
```

## Examples

#### StepsDemo

![alt text](https://raw.githubusercontent.com/GregWilson/react-native-apple-healthkit/master/examples/images/steps_demo_screen.png "Steps Demo App Screenshot")

#### BodyMeasurements

![alt text](https://raw.githubusercontent.com/GregWilson/react-native-apple-healthkit/master/examples/images/body_measurements_demo_screen.png "Body Measurements Demo App Screenshot")


[Apple HealthKit]: https://developer.apple.com/healthkit/
[react-native-apple-healthkit]: https://www.npmjs.com/package/react-native-apple-healthkit
