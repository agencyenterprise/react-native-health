# deleteFood.md

Delete food record consumed that was logged to Healthkit

`deleteFood` accepts an options object containing startDate, endDate, and objectId

Example input options:

```javascript
let options = {
    startDate: (new Date(2018,10,1)).toISOString(), // start time when the food was consumed
    endDate: (new Date(2018,10,1)).toISOString(), // Optional, end time when the food was consumed
    objectId: "{A UUID FOR FOOD RECORD}" // the UUID of the food record to delete
}
```

Call the method:

```javascript
AppleHealthKit.deleteFood((options: Object), (err: Object, success: number) => {
  if (err) {
    console.log('Error deleting food from Healthkit: ', err)
    return
  }
  console.log(success === 1 ? "yay" : "no") // food result consumed between given dates
})
```
