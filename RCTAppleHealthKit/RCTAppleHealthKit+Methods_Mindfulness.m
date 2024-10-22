//
//  RCTAppleHealthKit+Methods_Mindfulness.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit+Methods_Mindfulness.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Mindfulness)


- (void)mindfulness_getMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    double limit = [RCTAppleHealthKit doubleFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc]
        initWithKey:HKSampleSortIdentifierEndDate
        ascending:NO
    ];

    HKCategoryType *type = [HKCategoryType categoryTypeForIdentifier: HKCategoryTypeIdentifierMindfulSession];
    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    HKSampleQuery *query = [[HKSampleQuery alloc]
        initWithSampleType:type
        predicate:predicate
        limit: limit
        sortDescriptors:@[timeSortDescriptor]
        resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {

            if (error != nil) {
            NSLog(@"error with fetchCumulativeSumStatisticsCollection: %@", error);
            callback(@[RCTMakeError(@"error with fetchCumulativeSumStatisticsCollection", error, nil)]);
            return;
            }
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:(10)];

            for (HKQuantitySample *sample in results) {
            NSLog(@"sample for mindfulsession %@", sample);
            NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
            NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

            NSDictionary *elem = @{
                    @"startDate" : startDateString,
                    @"endDate" : endDateString,
            };

            [data addObject:elem];
        }
        callback(@[[NSNull null], data]);
     }
    ];
    [self.healthStore executeQuery:query];
}

- (void)mindfulness_saveMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    double value = [RCTAppleHealthKit doubleFromOptions:input key:@"value" withDefault:(double)0];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    if(startDate == nil || endDate == nil){
        callback(@[RCTMakeError(@"startDate and endDate are required in options", nil, nil)]);
        return;
    }

    HKCategoryType *type = [HKCategoryType categoryTypeForIdentifier: HKCategoryTypeIdentifierMindfulSession];
    HKCategorySample *sample = [HKCategorySample categorySampleWithType:type value:value startDate:startDate endDate:endDate];


    [self.healthStore saveObject:sample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
        callback(@[[NSNull null], @(value)]);
    }];

}

- (void)mindfulness_deleteAllMindfulSessions:(RCTResponseSenderBlock)callback
{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:HKSampleSortIdentifierEndDate ascending:false];
    HKSampleType *mindfulType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession];

    // Get all samples from 1970 until now
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *endDate = [NSDate date];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionNone];

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:mindfulType predicate:predicate limit:0 sortDescriptors:@[sortDescriptor] resultsHandler:^(HKSampleQuery * _Nonnull query, NSArray<__kindof HKSample *> * _Nullable results, NSError * _Nullable error) {
        if (error) {
            NSLog(@"An error occured while deleting the mindful sessions %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while deleting the glucose sample", error, nil)]);
            return;
        }
        if (results.count == 0) {
            callback(@[[NSNull null], @0]);
            return;
        }
        [self.healthStore deleteObjects:results withCompletion:^(BOOL success, NSError * _Nullable error) {
            if (!success) {
                NSLog(@"An error occured while deleting the mindful sessions %@. The error was: ", error);
                callback(@[RCTMakeError(@"An error occured while deleting the glucose sample", error, nil)]);
                return;
            }
            callback(@[[NSNull null], @(results.count)]);
        }];
    }];

    [self.healthStore executeQuery:query];
}


@end
