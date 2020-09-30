//
//  RCTAppleHealthKit+Methods_LabTests.m
//  RCTAppleHealthKit
//
//  Created by Daniel Rufus Kaldheim on 2020-09-29.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_LabTests.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_LabTests)


- (void)labTests_getLatestBloodAlcoholContent:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    
    HKQuantityType *bloodAlcoholContentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit percentUnit]];
    
    [self fetchMostRecentQuantitySampleOfType:bloodAlcoholContentType
                                    predicate:nil
                                   completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (!mostRecentQuantity) {
            callback(@[RCTJSErrorFromNSError(error)]);
        }
        else {
            // Determine the weight in the required unit.
            double usersBloodAlcoholContent = [mostRecentQuantity doubleValueForUnit:unit];
            NSDictionary *response = @{
                    @"value" : @(usersBloodAlcoholContent),
                    @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
                    @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
            };

            callback(@[[NSNull null], response]);
        }
    }];
}
    
- (void)labTests_getBloodAlcoholContentSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    
    HKQuantityType *bloodAlcoholContentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit percentUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bloodAlcoholContentType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
    }];
    
}
    
- (void)labTests_saveBloodAlcoholContent:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double bloodAlcoholContent = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit percentUnit]];

    HKQuantity *bloodAlcoholContentQuantity = [HKQuantity quantityWithUnit:unit doubleValue:bloodAlcoholContent];
    HKQuantityType *bloodAlcoholContentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    HKQuantitySample *bloodAcloholContentSample = [HKQuantitySample quantitySampleWithType:bloodAlcoholContentType quantity:bloodAlcoholContentQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:bloodAcloholContentSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
        callback(@[[NSNull null], @(bloodAlcoholContent)]);
    }];
}

@end
