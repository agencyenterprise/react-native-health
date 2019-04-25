Will listen for any updates in a given type data in healthKit and call app.

type - one of the `['Walking', 'StairClimbing', 'Running', 'Cycling', 'Workout']`
```javascript 1.8
import { NativeAppEventEmitter } from 'react-native';
//...//
AppleHealthKit.setObserver({ type: 'Walking' });
NativeAppEventEmitter.addListener(
      'observer',
      callback
    );
```

So, callback would be call when new data of given type appears. When it happens, in order to get new info
need to call getSamples() function with proper arguments. 
