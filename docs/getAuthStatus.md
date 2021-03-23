# getAuthStatus

Check the authorization status for sharing (writing) the specified data type.

Status will be a HealthStatusResult[]. From index.d.ts:

```typescript
export enum HealthStatusCode {
  NotDetermined = 0,
  SharingDenied = 1,
  SharingAuthorized = 2,
}

export interface HealthStatusResult {
  permissions: {
    read: HealthStatusCode[]
    write: HealthStatusCode[]
  }
}
```

Example:

```typescript
const permissions = {
  permissions: {
    read: [AppleHealthKit.Constants.Permissions.StepCount],
    write: [AppleHealthKit.Constants.Permissions.StepCount],
  },
} as HealthKitPermissions

AppleHealthKit.getAuthStatus(permissions, (err, results) => {
  console.log(err, results)
})
```

There is no way to check authorization status for read permission. The read array will always return an array of HealthStatusCode.SharingAuthorized. [see this](https://developer.apple.com/documentation/healthkit/hkhealthstore/1614154-authorizationstatusfortype?language=objc).
