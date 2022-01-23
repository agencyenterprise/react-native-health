//
//  RCTAppleHealthKit+Methods_Workout.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Summary.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"
#import <React/RCTLog.h>

@implementation RCTAppleHealthKit (Summary)

-(void)summary_getActivitySummary:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    void (^completion)(NSArray *results, NSError *error);

    completion = ^(NSArray *results, NSError *error) {
        if (results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting summary: %@", error);
            callback(@[RCTMakeError(@"error getting summary", error, nil)]);
            return;
        }
    };

    [self fetchActivitySummary:startDate endDate:endDate completion:completion];
}

@end
