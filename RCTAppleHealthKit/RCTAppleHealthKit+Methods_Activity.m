//
//  RCTAppleHealthKit+Methods_Activity.m
//  RCTAppleHealthKit
//
//  Created by Alexander Vallorosi on 4/27/17.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit+Methods_Activity.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Activity)

- (void)activity_getActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *cal = [HKUnit kilocalorieUnit];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    [self fetchCumulativeSumStatisticsCollection:activeEnergyType
                                            unit:cal
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:false
                                           limit:HKObjectQueryNoLimit
                                      completion:^(NSArray *results, NSError *error) {
                                          if(results){
                                              callback(@[[NSNull null], results]);
                                              return;
                                          } else {
                                              NSLog(@"error getting active energy burned samples: %@", error);
                                              callback(@[RCTMakeError(@"error getting active energy burned samples", nil, nil)]);
                                              return;
                                          }
                                      }];
}

- (void)activity_getBasalEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *basalEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *cal = [HKUnit kilocalorieUnit];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    [self fetchCumulativeSumStatisticsCollection:basalEnergyType
                                                unit:cal
                                        startDate:startDate
                                            endDate:endDate
                                        ascending:false
                                            limit:HKObjectQueryNoLimit
                                        completion:^(NSArray *results, NSError *error) {
                                            if(results){
                                                callback(@[[NSNull null], results]);
                                                return;
                                            } else {
                                                NSLog(@"error getting basal energy burned samples: %@", error);
                                                callback(@[RCTMakeError(@"error getting basal energy burned samples", nil, nil)]);
                                                return;
                                            }
                                        }];
}


- (void)activity_getAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *exerciseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *unit = [HKUnit secondUnit];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    [self fetchCumulativeSumStatisticsCollection:exerciseType
                                            unit:unit
                                       startDate:startDate
                                         endDate:endDate
                                       ascending:false
                                           limit:HKObjectQueryNoLimit
                                      completion:^(NSArray *results, NSError *error) {
                                          if(results){
                                              callback(@[[NSNull null], results]);
                                              return;
                                          } else {
                                              NSLog(@"error getting exercise time: %@", error);
                                              callback(@[RCTMakeError(@"error  getting exercise time", nil, nil)]);
                                              return;
                                          }
                                      }];
}

@end
