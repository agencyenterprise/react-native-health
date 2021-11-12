# Background Observers

An observer is responsible by constantly listen to Apple HealthKit updates in the
background and notify your app in case any new data sample was added. The
background notification is handled by iOS and the following steps show how to
detect these changes using the react-native-health library.

Currently, the supported data identifiers that can be observed are the
following:

- `ActiveEnergyBurned`
- `BasalEnergyBurned`
- `Cycling`
- `HeartRate`
- `HeartRateVariabilitySDNN`
- `RestingHeartRate`
- `Running`
- `StairClimbing`
- `StepCount`
- `Swimming`
- `Vo2Max`
- `Walking`
- `Workout`

### Initialization

If you followed the [Background Processing](https://github.com/agencyenterprise/react-native-health#background-processing)
step in the README, you can skip this one.

To setup that in your project, in XCode open your `ios/AppDelegate.m` file and add the
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

After that, your app is ready to start listening for data updates using the
React Native client.

### Handling the updates

This library send events to your app through the React Native bridge. To
intercept those, you should use the `NativeAppEventEmitter`.

They follow events are triggered by the library

| Event                                     | When is triggered?                                                              |
| ----------------------------------------- | ------------------------------------------------------------------------------- |
| `healthKit:<OBSERVER_TYPE>:setup:success` | When the background observer for that type is successfuly setup                 |
| `healthKit:<OBSERVER_TYPE>:setup:failure` | When the background observer for that type is not successfuly setup             |
| `healthKit:<OBSERVER_TYPE>:new`           | When the background observer received a new data sample for that type           |
| `healthKit:<OBSERVER_TYPE>:failure`       | When the background observer received a new data sample, but an error was found |

Note that the `<OBSERVER_TYPE>` token should be replaced with one of
the available types presented in the first section. As an example, if setting
up observers for workouts, the events would have the following names:

- `healthKit:Workout:setup:success`
- `healthKit:Workout:setup:failure`
- `healthKit:Workout:new`
- `healthKit:Workout:failure`

### Example

```typescript
import { NativeAppEventEmitter } from 'react-native'

const callback = (): void => {
  /* Execute any data query */
}

/* Register native listener that will be triggered when successfuly enabled */
NativeAppEventEmitter.addListener('healthKit:HeartRate:setup:success', callback)

/* Register native listener that will be triggered on each update */
NativeAppEventEmitter.addListener('healthKit:HeartRate:new', callback)
```

When a new sample appears, in order to get the information you need to call
the [getSamples](./getSamples.md) or the [getClinicalRecords](./getClinicalRecords.md) method from your callback function.

**Note** - Some HealthKit data types have a minimum update frequency of an
hour. Even setting up an observer, it might take some moment until your
app is notified by the HealthKit

### More Information

- [Executing Observer Queries](https://developer.apple.com/documentation/healthkit/hkobserverquery/executing_observer_queries)
- [Background Delivery](https://stackoverflow.com/questions/26375767/healthkit-background-delivery-when-app-is-not-running)
- [enableBackgroundDeliveryForType](https://developer.apple.com/documentation/healthkit/hkhealthstore/1614175-enablebackgrounddeliveryfortype?language=objc)
