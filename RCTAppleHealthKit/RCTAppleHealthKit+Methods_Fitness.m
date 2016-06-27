//
//  RCTAppleHealthKit+Methods_Fitness.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Fitness.h"
#import "RCTAppleHealthKit+Queries.h"

@implementation RCTAppleHealthKit (Methods_Fitness)

- (void)fitness_getStepCountForToday:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKUnit *stepsUnit = [HKUnit countUnit];

    [self fetchSumOfSamplesTodayForType:stepCountType unit:stepsUnit completion:^(double totalSteps, NSError *error) {
        if (!totalSteps) {
            NSLog(@"Either an error occured fetching the user's step count information or none has been stored yet. In your app, try to handle this gracefully.");
            callback(@[RCTMakeError(@"Either an error occured fetching the user's step count information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
            return;
        }

        callback(@[[NSNull null], @(totalSteps)]);
    }];
}

@end
