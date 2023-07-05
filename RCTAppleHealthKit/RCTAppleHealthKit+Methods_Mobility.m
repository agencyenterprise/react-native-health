//
//  RCTAppleHealthKit+Methods_Mobility.m
//  RCTAppleHealthKit
//
//  Created by mefisto
//  LICENSE VitalBeats
//

#import "RCTAppleHealthKit+Methods_Mobility.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Mobility)


- (void)mobility_getSixMinuteWalkTestDistance:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *sixMinuteWalkTestDistanceType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierSixMinuteWalkTestDistance];
    
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit meterUnit]];
    
    [self fetchMostRecentQuantitySampleOfType:sixMinuteWalkTestDistanceType
                                    predicate:nil
                                   completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
        if (error != nil) {
            callback(@[RCTJSErrorFromNSError(error)]);
        } else if (mostRecentQuantity == nil) {
            callback(@[[NSNull null], @{
                @"value" : @0,
            }]);
        } else {
            double sixMinuteWalkTestDistance = [mostRecentQuantity doubleValueForUnit:unit];
            
            NSDictionary *response = @{
                @"value" : @(sixMinuteWalkTestDistance),
            };
            callback(@[[NSNull null], response]);
        }
    }];
}

@end
