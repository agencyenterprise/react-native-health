Retrieves the move, exercise, and stand data for a given day.

Returns the following:
* **activityMoveModeId**: The ID for the move mode used for this activity summary. This will either be 1 (ActiveEnergy) or 2 (AppleMoveTime).
* **activityMoveMode**: The move mode used for this activity summary. This will be either ActiveEnergy or AppleMoveTime.
* **activeEnergyBurned**: The amount of active energy that the user has burned during the specified day, in kilocalories.
* **activeEnergyBurnedGoal**: The user’s daily goal for active energy burned, in kilocalories.
* **appleMoveTime**: The amount of move time that the user earned during the specified day, in minutes. This will be 0 if the **activityMoveMode** is set to **ActiveEnergy**.
* **appleMoveTimeGoal**: The user’s daily goal for move time, in minutes. This will be 0 if the **activityMoveMode** is set to **ActiveEnergy**.
* **appleExerciseTime**: The amount of time that the user has spent exercising during the specified day, in minutes.
* **appleExerciseTimeGoal**: The user’s daily exercise goal, in minutes.
* **appleStandHours**: The number of stand hours that the user has earned during the specified day.
* **appleStandHoursGoal**: The user’s daily goal for stand hours.
* **date**

```javascript
let options = {
    startDate: (new Date(2016,10,1)).toISOString(), // required
    endDate: (new Date()).toISOString(), // optional; default now
};
```

```javascript
AppleHealthKit.getActiveEnergyBurned(options: Object, (err: Object, results: Object) => {
    if (err) {
        return;
    }
    console.log(results)
});
```