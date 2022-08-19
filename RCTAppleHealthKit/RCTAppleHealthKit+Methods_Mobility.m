//
//  RCTAppleHealthKit+Methods_Results.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit+Methods_Reproductive.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Mobility)

- (void)mobility_getDoubleSupportPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    if (@available(iOS 14.0, *)) {
        HKUnit *unit = [HKUnit percentUnit];
        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
        double limit = [RCTAppleHealthKit doubleFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
        BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
        HKQuantityType *type = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingDoubleSupportPercentage];
        NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
        
        [self fetchQuantitySamplesOfType:type
                                    unit:unit
                               predicate:predicate
                               ascending:ascending
                                   limit:limit
                              completion:^(NSArray *results, NSError *error) {
            if(results){
                callback(@[[NSNull null], results]);
                return;
            } else {
                callback(@[RCTJSErrorFromNSError(error), [NSNull null]]);
                return;
            }
        }];
    } else {
        callback(@[@"DoubleSupportPercentage is only available on iOS 14.0 or newer", [NSNull null]]);
    }
}

@end
