
#import "RCTAppleHealthKit+Methods_Sleep.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Sleep)



- (void)sleep_getSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }

    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    NSUInteger *limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];


    [self fetchSleepCategorySamplesForPredicate:predicate
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting sleep samples: %@", error);
            callback(@[RCTMakeError(@"error getting sleep samples", nil, nil)]);
            return;
        }
    }];












// fetchSleepCategorySamplesForPredicate




    // HKCategoryType *categoryType =
    // [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    //
    // HKCategorySample *categorySample =
    // [HKCategorySample categorySampleWithType:categoryType
    //                                    value:HKCategoryValueSleepAnalysisAsleep
    //                                startDate:startDate
    //                                  endDate:endDate];





    // HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    //
    // HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input];
    // if(unit == nil){
    //     unit = [HKUnit poundUnit];
    // }
    //
    // [self fetchMostRecentQuantitySampleOfType:weightType
    //                                 predicate:nil
    //                                completion:^(HKQuantity *mostRecentQuantity, NSDate *startDate, NSDate *endDate, NSError *error) {
    //     if (!mostRecentQuantity) {
    //         NSLog(@"error getting latest weight: %@", error);
    //         callback(@[RCTMakeError(@"error getting latest weight", error, nil)]);
    //     }
    //     else {
    //         // Determine the weight in the required unit.
    //         double usersWeight = [mostRecentQuantity doubleValueForUnit:unit];
    //
    //         NSDictionary *response = @{
    //                 @"value" : @(usersWeight),
    //                 @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:startDate],
    //                 @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:endDate],
    //         };
    //
    //         callback(@[[NSNull null], response]);
    //     }
    // }];
}


@end
