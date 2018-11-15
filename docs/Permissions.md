These permissions are exported as constants of the `rn-apple-healthkit` module.

```javascript
import AppleHealthKit from 'rn-apple-healthkit';

// get the available permissions from AppleHealthKit.Constants object
const PERMS = AppleHealthKit.Constants.Permissions;

// setup healthkit read/write permissions using PERMS
const healthKitOptions = {
    permissions: {
        read:  [
            PERMS.StepCount,
            PERMS.Height,
        ],
        write: [
            PERMS.StepCount
        ],
    }
};
```