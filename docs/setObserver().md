Adds an observer to HealthKit updates. The background notification is handled
by iOS and your app will be notified by any updates in the given type of
data.

Available types are the following

- `Cycling`
- `HeartRate`
- `RestingHeartRate`
- `Running`
- `StairClimbing`
- `Walking`
- `Workout`

```javascript 1.8
import { NativeAppEventEmitter } from 'react-native';

const callback = () => {}

AppleHealthKit.setObserver({ type: 'Workout' });
NativeAppEventEmitter.addListener('observer', callback);
```

So, callback would be call when new data of given type appears.
When it happens, in order to get new info need to call `getSamples()`
function with proper arguments.
