# getFood.md

Get food consumed that was logged to Healthkit

`getFood` accepts an options object containing startDate and endDate

Example input options:

```javascript
let options = {
    startDate: (new Date(2018,10,1)).toISOString(), // start time when the food was consumed
    endDate: (new Date(2018,10,1)).toISOString(), // Optional, end time when the food was consumed
}
```

Call the method:

```javascript
AppleHealthKit.getFood((options: Object), (err: Object, results: FoodResult[]) => {
  if (err) {
    console.log('Error retrieving food from Healthkit: ', err)
    return
  }
  console.log(results) // food result consumed between given dates
})
```

Example output:

```json
[
  {
    "endDate": "2022-11-07T10:46:39.850-0800",
    "id": "FE045AA2-EAF7-45BD-A2C0-66B96B1B9A5B",
    "metadata": {
      "HKFoodMeal": "Lunch",
      "HKFoodType": "(16 Pack) Abbottsford Hard Cooked Eggs Peeled Individually Wrapped, 3 oz. Each"
    },
    "nutrients": {
      "energy": 140
    },
    "sourceId": "com.coding.casa.Strong.Foundation",
    "sourceName": "Strong Foundation",
    "startDate": "2022-11-07T10:46:39.850-0800"
  },
  {
    "endDate": "2022-11-07T18:05:24.316-0800",
    "id": "D1071D68-E991-483A-81D1-2A043649BA35",
    "metadata": {
      "HKFoodMeal": "Lunch",
      "HKFoodType": "2 Ingredient Healthy Brownies (No Flour, Butter, Eggs or Refined Sugar)"
    },
    "nutrients": {
      "energy": 118.69
    },
    "sourceId": "com.coding.casa.Strong.Foundation",
    "sourceName": "Strong Foundation",
    "startDate": "2022-11-07T18:05:24.316-0800"
  }
]
```
