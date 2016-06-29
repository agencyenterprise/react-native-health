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
      * [getStepCountForToday](#getstepcountfortoday)
      * [getStepCountForDay](#getstepcountforday)
      * [getMultiDayStepCounts](#getmultidaystepcounts)
      * [getLatestWeight](#getlatestweight)
      * [saveWeight](#saveweight)
      * [getLatestHeight](#getlatestheight)
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

#### **`getStepCountForToday`**
get the the aggregated total steps for the current day starting and ending at midnight
```javascript
AppleHealthKit.getStepCountForToday(null, (err: Object, steps: number) => {
    if(this._handleHealthKitError(err, 'getStepCountForToday')){
        return;
    }
    // use steps...
});
```

___

#### **`getStepCountForDay`**
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

#### **`getMultiDayStepCounts`**
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

![alt text](https://raw.githubusercontent.com/GregWilson/react-native-apple-healthkit/master/examples/images/IMG_0205.PNG "Example App Screenshot")


[Apple HealthKit]: https://developer.apple.com/healthkit/
[react-native-apple-healthkit]: https://www.npmjs.com/package/react-native-apple-healthkit
