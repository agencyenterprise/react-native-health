# react-native-apple-healthkit
A React Native bridge module for interacting with [Apple HealthKit] data. 

![Alt text](https://devimages.apple.com.edgekey.net/assets/elements/icons/healthkit/healthkit-64x64.png "Apple HealthKit")

#### Table of Contents
  * [Getting Started](#getting-started)
    * [Installation](#installation-xcode)
    * [Usage](#usage)
  * [Documentation](#documentation)
    * [Permissions](#permissions)
    * [Methods](#methods)
      * [isAvailable](#isavailable)
      * [initHealthKit](#inithealthkit)
      * [getStepCountForToday](#getstepcountfortoday)
      * [getLatestWeight](#getlatestweight)
      * [saveWeight](#saveweight)
      * [getLatestHeight](#getlatestheight)
      * [saveHeight](#saveheight)
      * [getLatestBmi](#getlatestbmi)
      * [getLatestBodyFatPercentage](#getlatestbodyfatpercentage)
      * [getLatestLeanBodyMass](#getlatestleanbodymass)
  * [Examples](#examples)
  

## Getting started

###  Installation

Install the package from npm:

`npm install react-native-apple-healthkit --save`

##### Xcode
  
1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-apple-healthkit` and add `RCTAppleHealthKit.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthKit.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Click `RCTAppleHealthKit.xcodeproj` in the project navigator and go the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic'). In the `Search Paths` section, look for `Header Search Paths` and make sure it contains both `$(SRCROOT)/../../react-native/React` and `$(SRCROOT)/../../../React` - mark both as `recursive`.
5. Compile and run

### Usage

Just `require` the `react-native-apple-healthkit` module and you're ready to go!
```javascript
var AppleHealthKit = require('react-native-apple-healthkit');

...

let healthKitOptions = {
    permissions: {
        read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "Steps", "BodyMassIndex"]
    }
};

AppleHealthKit.initHealthKit(healthKitOptions, (err, res) => {
    if(err) {
        console.log("error initializing healthkit: ", err);
        return;
    }
    console.log("HEALTHKIT INITIALIZED!");
    // ...
});


```

When the module has been successfully initialized you can read and write HealthKit data

```javascript
var AppleHealthKit = require('react-native-apple-healthkit');
var _ = require('lodash');

...

AppleHealthKit.getLatestWeight(null, (err, weight) => {
    if(err){
        console.log("error getting current weight: ", err);
        return;
    }
    weight = _.round(weight,1);
    // do something with the weight...
});

...

let myWeight = 200;
AppleHealthKit.saveWeight({value:myWeight}, (err, res) => {
    if(err){
        console.log("error saving weight to healthkit: ", err);
        return;
    }
    // weight successfully saved
});


```



## Documentation

### Permissions

The available HealthKit permissions to use with `initHealthKit` 

Read Permissions:

    Height               HKQuantityTypeIdentifierHeight
    Weight               HKQuantityTypeIdentifierBodyMass
    BodyFatPercentage    HKQuantityTypeIdentifierBodyFatPercentage
    BodyMassIndex        HKQuantityTypeIdentifierBodyMassIndex
    LeanBodyMass         HKQuantityTypeIdentifierLeanBodyMass
    Steps                HKQuantityTypeIdentifierStepCount
    Sex                  HKCharacteristicTypeIdentifierBiologicalSex
    DateOfBirth          HKCharacteristicTypeIdentifierDateOfBirth
    DietaryEnergy        HKQuantityTypeIdentifierDietaryEnergyConsumed
    ActiveEnergy         HKQuantityTypeIdentifierActiveEnergyBurned
    
Write Permissions:

    Height               HKQuantityTypeIdentifierHeight
    Weight               HKQuantityTypeIdentifierBodyMass
    BodyFatPercentage    HKQuantityTypeIdentifierBodyFatPercentage
    BodyMassIndex        HKQuantityTypeIdentifierBodyMassIndex
    LeanBodyMass         HKQuantityTypeIdentifierLeanBodyMass
    Steps                HKQuantityTypeIdentifierStepCount
    DietaryEnergy        HKQuantityTypeIdentifierDietaryEnergyConsumed
    ActiveEnergy         HKQuantityTypeIdentifierActiveEnergyBurned
        
### Methods

#### **`isAvailable`** 
check if HealthKit is available on the device
```javascript
AppleHealthKit.isAvailable((err: string, available: bool) => {
    if(available){
        // ...
    }
});
```
___

#### **`initHealthKit`** 
initialize HealthKit. this will show the HealthKit permissions prompt for any read/write permissions that have not yet been selected by the user.

`initHealthKit` requires an options object with HealthKit permission settings.
```javascript
let healthKitOptions = {
    permissions: {
        read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "Steps", "BodyMassIndex"]
    }
};
```

```javascript
AppleHealthKit.initHealthKit(healthKitOptions: object, (err: string, res: object) => {
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

#### **`getLatestWeight`**
get the most recent weight value
```javascript
AppleHealthKit.getLatestWeight(null, (err: string, weight: number) => {
    if(err){
        console.log("error getting latest weight: ", err);
        return;
    }
    weight = _.round(weight,1);
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
AppleHealthKit.saveWeight(options, (err, res) => {
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
AppleHealthKit.saveHeight(options, (err, res) => {
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
