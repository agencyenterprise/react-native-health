# react-native-apple-healthkit
A React Native bridge module for interacting with [Apple HealthKit] data. 

![Alt text](https://devimages.apple.com.edgekey.net/assets/elements/icons/healthkit/healthkit-64x64.png "Apple HealthKit")
## Getting started

###  Installation (xcode)

1. `npm install react-native-apple-healthkit@https://github.com/GregWilson/react-native-apple-healthkit.git --save`
2. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `react-native-apple-healthkit` and add `RCTAppleHealthKit.xcodeproj`
4. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthKit.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Click `RCTAppleHealthKit.xcodeproj` in the project navigator and go the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic'). In the `Search Paths` section, look for `Header Search Paths` and make sure it contains both `$(SRCROOT)/../../react-native/React` and `$(SRCROOT)/../../../React` - mark both as `recursive`.
5. Compile and have fun

### Usage

Just `require` the `react-native-apple-healthkit` module and you're ready to go!
```javascript
var AppleHealthKit = require('react-native-apple-healthkit');

...

let healthKitOptions = {
    permissions: {
        read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight", "Steps"]
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

AppleHealthKit.getCurrentWeight(null, (err, weight) => {
    if(err){
        console.log("error getting current weight: ", err);
        return;
    }
    weight = _.round(weight,1);
    // do something with the weight...
});

...

let myWeight = 200;
AppleHealthKit.saveWeight({weight:myWeight}, (err, res) => {
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

**`isAvailable`** : check if HealthKit is available on the device
```javascript
AppleHealthKit.isAvailable((err: string, available: bool) => {
    if(available){
        // ...
    }
});
```
___

**`initHealthKit`** : check if HealthKit is available on the device

`initHealthKit` requires an options object with HealthKit permission settings.
```javascript
let healthKitOptions = {
    permissions: {
        read: ["Height", "Weight", "Steps", "DateOfBirth", "BodyMassIndex"],
        write: ["Weight"]
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

**`getCurrentWeight`** : get the most recent weight value
```javascript
AppleHealthKit.getCurrentWeight(null, (err, weight) => {
    if(err){
        console.log("error getting current weight: ", err);
        return;
    }
    weight = _.round(weight,1);
    // ...
});
```


[Apple HealthKit]: https://developer.apple.com/healthkit/
