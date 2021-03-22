# Installation

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

3. Update the `info.plist` file in your project

```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
```

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
