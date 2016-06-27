# react-native-apple-healthkit
A React Native bridge module for interacting with Apple HealthKit data. 

## Getting started

###  Installation (xcode)

1. `npm install react-native-apple-healthkit@https://github.com/GregWilson/react-native-apple-healthkit.git --save`
2. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
3. Go to `node_modules` ➜ `react-native-apple-healthkit` and add `RCTAppleHealthKit.xcodeproj`
4. In XCode, in the project navigator, select your project. Add `libRCTAppleHealthKit.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
5. Click `RCTAppleHealthKit.xcodeproj` in the project navigator and go the `Build Settings` tab. Make sure 'All' is toggled on (instead of 'Basic'). In the `Search Paths` section, look for `Header Search Paths` and make sure it contains both `$(SRCROOT)/../../react-native/React` and `$(SRCROOT)/../../../React` - mark both as `recursive`.
5. Run your project (`Cmd+R`)

