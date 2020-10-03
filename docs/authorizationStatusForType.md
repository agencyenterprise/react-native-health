Check the authorization status for sharing (writing) the specified data type.

Status will be one of `"NotDetermined"`, `"SharingDenied"`, `"SharingAuthorized"`.

```javascript
try {
const status = await AppleHealthKit.authorizationStatusForType("StepCount")
if (status) {
  console.log("status is", status)
}
} catch (error) {
  console.warn(error)
}
```

There is no way to check authorization status for read permission, [see this](https://developer.apple.com/documentation/healthkit/hkhealthstore/1614154-authorizationstatusfortype?language=objc).
