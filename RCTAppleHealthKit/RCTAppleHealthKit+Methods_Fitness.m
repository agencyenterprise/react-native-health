//
//  RCTAppleHealthKit+Methods_Fitness.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Fitness.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Methods_Fitness)


- (void)fitness_getStepCountOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    if(date == nil) {
        callback(@[RCTMakeError(@"could not parse date from options.date", nil, nil)]);
        return;
    }

    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKUnit *stepsUnit = [HKUnit countUnit];

    [self fetchSumOfSamplesOnDayForType:stepCountType
                                   unit:stepsUnit
                                    day:date
                             completion:^(double value, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!value) {
            NSLog(@"could not fetch step count for day: %@", error);
            callback(@[RCTMakeError(@"could not fetch step count for day", error, nil)]);
            return;
        }

         NSDictionary *response = @{
                 @"value" : @(value),
                 @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                 @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
         };

        callback(@[[NSNull null], response]);
    }];
}

- (void)fitness_getSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit countUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSString *type = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:@"Walking"];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    
    HKSampleType *samplesType = [RCTAppleHealthKit hkQuantityTypeFromString:type];
    if ([type isEqual:@"Running"] || [type isEqual:@"Cycling"]) {
        unit = [HKUnit mileUnit];
    }
    NSLog(@"error getting samples: %@", [samplesType identifier]);
    [self fetchSamplesOfType:samplesType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting samples", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)fitness_setObserver:(NSDictionary *)input
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit countUnit]];
    NSString *type = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:@"Walking"];
    
    HKSampleType *samplesType = [RCTAppleHealthKit hkQuantityTypeFromString:type];
    if ([type isEqual:@"Running"] || [type isEqual:@"Cycling"]) {
        unit = [HKUnit mileUnit];
    }
    
    [self setObserverForType:samplesType unit:unit];
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

    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

    [self fetchCumulativeSumStatisticsCollection:stepCountType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
        if (err != nil) {
            NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
            callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
            return;
        }
        callback(@[[NSNull null], arr]);
    }];
}


- (void)fitness_saveSteps:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double value = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    if(startDate == nil || endDate == nil){
        callback(@[RCTMakeError(@"startDate and endDate are required in options", nil, nil)]);
        return;
    }

    HKUnit *unit = [HKUnit countUnit];
    HKQuantity *quantity = [HKQuantity quantityWithUnit:unit doubleValue:value];
    HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantitySample *sample = [HKQuantitySample quantitySampleWithType:type quantity:quantity startDate:startDate endDate:endDate];

    [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the step count sample %@. The error was: %@.", sample, error);
            callback(@[RCTMakeError(@"An error occured saving the step count sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(value)]);
    }];
}


- (void)fitness_initializeStepEventObserver:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKSampleType *sampleType =
    [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

    HKObserverQuery *query =
    [[HKObserverQuery alloc]
     initWithSampleType:sampleType
     predicate:nil
     updateHandler:^(HKObserverQuery *query,
                     HKObserverQueryCompletionHandler completionHandler,
                     NSError *error) {

         if (error) {
             // Perform Proper Error Handling Here...
             NSLog(@"*** An error occured while setting up the stepCount observer. %@ ***", error.localizedDescription);
             callback(@[RCTMakeError(@"An error occured while setting up the stepCount observer", error, nil)]);
             return;
         }

          [self.bridge.eventDispatcher sendAppEventWithName:@"change:steps"
                                                       body:@{@"name": @"change:steps"}];

         // If you have subscribed for background updates you must call the completion handler here.
         // completionHandler();

     }];

    [self.healthStore executeQuery:query];
}


- (void)fitness_getDistanceWalkingRunningOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];

    [self fetchSumOfSamplesOnDayForType:quantityType unit:unit day:date completion:^(double distance, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!distance) {
            NSLog(@"ERROR getting DistanceWalkingRunning: %@", error);
            callback(@[RCTMakeError(@"ERROR getting DistanceWalkingRunning", error, nil)]);
            return;
        }

        NSDictionary *response = @{
                @"value" : @(distance),
                @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
        };


        callback(@[[NSNull null], response]);
    }];
}

- (void)fitness_getDailyDistanceWalkingRunningSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    
    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    [self fetchCumulativeSumStatisticsCollection:quantityType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
                                          if (err != nil) {
                                              NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
                                              callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
                                              return;
                                          }
                                          callback(@[[NSNull null], arr]);
                                      }];
}

- (void)fitness_getDistanceCyclingOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];

    [self fetchSumOfSamplesOnDayForType:quantityType unit:unit day:date completion:^(double distance, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!distance) {
            NSLog(@"ERROR getting DistanceCycling: %@", error);
            callback(@[RCTMakeError(@"ERROR getting DistanceCycling", error, nil)]);
            return;
        }

        NSDictionary *response = @{
                @"value" : @(distance),
                @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
        };

        callback(@[[NSNull null], response]);
    }];
}

- (void)fitness_getDailyDistanceCyclingSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    
    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    
    [self fetchCumulativeSumStatisticsCollection:quantityType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
                                          if (err != nil) {
                                              NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
                                              callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
                                              return;
                                          }
                                          callback(@[[NSNull null], arr]);
                                      }];
}

- (void)fitness_getFlightsClimbedOnDay:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKUnit *unit = [HKUnit countUnit];
    NSDate *date = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];

    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];

    [self fetchSumOfSamplesOnDayForType:quantityType unit:unit day:date completion:^(double count, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!count) {
            NSLog(@"ERROR getting FlightsClimbed: %@", error);
            callback(@[RCTMakeError(@"ERROR getting FlightsClimbed", error, nil), @(count)]);
            return;
        }

        NSDictionary *response = @{
                @"value" : @(count),
                @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
        };

        callback(@[[NSNull null], response]);
    }];
}

- (void)fitness_getDailyFlightsClimbedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
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
    
    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    
    [self fetchCumulativeSumStatisticsCollection:quantityType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:limit
                                      completion:^(NSArray *arr, NSError *err){
                                          if (err != nil) {
                                              NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", err);
                                              callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", err, nil)]);
                                              return;
                                          }
                                          callback(@[[NSNull null], arr]);
                                      }];
}

@end
