//
//  RCTAppleHealthKit+Queries.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Queries)


- (void)fetchMostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(HKQuantity *, NSDate *, NSDate *, NSError *))completion { NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType
                                                  predicate:predicate
                                                  limit:1
                                                  sortDescriptors:@[timeSortDescriptor]
                                                  resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                                                      if (!results) {
                                                          if (completion) {
                                                              completion(nil, nil, nil, error);
                                                          }
                                                          return;
                                                      }

                                                      if (completion) {
                                                          // If quantity isn't in the database, return nil in the completion block.
                                                          HKQuantitySample *quantitySample = results.firstObject;
                                                          HKQuantity *quantity = quantitySample.quantity;
                                                          NSDate *startDate = quantitySample.startDate;
                                                          NSDate *endDate = quantitySample.endDate;
                                                          completion(quantity, startDate, endDate, error);
                                                      }
                                                  }];

    [self.healthStore executeQuery:query];
}



- (void)fetchSumOfSamplesTodayForType:(HKQuantityType *)quantityType unit:(HKUnit *)unit completion:(void (^)(double, NSError *))completionHandler {
    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesToday];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType
                                                          quantitySamplePredicate:predicate
                                                          options:HKStatisticsOptionCumulativeSum
                                                          completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        HKQuantity *sum = [result sumQuantity];
        
        if (completionHandler) {
            double value = [sum doubleValueForUnit:unit];
            completionHandler(value, error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}



- (void)fetchSumOfSamplesOnDayForType:(HKQuantityType *)quantityType unit:(HKUnit *)unit day:(NSDate *)day completion:(void (^)(double, NSError *))completionHandler {
    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesOnDay:day];

    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType
                                                          quantitySamplePredicate:predicate
                                                          options:HKStatisticsOptionCumulativeSum
                                                          completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
                                                              HKQuantity *sum = [result sumQuantity];
                                                              if (completionHandler) {
                                                                     double value = [sum doubleValueForUnit:unit];
                                                                     completionHandler(value, error);
                                                              }
                                                          }];

    [self.healthStore executeQuery:query];
}



//- (void)fetchSumOfSamplesBetweenDatesForType:(HKQuantityType *)quantityType unit:(HKUnit *)unit startDate:(NSDate *)startDate endDate:(NSDate *)endDate completion:(void (^)(NSArray *, NSError *))completionHandler {
//    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
//
//    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType
//                                                       quantitySamplePredicate:predicate
//                                                                       options:HKStatisticsOptionCumulativeSum
//                                                             completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
//                                                                 HKQuantity *sum = [result sumQuantity];
//                                                                 if (completionHandler) {
//                                                                     double value = [sum doubleValueForUnit:unit];
//                                                                     completionHandler(value, error);
//                                                                 }
//                                                             }];
//
//    [self.healthStore executeQuery:query];
//}





- (void)fetchCumulativeSumStatisticsCollection:(HKQuantityType *)quantityType
                                          unit:(HKUnit *)unit
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                    completion:(void (^)(NSArray *, NSError *))completionHandler {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;

    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                     fromDate:[NSDate date]];
    anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
//    HKQuantityType *quantityType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

// Create the query
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
                                                                           quantitySamplePredicate:nil
                                                                                           options:HKStatisticsOptionCumulativeSum
                                                                                        anchorDate:anchorDate
                                                                                intervalComponents:interval];

// Set the results handler
    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
        if (error) {
            // Perform proper error handling here
            NSLog(@"*** An error occurred while calculating the statistics: %@ ***",error.localizedDescription);
        }

//        NSDate *endDate = [NSDate date];
//        NSDate *startDate = [calendar dateByAddingUnit:NSCalendarUnitDay
//                                                 value:-7
//                                                toDate:endDate
//                                               options:0];

        // Plot the daily step counts over the past 7 days

        NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *result, BOOL *stop) {

                                       HKQuantity *quantity = result.sumQuantity;
                                       if (quantity) {
                                           NSDate *date = result.startDate;
                                           double value = [quantity doubleValueForUnit:[HKUnit countUnit]];
                                           NSLog(@"%@: %f", date, value);

                                           NSString *dateString = [RCTAppleHealthKit buildISO8601StringFromDate:date];

                                           NSArray *elem = @[dateString, @(value)];

                                           [data addObject:elem];
                                       }

                                   }];

//        NSArray *arr = @[@"Mercedes-Benz", @"BMW", @"Porsche", @"Opel", @"Volkswagen", @"Audi"];
        NSError *err;
        completionHandler(data, err);

    };

    [self.healthStore executeQuery:query];
}







@end
