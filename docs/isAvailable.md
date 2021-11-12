# isAvailable

Check for Healthkit availability

```javascript
import AppleHealthKit from 'react-native-health'

AppleHealthKit.isAvailable((err: Object, available: boolean) => {
  if (err) {
    console.log('error initializing Healthkit: ', err)
    return
  }
})
```

Example output:

```
true
```
