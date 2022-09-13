//
//  RCTAppleHealthKit+Methods_Sleep.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

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
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];

    [self fetchSleepCategorySamplesForPredicate:predicate
                                          limit:limit
                                      ascending:ascending
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

- (void)sleep_saveSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    @try {
        double value = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

        if(startDate == nil || endDate == nil){
            callback(@[RCTMakeError(@"startDate and endDate are required in options", nil, nil)]);
            return;
        }

        HKCategoryType *type = [HKCategoryType categoryTypeForIdentifier: HKCategoryTypeIdentifierSleepAnalysis];
        HKCategorySample *sample = [HKCategorySample categorySampleWithType:type value:value startDate:startDate endDate:endDate];


        [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
            if (!success) {
                callback(@[RCTJSErrorFromNSError(error)]);
                return;
            }
            callback(@[[NSNull null], @(value)]);
        }];
    } @catch (NSException *exception) {
        // https://stackoverflow.com/a/43561618/3670829
        NSMutableDictionary * info = [NSMutableDictionary dictionary];
        [info setValue:exception.name forKey:@"ExceptionName"];
        [info setValue:exception.reason forKey:@"ExceptionReason"];
        [info setValue:exception.callStackReturnAddresses forKey:@"ExceptionCallStackReturnAddresses"];
        [info setValue:exception.callStackSymbols forKey:@"ExceptionCallStackSymbols"];
        [info setValue:exception.userInfo forKey:@"ExceptionUserInfo"];
        NSError *error = [[NSError alloc] initWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:0 userInfo:info];
        callback(@[RCTJSErrorFromNSError(error)]);

    }
}

@end
