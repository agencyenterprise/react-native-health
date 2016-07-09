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
      * [Read](#read-permissions)
      * [Write](#write-permissions)
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

AppleHealthKit.getLatestWeight(null, (err: Object, weight: number) => {
    if(err){
        console.log("error getting current weight: ", err);
        return;
    }
    // use weight ...
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

##### Read Permissions

| Permission        | HealthKit Identifier Type                     |
|-------------------|-----------------------------------------------|
| Height            | HKQuantityTypeIdentifierHeight                |
| Weight            | HKQuantityTypeIdentifierBodyMass              |
| BodyFatPercentage | HKQuantityTypeIdentifierBodyFatPercentage     |
| BodyMassIndex     | HKQuantityTypeIdentifierBodyMassIndex         |
| LeanBodyMass      | HKQuantityTypeIdentifierLeanBodyMass          |
| Steps             | HKQuantityTypeIdentifierStepCount             |
| BiologicalSex     | HKCharacteristicTypeIdentifierBiologicalSex   |
| DateOfBirth       | HKCharacteristicTypeIdentifierDateOfBirth     |
| DietaryEnergy     | HKQuantityTypeIdentifierDietaryEnergyConsumed |
| ActiveEnergy      | HKQuantityTypeIdentifierActiveEnergyBurned    |

##### Write Permissions

| Permission        | HealthKit Identifier Type                     |
|-------------------|-----------------------------------------------|
| Height            | HKQuantityTypeIdentifierHeight                |
| Weight            | HKQuantityTypeIdentifierBodyMass              |
| BodyFatPercentage | HKQuantityTypeIdentifierBodyFatPercentage     |
| BodyMassIndex     | HKQuantityTypeIdentifierBodyMassIndex         |
| LeanBodyMass      | HKQuantityTypeIdentifierLeanBodyMass          |
| Steps             | HKQuantityTypeIdentifierStepCount             |
| DietaryEnergy     | HKQuantityTypeIdentifierDietaryEnergyConsumed |
| ActiveEnergy      | HKQuantityTypeIdentifierActiveEnergyBurned    |
        

Options
-------


Methods
-------

#### **`isAvailable`** 
check if HealthKit is available on the device
```javascript
AppleHealthKit.isAvailable((err: Object, available: boolean) => {
    if(available){
        // ...
    }
});
```
___

#### **`initHealthKit`** 
initialize HealthKit. this will show the HealthKit permissions prompt for any read/write permissions set in the required `options` object. 

due to Apple's privacy model if an app user has previously denied a specific permission then they can not be prompted again for that same permission. the app user would have to go into the Apple Health app and grant the permission to your react-native app under *sources* tab. 

for any data that is read from HealthKit the status/error is the same for both. this privacy restriction results in having no knowledge of whether the permission was denied (make sure it's added to the permissions options object), or the data for the specific request was nil (ex. no steps recorded today)

for any data written to HealthKit an authorization error can be caught. if an authorization error occurs you can prompt the user to set the specific permission or add the permission to the options object if not present

if new read/write permissions are added to the options object then the app user will see the HealthKit permissions prompt with the new permissions to allow

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
get the biological sex (gender). if the `BiologicalSex` read permission is missing or the user has denied it then the value will be `unknown`. the possible values are:

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
get the date of birth. this will be an ISO timestamp

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
get the aggregated total steps for a specific day (starting and ending at midnight). 

an optional options object may be provided containing `date` field representing the selected day. If `date` is not set or an options object is not provided then the current day will be used. 
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
get the total steps per day over a specified date range. 

`getDailyStepCountSamples` accepts an options object containing required *`startDate: ISO8601Timestamp`* and optional *`endDate: ISO8601Timestamp`*. if `endDate` is not provided it will default to the current time
```javascript
let options = {
    startDate: (new Date(2016,5,1)).toISOString()  // required
    endDate:   (new Date()).toISOString()          // optional; default now
};
```
the function will be called with an array of elements. each element is an object containing `value`, `startDate`, and `endDate` fields:
```javascript
[ 
  { value: 8, startDate: '2016-07-09T00:00:00.000-0400', endDate: '2016-07-10T00:00:00.000-0400' },
  { value: 1923, startDate: '2016-07-08T00:00:00.000-0400', endDate: '2016-07-09T00:00:00.000-0400' },
  { value: 1802, startDate: '2016-07-07T00:00:00.000-0400', endDate: '2016-07-08T00:00:00.000-0400' },
  ...
]
```


```javascript
 AppleHealthKit.getDailyStepCountSamples(options: Object, (err: Object, res: Array<Array<Object>) => {
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

get the total steps per day over a specified date range. 

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

#### **`getDistanceWalkingRunning`**
get the total distance walking/running on a specific day. 

`getDistanceWalkingRunning` accepts an options object containing optional *`date: ISO8601Timestamp`* and *`unit: string`*. if `date` is not provided it will default to the current time. `unit` defaults to `meter`
```javascript
let options = {
	unit: 'mile',									// optional; default 'meter'
    date: (new Date(2016,5,1)).toISOString(),  		// optional; default now
};
```

```javascript
AppleHealthKit.getDistanceWalkingRunning(null, (err, distance) => {
    if(this._handleHKError(err, 'getDistanceWalkingRunning')){
    	return;
    }
	// use distance ...
});
```

___

#### **`getDistanceCycling`**
get the total distance cycling on a specific day. 

`getDistanceCycling` accepts an options object containing optional *`date: ISO8601Timestamp`* and *`unit: string`*. if `date` is not provided it will default to the current time. `unit` defaults to `meter`
```javascript
let options = {
	unit: 'meter',									// optional; default 'meter'
    date: (new Date(2016,5,1)).toISOString(),  		// optional; default now
};
```

```javascript
AppleHealthKit.getDistanceCycling(null, (err, distance) => {
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
AppleHealthKit.getFlightsClimbed(null, (err, flights) => {
    if(this._handleHKError(err, 'getFlightsClimbed')){
    	return;
    }
	// use flights ...
});
```

___

#### **`getLatestWeight`**
get the most recent weight value
```javascript
AppleHealthKit.getLatestWeight(null, (err: string, weight: number) => {
    if(err){
        console.log("error getting latest weight: ", err);
        return;
    }
    // use weight ...
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
get the most recent height value
```javascript
AppleHealthKit.getLatestHeight(null, (err: string, height: number) => {
    if(err){
        console.log("error getting latest height: ", err);
        return;
    }
    // use height ...
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
get the most recent BMI data. the handler function will be called with a `bmi` object containing *`value: number`*, *`startDate: ISO8601Timestamp`*, and *`endDate: ISO8601Timestamp`*. The BMI value may be very old so the sample dates are provided as well. *should apply this to all other RCT types* 
```javascript
AppleHealthKit.getLatestBmi(null, (err: string, bmi: Object) => {
    if(err){
        console.log("error getting latest bmi data: ", err);
        return;
    }
    if(bmi && bmi.value){
        let d = bmi.startDate
        let val = bmi.value;
        // ...
    }
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
get the most recent body fat percentage. the percentage value is a number between 0 and 100
```javascript
AppleHealthKit.getLatestBodyFatPercentage(null, (err: Object, bodyFatPercentage: number) => {
    if(this._handleHealthKitError(err, 'getLatestBodyFatPercentage')){
        return;
    }
    // use bodyFatPercentage ...
});
```

___

#### **`getLatestLeanBodyMass`**
get the most recent lean body mass. the value is a number representing the weight in pounds (lbs)
```javascript
 AppleHealthKit.getLatestLeanBodyMass(null, (err: Object, leanBodyMass: number) => {
    if(this._handleHealthKitError(err, 'getLatestLeanBodyMass')){
        return;
    }
    // use leanBodyMass ...
});
```

## Examples

#### StepsDemo

![alt text](https://raw.githubusercontent.com/GregWilson/react-native-apple-healthkit/master/examples/images/steps_demo_screenshot.png "Steps Demo App Screenshot")

#### BodyMeasurements

![alt text](https://raw.githubusercontent.com/GregWilson/react-native-apple-healthkit/master/examples/images/body_measurements_demo_screenshot.png "Body Measurements Demo App Screenshot")


[Apple HealthKit]: https://developer.apple.com/healthkit/
[react-native-apple-healthkit]: https://www.npmjs.com/package/react-native-apple-healthkit
