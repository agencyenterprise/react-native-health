# initHealthKit

Initialize Healthkit. This will show the Healthkit permissions prompt for any read/write permissions set in the required `options` object.

Due to Apple's privacy model if an app user has previously denied a specific permission then they can not be prompted again for that same permission. The app user would have to go into the Apple Health app and grant the permission to your react-native app under _sources_ tab.

For any data that is read from Healthkit the status/error is the same for both. This privacy restriction results in having no knowledge of whether the permission was denied (make sure it's added to the permissions options object), or the data for the specific request was nil (ex. no steps recorded today).

For any data written to Healthkit an authorization error can be caught. If an authorization error occurs you can prompt the user to set the specific permission or add the permission to the options object if not present.

If new read/write permissions are added to the options object then the app user will see the Healthkit permissions prompt with the new permissions to allow.

`initHealthKit` requires an options object with Healthkit permission settings

Example input options:

```javascript
let options = {
  permissions: {
    read: ['Height', 'Weight', 'StepCount', 'DateOfBirth', 'BodyMassIndex'],
    write: ['Weight', 'StepCount', 'BodyMassIndex'],
  },
}
```

Call the method:

```javascript
AppleHealthKit.initHealthKit(
  (options: HealthInputOptions),
  (err: string, results: boolean) => {
    if (err) {
      console.log('error initializing Healthkit: ', err)
      return
    }
    // Healthkit is initialized...
    // now safe to read and write Healthkit data...
  },
)
```

Example output:

```json
1
```
