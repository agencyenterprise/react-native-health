//
// Created by Alex.M on 11.11.2021.
// Copyright (c) 2021 Greg Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import "RCTTypes.h"

@interface RCTStatisticRequest : NSObject

@property HKQuantityType *quantityType;
@property HKQuantityTypeIdentifier quantity;
@property HKUnit *unit;
@property NSDate *startDate;
@property NSDate *endDate;
@property RCTInterval intervalType;
@property RCTAggregatorType aggregatorType;

- (instancetype)initWithQuantityType:(HKQuantityType *)quantityType
                            quantity:(HKQuantityTypeIdentifier) quantity
                                unit:(HKUnit *)unit
                           startDate:(NSDate *)startDate
                             endDate:(NSDate *)endDate
                        intervalType:(RCTInterval)intervalType
                      aggregatorType:(RCTAggregatorType)aggregatorType;

+ (instancetype)requestWithQuantityType:(HKQuantityType *)quantityType
                               quantity:(HKQuantityTypeIdentifier) quantity
                                   unit:(HKUnit *)unit
                              startDate:(NSDate *)startDate
                                endDate:(NSDate *)endDate
                           intervalType:(RCTInterval)intervalType
                         aggregatorType:(RCTAggregatorType)aggregatorType;

- (NSDateComponents*) interval;
- (HKStatisticsOptions) statisticsOptions;

- (HKQuantity *)fetchValue: (HKStatistics *)statistics;
- (NSString *)makeStringWithPrefix: (NSString *)string;

@end