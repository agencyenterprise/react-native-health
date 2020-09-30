//
//  RCTAppleHealthKit+Methods_Workout.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Workout.h"
#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+Queries.h"

@implementation RCTAppleHealthKit (Methods_Workout)

- (void)workout_get:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:[NSDate date]];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];

    void (^completion)(NSArray *results, NSError *error);

    completion = ^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSString *errMsg = [NSString stringWithFormat:@"Error getting samples: %@", error];
            NSLog(errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
            return;
        }
    };

    [self fetchWorkoutForPredicate: predicate
                         ascending:ascending
                             limit:limit
                        completion:completion];
}

-(void)workout_save: (NSDictionary *)input callback: (RCTResponseSenderBlock)callback {
    HKWorkoutActivityType type = [RCTAppleHealthKit hkWorkoutActivityTypeFromOptions:input key:@"type" withDefault:HKWorkoutActivityTypeAmericanFootball];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:nil];
    NSTimeInterval duration = [RCTAppleHealthKit doubleFromOptions:input key:@"duration" withDefault:(NSTimeInterval)0];
    HKQuantity *totalEnergyBurned = [RCTAppleHealthKit hkQuantityFromOptions:input valueKey:@"energyBurned" unitKey:@"energyBurnedUnit"];
    HKQuantity *totalDistance = [RCTAppleHealthKit hkQuantityFromOptions:input valueKey:@"distance" unitKey:@"distanceUnit"];


    HKWorkout *workout = [
                          HKWorkout workoutWithActivityType:type startDate:startDate endDate:endDate workoutEvents:nil totalEnergyBurned:totalEnergyBurned totalDistance:totalDistance metadata: nil
                          ];

    void (^completion)(BOOL success, NSError *error);

    completion = ^(BOOL success, NSError *error){
        if(!success) {

            NSLog(@"An error occured saving the workout %@. The error was: %@.", workout, error);
            callback(@[RCTMakeError(@"An error occured saving the workout", error, nil)]);
            return;
        }
        callback(@[[NSNull null], [[workout UUID] UUIDString]]);
    };

    [self.healthStore saveObject:workout withCompletion:completion];

}
@end
