//
//  RCTAppleHealthKit+Queries.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Queries.h"

@implementation RCTAppleHealthKit (Queries)


- (void)fetchMostRecentQuantitySampleOfType:(HKQuantityType *)quantityType predicate:(NSPredicate *)predicate completion:(void (^)(HKQuantity *, NSError *))completion { NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:NO];
    
    // Since we are interested in retrieving the user's latest sample, we sort the samples in descending order, and set the limit to 1. We are not filtering the data, and so the predicate is set to nil.
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType
                                                           predicate:predicate
                                                               limit:1
                                                     sortDescriptors:@[timeSortDescriptor]
                                                      resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                                                          if (!results) {
                                                              if (completion) {
                                                                  completion(nil, error);
                                                              }
                                                              
                                                              return;
                                                          }
                                                          
                                                          if (completion) {
                                                              // If quantity isn't in the database, return nil in the completion block.
                                                              HKQuantitySample *quantitySample = results.firstObject;
                                                              HKQuantity *quantity = quantitySample.quantity;
                                                              
                                                              completion(quantity, error);
                                                          }
                                                      }];
    
    [self.healthStore executeQuery:query];
}



- (void)fetchSumOfSamplesTodayForType:(HKQuantityType *)quantityType unit:(HKUnit *)unit completion:(void (^)(double, NSError *))completionHandler {
    NSPredicate *predicate = [self predicateForSamplesToday];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        HKQuantity *sum = [result sumQuantity];
        
        if (completionHandler) {
            double value = [sum doubleValueForUnit:unit];
            
            completionHandler(value, error);
        }
    }];
    
    [self.healthStore executeQuery:query];
}




#pragma mark - Convenience

- (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *now = [NSDate date];
    
    NSDate *startDate = [calendar startOfDayForDate:now];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}



@end
