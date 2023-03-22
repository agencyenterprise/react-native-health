//
//  RCTAppleHealthKit+Methods_MedianStatistics.m
//  RCTAppleHealthKit
//
//  Created by Anastasia Mishur on 14.03.23.
//  Copyright © 2023 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_MedianStatistics.h"
#import "RCTAppleHealthKit+TypesForMedianStatistic.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTLog.h>

@implementation RCTAppleHealthKit (RTCAppleHealthKit_Methods_MedianStatistics)

// MARK: - Public

- (void)statistics_getMedianStatistic:(NSArray *)input callback:(RCTResponseSenderBlock)callback {

    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *endDate = [NSDate date];

    NSMutableArray *output = [NSMutableArray new];

    // prepare object from input values
    NSMutableDictionary *validSamples = [NSMutableDictionary new];
    for(NSString *sampleName in input) {
        HKSampleType *sampleValue =(HKSampleType *)[self getObjectFromText:sampleName];
        if (sampleValue != nil) {
            validSamples[sampleName] = sampleValue;
        }
    }

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 5;

    NSOperation *doneOperation = [[NSOperation alloc] init];
    [doneOperation setCompletionBlock:^{
        callback(@[[NSNull null], output]);
        return;
    }];

    for(NSString *sampleName in [validSamples allKeys]) {

        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{

            HKSampleType *sample = validSamples[sampleName];

            int limit = 100;
            __block HKQueryAnchor *anchor = nil;
            __block NSMutableArray<__kindof HKSample *> *resultArray = [NSMutableArray new];
            __block NSMutableArray<__kindof HKSample *> *samplesFirstByDate = [NSMutableArray new];
            __block NSMutableArray<__kindof HKSample *> *samplesLastByDate = [NSMutableArray new];
            __block BOOL hasResults = YES;
            __block NSString *anchorString = nil;

            while (hasResults) {
                if (anchorString != nil) {
                    NSData* anchorData = [[NSData alloc] initWithBase64EncodedString:anchorString options:0];
                    anchor = [NSKeyedUnarchiver unarchiveObjectWithData:anchorData];
                }

                NSPredicate *predicate = [RCTAppleHealthKit predicateForAnchoredQueries:anchor startDate:startDate endDate:endDate];

                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

                [self fetchBatchOfSamples:sample
                                predicate:predicate
                                   anchor:anchor
                                    limit:limit
                               completion:^(NSDictionary *results, NSError *error) {

                    if (results) {
                        @try {

                            NSMutableArray<__kindof HKSample *> *data = results[@"data"];

                            if (([sample isKindOfClass:[HKWorkoutType class]]) && (![@"Workout" isEqual:sampleName])) {
                                NSMutableArray<__kindof HKSample *> *dataByActivityType = [NSMutableArray new];

                                for(HKWorkout *sampleElement in data) {
                                    NSString *type = [RCTAppleHealthKit stringForHKWorkoutActivityType:[sampleElement workoutActivityType]];
                                    if ([type isEqualToString:sampleName]) {
                                        [dataByActivityType addObject:sampleElement];
                                    }
                                }

                                data = dataByActivityType;
                            }

                            if (data.count > 0) {
                                [resultArray addObjectsFromArray:data];

                                //re-assign anchor
                                anchorString = results[@"anchor"];

                                // find very first and last, and save them
                                HKSample *firstFromFetched = [RCTAppleHealthKit firstByDateFromSamples:data];
                                [samplesFirstByDate addObject:firstFromFetched];

                                HKSample *lastFromFetched = [RCTAppleHealthKit lastByDateFromSamples:data];
                                [samplesLastByDate addObject:lastFromFetched];

                            } else {
                                hasResults = NO;
                            }
                            dispatch_semaphore_signal(semaphore);
                        } @catch (NSException *exception) {
                            hasResults = NO;
                            NSLog(@"RNHealth getMedianStatistic: An error occured");
                            dispatch_semaphore_signal(semaphore);
                        }
                    } else {
                        hasResults = NO;
                        NSLog(@"RNHealthgetMedianStatistic: An error occured");
                        dispatch_semaphore_signal(semaphore);
                    }
                }];

                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            };

            if (resultArray.count != 0) {

                NSMutableArray *intervalsInSecond = [NSMutableArray new];
                NSMutableArray *intervalsInDays = [NSMutableArray new];
                int i = 0;
                while (i < resultArray.count - 1)
                {
                    HKSample *first = resultArray[i];
                    HKSample *second = resultArray[i + 1];

                    NSDate *startInterval = second.startDate;
                    NSDate *endInterval = first.endDate;

                    // count median for array of interval in seconds
                    NSTimeInterval secondsBetween = fabs([endInterval timeIntervalSinceDate:startInterval]);
                    NSNumber *seconds = [NSNumber numberWithDouble:secondsBetween];
                    [intervalsInSecond addObject:seconds];

                    // count median for array of interval in days
                    NSNumber *days = [NSNumber numberWithInteger:[RCTAppleHealthKit daysFromSeconds:startInterval endDate:endInterval]];
                    [intervalsInDays addObject:days];

                    i++;
                };

                NSNumber *medianIntervalInSeconds = [RCTAppleHealthKit calculateMedian:intervalsInSecond];
                NSNumber *medianIntervalInDays = [RCTAppleHealthKit calculateMedian:intervalsInDays];

                HKSample *firstSample = [RCTAppleHealthKit firstByDateFromSamples:samplesFirstByDate];
                HKSample *lastSample = [RCTAppleHealthKit lastByDateFromSamples:samplesLastByDate];

                NSString *resultStartDateString = [RCTAppleHealthKit buildISO8601StringFromDate:firstSample.startDate];
                NSString *resultEndDateString = [RCTAppleHealthKit buildISO8601StringFromDate:lastSample.endDate];

                NSDictionary *response = @{
                    @"parameterName" : sampleName,
                    @"firstEntry" : resultStartDateString,
                    @"lastEntry" : resultEndDateString,
                    @"entryCount" : @(resultArray.count),
                    @"medianSeconds" : medianIntervalInSeconds,
                    @"medianDays" : medianIntervalInDays,
                };
                [output addObject:response];
            }

        }];
        [queue addOperation:operation];
        [doneOperation addDependency:operation];
    }

    [queue addOperation:doneOperation];

}

@end
