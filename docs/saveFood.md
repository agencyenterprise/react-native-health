# saveFood.md

Add food consumed to Healthkit

`saveFood` accepts an options object containing name, type, date and other data about the food.

Example input options:

```javascript
let options = {
    foodName: "Burrito"
    mealType: "Lunch" // Breakfast, Lunch, Dinner, or Snacks
    date: (new Date(2018,10,1)).toISOString(), // Optional, time when the food was consumed
    biotin: 0.1 // Optional
    caffeine : 0.1 //Optional
    calcium : 0.1 // Optional
    carbohydrates : 0.1 // Optional
    chloride : 0.1 // Optional
    cholesterol : 0.1 // Optional
    copper : 0.1 // Optional
    energy : 0.1 // Optional
    fatMonounsaturated : 0.1 // Optional
    fatPolyunsaturated : 0.1 // Optional
    fatSaturated : 0.1 // Optional
    fatTotal : 0.1 // Optional
    fiber : 0.1 // Optional
    folate : 0.1 // Optional
    iodine : 0.1 // Optional
    iron : 0.1 // Optional
    magnesium : 0.1 // Optional
    manganese : 0.1 // Optional
    molybdenum : 0.1 // Optional
    niacin : 0.1 // Optional
    pantothenicAcid : 0.1 // Optional
    phosphorus : 0.1 // Optional
    potassium : 0.1 // Optional
    protein : 0.1 // Optional
    riboflavin : 0.1 // Optional
    selenium : 0.1 // Optional
    sodium : 0.1 // Optional
    sugar : 0.1 // Optional
    thiamin : 0.1 // Optional
    vitaminA : 0.1 // Optional
    vitaminB12 : 0.1 // Optional
    vitaminB6 : 0.1 // Optional
    vitaminC : 0.1 // Optional
    vitaminD : 0.1 // Optional
    vitaminE : 0.1 // Optional
    vitaminK : 0.1 // Optional
    zinc : 0.1 // Optional
}
```

Call the method:

```javascript
AppleHealthKit.saveFood((options: Object), (err: Object, results: number) => {
  if (err) {
    console.log('Error saving food to Healthkit: ', err)
    return
  }
  // food saved successfully
})
```

Example output:

```json
16.7
```
