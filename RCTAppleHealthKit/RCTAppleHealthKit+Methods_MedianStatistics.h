//
//  RCTAppleHealthKit+Methods_MedianStatistics.h
//  RCTAppleHealthKit
//
//  Created by Anastasia Mishur on 14.03.23.
//  Copyright © 2023 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_MedianStatistics)

- (void)statistics_getMedianStatistic:(NSArray *)input callback:(RCTResponseSenderBlock)callback;

@end
