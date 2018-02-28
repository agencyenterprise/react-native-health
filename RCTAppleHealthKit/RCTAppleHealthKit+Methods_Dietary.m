//
//  RCTAppleHealthKit+Methods_Dietary.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Dietary.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Methods_Dietary)

- (void)saveFood:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSString *foodNameValue = [RCTAppleHealthKit stringFromOptions:input key:@"foodName" withDefault:nil];
    NSString *mealNameValue = [RCTAppleHealthKit stringFromOptions:input key:@"mealType" withDefault:nil];
    NSDate *timeFoodWasConsumed = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];
    double biotinValue = [RCTAppleHealthKit doubleFromOptions:input key:@"biotin" withDefault:(double)0];
    double caffeineValue = [RCTAppleHealthKit doubleFromOptions:input key:@"caffeine" withDefault:(double)0];
    double calciumValue = [RCTAppleHealthKit doubleFromOptions:input key:@"calcium" withDefault:(double)0];
    double carbohydratesValue = [RCTAppleHealthKit doubleFromOptions:input key:@"carbohydrates" withDefault:(double)0];
    double chlorideValue = [RCTAppleHealthKit doubleFromOptions:input key:@"chloride" withDefault:(double)0];
    double cholesterolValue = [RCTAppleHealthKit doubleFromOptions:input key:@"cholesterol" withDefault:(double)0];
    double copperValue = [RCTAppleHealthKit doubleFromOptions:input key:@"copper" withDefault:(double)0];
    double energyConsumedValue = [RCTAppleHealthKit doubleFromOptions:input key:@"energy" withDefault:(double)0];
    double fatMonounsaturatedValue = [RCTAppleHealthKit doubleFromOptions:input key:@"fatMonounsaturated" withDefault:(double)0];
    double fatPolyunsaturatedValue = [RCTAppleHealthKit doubleFromOptions:input key:@"fatPolyunsaturated" withDefault:(double)0];
    double fatSaturatedValue = [RCTAppleHealthKit doubleFromOptions:input key:@"fatSaturated" withDefault:(double)0];
    double fatTotalValue = [RCTAppleHealthKit doubleFromOptions:input key:@"fatTotal" withDefault:(double)0];
    double fiberValue = [RCTAppleHealthKit doubleFromOptions:input key:@"fiber" withDefault:(double)0];
    double folateValue = [RCTAppleHealthKit doubleFromOptions:input key:@"folate" withDefault:(double)0];
    double iodineValue = [RCTAppleHealthKit doubleFromOptions:input key:@"iodine" withDefault:(double)0];
    double ironValue = [RCTAppleHealthKit doubleFromOptions:input key:@"iron" withDefault:(double)0];
    double magnesiumValue = [RCTAppleHealthKit doubleFromOptions:input key:@"magnesium" withDefault:(double)0];
    double manganeseValue = [RCTAppleHealthKit doubleFromOptions:input key:@"manganese" withDefault:(double)0];
    double molybdenumValue = [RCTAppleHealthKit doubleFromOptions:input key:@"molybdenum" withDefault:(double)0];
    double niacinValue = [RCTAppleHealthKit doubleFromOptions:input key:@"niacin" withDefault:(double)0];
    double pantothenicAcidValue = [RCTAppleHealthKit doubleFromOptions:input key:@"pantothenicAcid" withDefault:(double)0];
    double phosphorusValue = [RCTAppleHealthKit doubleFromOptions:input key:@"phosphorus" withDefault:(double)0];
    double potassiumValue = [RCTAppleHealthKit doubleFromOptions:input key:@"potassium" withDefault:(double)0];
    double proteinValue = [RCTAppleHealthKit doubleFromOptions:input key:@"protein" withDefault:(double)0];
    double riboflavinValue = [RCTAppleHealthKit doubleFromOptions:input key:@"riboflavin" withDefault:(double)0];
    double seleniumValue = [RCTAppleHealthKit doubleFromOptions:input key:@"selenium" withDefault:(double)0];
    double sodiumValue = [RCTAppleHealthKit doubleFromOptions:input key:@"sodium" withDefault:(double)0];
    double sugarValue = [RCTAppleHealthKit doubleFromOptions:input key:@"sugar" withDefault:(double)0];
    double thiaminValue = [RCTAppleHealthKit doubleFromOptions:input key:@"thiamin" withDefault:(double)0];
    double vitaminAValue = [RCTAppleHealthKit doubleFromOptions:input key:@"vitaminA" withDefault:(double)0];
    double vitaminB12Value = [RCTAppleHealthKit doubleFromOptions:input key:@"vitaminB12" withDefault:(double)0];
    double vitaminB6Value = [RCTAppleHealthKit doubleFromOptions:input key:@"vitaminB6" withDefault:(double)0];
    double vitaminCValue = [RCTAppleHealthKit doubleFromOptions:input key:@"vitaminC" withDefault:(double)0];
    double vitaminDValue = [RCTAppleHealthKit doubleFromOptions:input key:@"vitaminD" withDefault:(double)0];
    double vitaminEValue = [RCTAppleHealthKit doubleFromOptions:input key:@"vitaminE" withDefault:(double)0];
    double vitaminKValue = [RCTAppleHealthKit doubleFromOptions:input key:@"vitaminK" withDefault:(double)0];
    double zincValue = [RCTAppleHealthKit doubleFromOptions:input key:@"zinc" withDefault:(double)0];
    
    // Metadata including some new food-related keys //
    NSDictionary *metadata = @{
            HKMetadataKeyFoodType:foodNameValue,
            //@"HKFoodBrandName":@"FoodBrandName", // Restaurant name or packaged food brand name
            //@"HKFoodTypeUUID":@"FoodTypeUUID", // Identifier for this food
            @"HKFoodMeal":mealNameValue//, // Breakfast, Lunch, Dinner, or Snacks 
            //@"HKFoodImageName":@"FoodImageName" // Food icon name
    };

    // Create nutrtional data for food //
    NSMutableSet *mySet = [[NSMutableSet alloc] init];
    if (biotinValue > 0){
        HKQuantitySample* biotin = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryBiotin]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:biotinValue]
                                                                    startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:biotin];
    }
    if (caffeineValue > 0){
        HKQuantitySample* caffeine = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCaffeine]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:caffeineValue]
                                                                    startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                    metadata:metadata];

        [mySet addObject:caffeine];
    }
    if (calciumValue > 0){
        HKQuantitySample* calcium = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCalcium]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:calciumValue]
                                                                    startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:calcium];
    }
    if (carbohydratesValue > 0){
        HKQuantitySample* carbohydrates = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:carbohydratesValue]
                                                                    startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:carbohydrates];
    }
    if (chlorideValue > 0){
        HKQuantitySample* chloride = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryChloride]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:chlorideValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                metadata:metadata];
        [mySet addObject:chloride];
    }
    if (cholesterolValue > 0){
        HKQuantitySample* cholesterol = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:cholesterolValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                metadata:metadata];
        [mySet addObject:cholesterol];
    }
    if (copperValue > 0){
        HKQuantitySample* copper = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCopper]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:copperValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                metadata:metadata];
        [mySet addObject:copper];
    }
    if (energyConsumedValue > 0){
        HKQuantitySample* energyConsumed = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit] doubleValue:energyConsumedValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                            metadata:metadata];
        [mySet addObject:energyConsumed];
    }
    if (fatMonounsaturatedValue > 0){
        HKQuantitySample* fatMonounsaturated = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatMonounsaturated]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:fatMonounsaturatedValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                metadata:metadata];
        [mySet addObject:fatMonounsaturated];
    }
    if (fatPolyunsaturatedValue > 0){
        HKQuantitySample* fatPolyunsaturated = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatPolyunsaturated]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:fatPolyunsaturatedValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                metadata:metadata];
        [mySet addObject:fatPolyunsaturated];
    }
    if (fatSaturatedValue > 0){
        HKQuantitySample* fatSaturated = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatSaturated]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:fatSaturatedValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                metadata:metadata];
        [mySet addObject:fatSaturated];
    }
    if (fatTotalValue > 0){
        HKQuantitySample* fatTotal = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:fatTotalValue]
                                                                startDate:timeFoodWasConsumed
                                                                    endDate:timeFoodWasConsumed
                                                                metadata:metadata];
        [mySet addObject:fatTotal];
    }
    if (fiberValue > 0){
        HKQuantitySample* fiber = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFiber]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:fiberValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:fiber];
    }
    if (folateValue > 0){
        HKQuantitySample* folate = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFolate]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:folateValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:folate];
    }
    if (iodineValue > 0){
        HKQuantitySample* iodine = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIodine]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:iodineValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:iodine];
    }
    if (ironValue > 0){
        HKQuantitySample* iron = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIron]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:ironValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:iron];
    }
    if (magnesiumValue > 0){
        HKQuantitySample* magnesium = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMagnesium]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:magnesiumValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:magnesium];
    }
    if (manganeseValue > 0){
        HKQuantitySample* manganese = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryManganese]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:manganeseValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:manganese];
    }
    if (molybdenumValue > 0){
        HKQuantitySample* molybdenum = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMolybdenum]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:molybdenumValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:molybdenum];
    }
    if (niacinValue > 0){
        HKQuantitySample* niacin = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryNiacin]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:niacinValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:niacin];
    }
    if (pantothenicAcidValue > 0){
        HKQuantitySample* pantothenicAcid = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPantothenicAcid]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:pantothenicAcidValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:pantothenicAcid];
    }
    if (phosphorusValue > 0){
        HKQuantitySample* phosphorus = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPhosphorus]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:phosphorusValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:phosphorus];
    }
    if (potassiumValue > 0){
        HKQuantitySample* potassium = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPotassium]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:potassiumValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:potassium];
    }
    if (proteinValue > 0){
        HKQuantitySample* protein = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:proteinValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:protein];
    }
    if (riboflavinValue > 0){
        HKQuantitySample* riboflavin = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryRiboflavin]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:riboflavinValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:riboflavin];
    }
    if (seleniumValue > 0){
        HKQuantitySample* selenium = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySelenium]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:seleniumValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:selenium];
    }
    if (sodiumValue > 0){
        HKQuantitySample* sodium = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySodium]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:sodiumValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:sodium];
    }
    if (sugarValue > 0){
        HKQuantitySample* sugar = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySugar]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:sugarValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:sugar];
    }
    if (thiaminValue > 0){
        HKQuantitySample* thiamin = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryThiamin]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:thiaminValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:thiamin];
    }
    if (vitaminAValue > 0){
        HKQuantitySample* vitaminA = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminA]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:vitaminAValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:vitaminA];
    }
    if (vitaminB12Value > 0){
        HKQuantitySample* vitaminB12 = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB12]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:vitaminB12Value]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:vitaminB12];
    }
    if (vitaminB6Value > 0){
        HKQuantitySample* vitaminB6 = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB6]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:vitaminB6Value]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:vitaminB6];
    }
    if (vitaminCValue > 0){
        HKQuantitySample* vitaminC = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminC]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:vitaminCValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:vitaminC];
    }
    if (vitaminDValue > 0){
        HKQuantitySample* vitaminD = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminD]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:vitaminDValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:vitaminD];
    }
    if (vitaminEValue > 0){
        HKQuantitySample* vitaminE = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminE]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:vitaminEValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
    
        [mySet addObject:vitaminE];
    }
    if (vitaminKValue > 0){
        HKQuantitySample* vitaminK = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminK]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:vitaminKValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:vitaminK];
    }
    if (zincValue > 0){
        HKQuantitySample* zinc = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryZinc]
                                                                    quantity:[HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:zincValue]
                                                                    startDate:timeFoodWasConsumed
                                                                        endDate:timeFoodWasConsumed
                                                                    metadata:metadata];
        [mySet addObject:zinc];
    }
    // Combine nutritional data into a food correlation //
    HKCorrelation* food = [HKCorrelation correlationWithType:[HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierFood]
                                                            startDate:timeFoodWasConsumed
                                                            endDate:timeFoodWasConsumed
                                                            objects:mySet
                                                            metadata:metadata];
    // Save the food correlation to HealthKit //
    [self.healthStore saveObject:food withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the food sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured saving the food sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @true]);
    }];
}

- (void)saveWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *timeWaterWasConsumed = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];
    double waterValue = [RCTAppleHealthKit doubleFromOptions:input key:@"water" withDefault:(double)0];

    HKQuantitySample* water = [HKQuantitySample quantitySampleWithType:[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater]
                                                                quantity:[HKQuantity quantityWithUnit:[HKUnit literUnit] doubleValue:waterValue]
                                                                startDate:timeWaterWasConsumed
                                                                endDate:timeWaterWasConsumed
                                                                metadata:nil];

    // Save the water Sample to HealthKit //
    [self.healthStore saveObject:water withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the water sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured saving the water sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @true]);
    }];
}

@end
