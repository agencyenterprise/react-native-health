//
//  RCTAppleHealthKit+Methods_Body.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Body.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Body)


- (void)body_getCurrentWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    // Query to get the user's latest weight, if it exists.
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input];
    if(unit == nil){
        unit = [HKUnit poundUnit];
    }

    [self fetchMostRecentQuantitySampleOfType:weightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
        }
        else {
            // Determine the weight in the required unit.
            double usersWeight = [mostRecentQuantity doubleValueForUnit:unit];
            callback(@[[NSNull null], @(usersWeight)]);
        }
    }];
}


- (void)body_saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
//    double weight= [[input objectForKey:@"weight"] doubleValue];
    double weight = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input];
    if(unit == nil){
        unit = [HKUnit poundUnit];
    }

    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:unit doubleValue:weight];
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", weightSample, error);
            callback(@[RCTMakeError(@"An error occured saving the weight sample", nil, nil)]);
            return;
        }
        callback(@[[NSNull null], @(weight)]);
    }];
}


- (void)body_getLatestBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    // Query to get the user's latest BMI, if it exists.
    HKQuantityType *bmiType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];

    [self fetchMostRecentQuantitySampleOfType:bmiType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's bmi information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's bmi information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
        }
        else {
            // Determine the bmi in the required unit.
            HKUnit *countUnit = [HKUnit countUnit];
            double bmi = [mostRecentQuantity doubleValueForUnit:countUnit];

            NSDictionary *response = @{
                    @"value" : @(bmi),
                    @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                    @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
            };

            callback(@[[NSNull null], response]);
        }
    }];
}



- (void)body_saveBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double bmi = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];
    HKUnit *unit = [HKUnit countUnit];

    HKQuantity *bmiQuantity = [HKQuantity quantityWithUnit:unit doubleValue:bmi];
    HKQuantityType *bmiType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    HKQuantitySample *bmiSample = [HKQuantitySample quantitySampleWithType:bmiType quantity:bmiQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:bmiSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the bmi sample %@. In your app, try to handle this gracefully. The error was: %@.", bmiSample, error);
            callback(@[RCTMakeError(@"An error occured saving the bmi sample", nil, nil)]);
            return;
        }
        callback(@[[NSNull null], @(bmi)]);
    }];
}



- (void)body_getMostRecentHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input];
    if(unit == nil){
        unit = [HKUnit inchUnit];
    }

    [self fetchMostRecentQuantitySampleOfType:heightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's height information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's height information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
        }
        else {
            // Determine the height in the required unit.
            double usersHeight = [mostRecentQuantity doubleValueForUnit:unit];
            callback(@[[NSNull null], @(usersHeight)]);
        }
    }];
}


- (void)body_saveHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double height = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptionsDefaultNow:input];

    HKUnit *heightUnit = [RCTAppleHealthKit hkUnitFromOptions:input];
    if(heightUnit == nil){
        heightUnit = [HKUnit inchUnit];
    }

    HKQuantity *heightQuantity = [HKQuantity quantityWithUnit:heightUnit doubleValue:height];
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:heightQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:heightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the height sample %@. In your app, try to handle this gracefully. The error was: %@.", heightSample, error);
            callback(@[RCTMakeError(@"An error occured saving the height sample", nil, nil)]);
            return;
        }
        callback(@[[NSNull null], @(height)]);
    }];
}


- (void)body_getMostRecentBodyFatPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bodyFatPercentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];

    [self fetchMostRecentQuantitySampleOfType:bodyFatPercentType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's BodyFatPercentage information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's BodyFatPercentage information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
        }
        else {
            // Determine the weight in the required unit.
            HKUnit *percentUnit = [HKUnit percentUnit];
            double percentage = [mostRecentQuantity doubleValueForUnit:percentUnit];

            percentage = percentage * 100;

            callback(@[[NSNull null], @(percentage)]);
        }
    }];
}


- (void)body_getMostRecentLeanBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *leanBodyMassType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];

    [self fetchMostRecentQuantitySampleOfType:leanBodyMassType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's LeanBodyMass information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's LeanBodyMass information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
        }
        else {
            HKUnit *weightUnit = [HKUnit poundUnit];
            double leanBodyMass = [mostRecentQuantity doubleValueForUnit:weightUnit];

            callback(@[[NSNull null], @(leanBodyMass)]);
        }
    }];
}


@end
