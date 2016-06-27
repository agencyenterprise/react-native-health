//
//  RCTAppleHealthKit+Methods_Body.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Body.h"
#import "RCTAppleHealthKit+Queries.h"

@implementation RCTAppleHealthKit (Methods_Body)

- (void)body_getCurrentWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    // Query to get the user's latest weight, if it exists.
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];

    [self fetchMostRecentQuantitySampleOfType:weightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
        }
        else {
            // Determine the weight in the required unit.
            HKUnit *weightUnit = [HKUnit poundUnit];
            double usersWeight = [mostRecentQuantity doubleValueForUnit:weightUnit];

            callback(@[[NSNull null], @(usersWeight)]);
        }
    }];
}




- (void)body_saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double weight= [[input objectForKey:@"weight"] doubleValue];

    HKUnit *poundUnit = [HKUnit poundUnit];
    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:poundUnit doubleValue:weight];

    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    NSDate *now = [NSDate date];

    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:now endDate:now];

    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", weightSample, error);
            callback(@[RCTMakeError(@"An error occured saving the weight sample", nil, nil)]);
            return;
            // abort();
        }
        callback(@[[NSNull null], @(weight)]);
    }];
}



- (void)body_getLatestBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    // Query to get the user's latest BMI, if it exists.
    HKQuantityType *bmiType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];

    [self fetchMostRecentQuantitySampleOfType:bmiType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's bmi information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's bmi information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
        }
        else {
            // Determine the bmi in the required unit.
            HKUnit *countUnit = [HKUnit countUnit];
            double bmi = [mostRecentQuantity doubleValueForUnit:countUnit];

            callback(@[[NSNull null], @(bmi)]);
        }
    }];
}



@end
