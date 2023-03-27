//
//  RCTAppleHealthKit+Methods_Activity.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit+Methods_Activity.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Activity)

// - (void)activity_getTotalEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
// {
//     HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
//     HKQuantityType *restingEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];

//     HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit kilocalorieUnit]];
//     BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
//     NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
//     NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
//     NSUInteger period = [RCTAppleHealthKit uintFromOptions:input key:@"period" withDefault:60];
//     BOOL includeManuallyAdded = [RCTAppleHealthKit boolFromOptions:input key:@"includeManuallyAdded" withDefault:true];

//     if(startDate == nil){
//         callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
//         return;
//     }

//     [self fetchCumulativeSumStatisticsCollection:activeEnergyType
//                                             unit:unit
//                                           period:period
//                                        startDate:startDate
//                                          endDate:endDate
//                                        ascending:ascending
//                                            limit:HKObjectQueryNoLimit
//                             includeManuallyAdded:includeManuallyAdded
//                                       completion:^(NSArray *activeEnergyResults, NSError *error) {
//                                           if(error){
//                                               NSLog(@"error getting active energy burned samples: %@", error);
//                                               callback(@[RCTMakeError(@"error getting active energy burned samples:", error, nil)]);
//                                               return;
//                                           } else {
//                                               [self fetchCumulativeSumStatisticsCollection:restingEnergyType
//                                                                                       unit:unit
//                                                                                     period:period
//                                                                                  startDate:startDate
//                                                                                    endDate:endDate
//                                                                                  ascending:ascending
//                                                                                      limit:HKObjectQueryNoLimit
//                                                                       includeManuallyAdded:includeManuallyAdded
//                                                                                 completion:^(NSArray *restingEnergyResults, NSError *error) {
//                                                                                     if(error){
//                                                                                         NSLog(@"error getting resting energy burned samples: %@", error);
//                                                                                         callback(@[RCTMakeError(@"error getting resting energy burned samples:", error, nil)]);
//                                                                                         return;
//                                                                                     } else {
//                                                                                         // Calculate the total energy burned by summing up the active energy and resting energy
//                                                                                         double totalEnergyBurned = 0.0;
//                                                                                         for (HKStatistics *activeEnergy in activeEnergyResults) {
//                                                                                             HKQuantity *activeEnergyQuantity = activeEnergy.sumQuantity;
//                                                                                             HKQuantity *restingEnergyQuantity = restingEnergyResults[activeEnergyResults.indexOfObject:activeEnergy].sumQuantity;
//                                                                                             double activeEnergyValue = [activeEnergyQuantity doubleValueForUnit:unit];
//                                                                                             double restingEnergyValue = [restingEnergyQuantity doubleValueForUnit:unit];
//                                                                                             totalEnergyBurned += activeEnergyValue + restingEnergyValue;
//                                                                                         }
//                                                                                         callback(@[[NSNull null], @(totalEnergyBurned)]);
//                                                                                         return;
//                                                                                     }
//                                                                                 }];
//                                           }
//                                       }];
// }


- (void)activity_getActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit kilocalorieUnit]];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSUInteger period = [RCTAppleHealthKit uintFromOptions:input key:@"period" withDefault:60];
    BOOL includeManuallyAdded = [RCTAppleHealthKit boolFromOptions:input key:@"includeManuallyAdded" withDefault:true];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    [self fetchCumulativeSumStatisticsCollection:activeEnergyType
                                            unit:unit
                                          period:period
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:HKObjectQueryNoLimit
                            includeManuallyAdded:includeManuallyAdded
                                      completion:^(NSArray *results, NSError *error) {
                                          if(results){
                                              callback(@[[NSNull null], results]);
                                              return;
                                          } else {
                                              NSLog(@"error getting active energy burned samples: %@", error);
                                              callback(@[RCTMakeError(@"error getting active energy burned samples:", error, nil)]);
                                              return;
                                          }
                                      }];
}

- (void)activity_getBasalEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *basalEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit kilocalorieUnit]];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSUInteger period = [RCTAppleHealthKit uintFromOptions:input key:@"period" withDefault:60];
    BOOL includeManuallyAdded = [RCTAppleHealthKit boolFromOptions:input key:@"includeManuallyAdded" withDefault:true];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    [self fetchCumulativeSumStatisticsCollection:basalEnergyType
                                            unit:unit
                                          period:period
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:HKObjectQueryNoLimit
                            includeManuallyAdded:includeManuallyAdded
                                      completion:^(NSArray *results, NSError *error) {
                                          if(results){
                                              callback(@[[NSNull null], results]);
                                              return;
                                          } else {
                                              NSLog(@"error getting basal energy burned samples: %@", error);
                                              callback(@[RCTMakeError(@"error getting basal energy burned samples:", error, nil)]);
                                              return;
                                          }
                                      }];
}


- (void)activity_getAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *exerciseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit secondUnit]];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSUInteger period = [RCTAppleHealthKit uintFromOptions:input key:@"period" withDefault:60];
    BOOL includeManuallyAdded = [RCTAppleHealthKit boolFromOptions:input key:@"includeManuallyAdded" withDefault:true];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    [self fetchCumulativeSumStatisticsCollection:exerciseType
                                            unit:unit
                                          period:period
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:HKObjectQueryNoLimit
                            includeManuallyAdded:includeManuallyAdded
                                      completion:^(NSArray *results, NSError *error) {
                                          if(results){
                                              callback(@[[NSNull null], results]);
                                              return;
                                          } else {
                                              NSLog(@"error getting exercise time: %@", error);
                                              callback(@[RCTMakeError(@"error getting exercise time:", error, nil)]);
                                              return;
                                          }
                                      }];
}

- (void)activity_getAppleStandTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *exerciseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleStandTime];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit secondUnit]];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSUInteger period = [RCTAppleHealthKit uintFromOptions:input key:@"period" withDefault:60];
    BOOL includeManuallyAdded = [RCTAppleHealthKit boolFromOptions:input key:@"includeManuallyAdded" withDefault:true];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    [self fetchCumulativeSumStatisticsCollection:exerciseType
                                            unit:unit
                                          period:period
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:ascending
                                           limit:HKObjectQueryNoLimit
                            includeManuallyAdded:includeManuallyAdded
                                      completion:^(NSArray *results, NSError *error) {
                                          if(results){
                                              callback(@[[NSNull null], results]);
                                              return;
                                          } else {
                                              NSLog(@"error getting stand time: %@", error);
                                              callback(@[RCTMakeError(@"error getting stand time:", error, nil)]);
                                              return;
                                          }
                                      }];
}

@end
