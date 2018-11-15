Setup an HKObserverQuery for step count (HKQuantityTypeIdentifierStepCount) that will
trigger an event listenable on react-native `NativeAppEventEmitter` when the
Healthkit step count has changed.

The `initStepCountObserver` method must be called before adding a listener to
NativeAppEventEmitter. After the step count observer has been initialized you can
listen to the NativeAppEventEmitter `change:steps` event and re-fetch relevent
step count data in the event handler.

The `initStepCountObserver` method should be called after Healthkit has been
successfully initialized (AppleHealthKit.initHealthKit has been called without
error).

```javascript
// import NativeAppEventEmitter from react-native
import {
  Navigator,
  View,
  NativeAppEventEmitter,
} from 'react-native';
```

```javascript
AppleHealthKit.initHealthKit(HKOPTIONS, (err, res) => {
  if (this._handleHKError(err, 'initHealthKit')) {
    return;
  }

  // initialize the step count observer
  AppleHealthKit.initStepCountObserver({}, () => {});

  // add event listener for 'change:steps' and handle the
  // event in the event handler function.
  //
  // when adding a listener, a 'subscription' object is
  // returned that must be used to remove the listener
  // when the component unmounts. The subscription object
  // must be accessible to any function/method/instance
  // that will be unsubscribing from the event.
  this.sub = NativeAppEventEmitter.addListener(
    'change:steps',
    (evt) => {
      // a 'change:steps' event has been received. step
      // count data should be re-fetched from Healthkit.
      this._fetchStepCountData();
    }
  );

  // other tasks to perform after Healthkit has been
  // initialized (fetch relevant Healthkit data).
  this._fetchStepCountData();
  this._fetchOtherRelevantHealthkitData();
  // ...
});

...

// when the component where the listener was added unmounts
// (or whenever the listener should be removed), call the
// 'remove' method of the subscription object.
componentWillUnmount() {
  this.sub.remove();
}
```
