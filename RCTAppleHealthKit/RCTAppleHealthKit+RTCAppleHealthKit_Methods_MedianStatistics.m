//
//  RCTAppleHealthKit+RTCAppleHealthKit_Methods_MedianStatistics.m
//  RCTAppleHealthKit
//
//  Created by Anastasia Mishur on 14.03.23.
//  Copyright © 2023 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+RTCAppleHealthKit_Methods_MedianStatistics.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"
#import "RTCAppleHealthKit+Methods_Statistics.h"

#import <React/RCTLog.h>

@implementation RCTAppleHealthKit (RTCAppleHealthKit_Methods_MedianStatistics)

// MARK: - Public

- (void)statistics_getMedianStatistic:(NSArray *)input callback:(RCTResponseSenderBlock)callback {

    NSLog(@"Have input:", input.firstObject, input);


    //fake callback
    NSMutableArray* output = [NSMutableArray new];
    NSDictionary *response1 = @{
            @"parameter" : @"weight",
            @"firstEntry" : @"first date",
            @"lastEntry" : @"last date",
            @"entryCount" : @23,
            @"medianDays" : @4,
    };
    [output addObject:response1];

    NSDictionary *response2 = @{
            @"parameter" : @"height",
            @"firstEntry" : @"first date",
            @"lastEntry" : @"last date",
            @"entryCount" : @15,
            @"medianDays" : @2,
    };
    [output addObject:response2];

    callback(@[[NSNull null], output]);

}

@end
