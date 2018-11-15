Check for Healthkit availability

```javascript
import AppleHealthKit from 'rn-apple-healthkit';

AppleHealthKit.isAvailable((err: Object, available: boolean) => {
  if (err) {
    console.log("error initializing Healthkit: ", err);
    return;
  }
  // Healthkit is available
});
```