//
//  RCTAppleHealthKit+Methods_MedianStatistics.h
//  RCTAppleHealthKit
//
//  Created by Anastasia Mishur on 14.03.23.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_MedianStatistics)

- (void)statistics_getMedianStatistic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
