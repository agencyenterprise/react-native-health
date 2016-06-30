//
//  RCTAppleHealthKit+Methods_Fitness.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Fitness.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

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


- (void)fitness_getStepCountForDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input];
    if(date == nil) {
        callback(@[RCTMakeError(@"could not parse date from options.date", nil, nil)]);
        return;
    }

    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKUnit *stepsUnit = [HKUnit countUnit];

    [self fetchSumOfSamplesOnDayForType:stepCountType unit:stepsUnit day:date completion:^(double totalSteps, NSError *error) {
        if (!totalSteps) {
            NSLog(@"could not fetch step count for day: %@", error);
            callback(@[RCTMakeError(@"could not fetch step count for day", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(totalSteps)]);
    }];
}




- (void)fitness_getDailyStepCounts:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit startDateFromOptions:input];
    NSDate *endDate = [RCTAppleHealthKit endDateFromOptionsDefaultNow:input];

    if(startDate == nil) {
        callback(@[RCTMakeError(@"could not parse required startDate from options.startDate", nil, nil)]);
        return;
    }

    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKUnit *stepsUnit = [HKUnit countUnit];

    [self fetchCumulativeSumStatisticsCollection:stepCountType unit:stepsUnit startDate:startDate endDate:endDate completion:^(NSArray *arr, NSError *err){
        if (err != nil) {
            NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
            callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
            return;
        }
        callback(@[[NSNull null], arr]);
    }];
}




- (void)fitness_getDailyStepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit countUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }


//    NSDate *startDate = [RCTAppleHealthKit startDateFromOptions:input];
//    NSDate *endDate = [RCTAppleHealthKit endDateFromOptionsDefaultNow:input];

//    if(startDate == nil) {
//        callback(@[RCTMakeError(@"could not parse required startDate from options.startDate", nil, nil)]);
//        return;
//    }

    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKUnit *stepsUnit = [HKUnit countUnit];

//    [self fetchCumulativeSumStatisticsCollection:stepCountType unit:stepsUnit startDate:startDate endDate:endDate completion:^(NSArray *arr, NSError *err){
//        if (err != nil) {
//            NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
//            callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
//            return;
//        }
//        callback(@[[NSNull null], arr]);
//    }];

    [self fetchCumulativeSumStatisticsCollection:stepCountType unit:unit startDate:startDate endDate:endDate ascending:ascending limit:limit completion:^(NSArray *arr, NSError *err){
        if (err != nil) {
            NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
            callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
            return;
        }
        callback(@[[NSNull null], arr]);
    }];

}




@end
