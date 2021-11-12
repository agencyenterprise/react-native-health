> DEPRECATED - This method has been depreacted in favor of background initializers
> and will be removed in the next major release. See the [background](background.md)
> page for more information.

# Set Observer

An observer is responsible by listen to HealthKit updates and notify your app
in case any new data was added. The background notification is handled
by iOS and the following tutorial shows how to detect these changes using
react-native-health library.

Currently, the supported data identifiers that can be observed are the
following

- `Cycling`
- `HeartRate`
- `RestingHeartRate`
- `Running`
- `StairClimbing`
- `Walking`
- `Workout`

### Observer Types

This package triggers two types of events in your app, one when the observer
is successfuly setup and another for each new sample that is added to HealthKit.

They follow the patterns bellow

```
"healthKit:<OBSERVER_TYPE>:enabled"
"healthKit:<OBSERVER_TYPE>:sample"
```

### Example

```javascript
import { NativeAppEventEmitter } from 'react-native'

const callback = () => {}

/* Communicate to HealthKit the data types to be notified */
AppleHealthKit.setObserver({ type: 'HeartRate' })

/* Register native listener that will be triggered on each update */
NativeAppEventEmitter.addListener('healthKit:HeartRate:sample', callback)

/* Register native listener that will be triggered when successfuly enabled */
NativeAppEventEmitter.addListener('healthKit:HeartRate:enabled', callback)
```

When a new sample appears, in order to get the information you need to call
the [getSamples](<'./getSamples().md'>) function from your callback.

**Note** - Some data types, such as step counts, have a minimum frequency
of HKUpdateFrequencyHourly. This frequency is enforced transparently.

> DEPRECATED - This method has been depreacted in favor of background initializers
> and will be removed in the next major release. See the [background](background.md)
> page for more information.
