# deleteAllMindfulSessions

Delete all mindful sessions from HealthKit.

`deleteAllMindfulSessions` accepts a callback:

Example usage:

```javascript
AppleHealthKit.deleteAllMindfulSessions((err: string, result: number) => {
  if (err) {
    console.log(err)
    return
  }
  // sample successfully deleted
  console.log(result)
})
```

Example output (if 20 objects are deleted):

```json
20
```
