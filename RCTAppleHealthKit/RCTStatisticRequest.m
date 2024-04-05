//
// Created by Alex.M on 11.11.2021.
// Copyright (c) 2021 Greg Wilson. All rights reserved.
//

#import "RCTStatisticRequest.h"


@implementation RCTStatisticRequest {
}

- (instancetype)initWithQuantityType:(HKQuantityType *)quantityType
                            quantity:(HKQuantityTypeIdentifier) quantity
                                unit:(HKUnit *)unit
                           startDate:(NSDate *)startDate
                             endDate:(NSDate *)endDate
                        intervalType:(RCTInterval)intervalType
                      aggregatorType:(RCTAggregatorType)aggregatorType {
    self = [super init];
    if (self) {
        self.quantityType = quantityType;
        self.quantity = quantity;
        self.unit = unit;
        self.startDate = startDate;
        self.endDate = endDate;
        self.intervalType = intervalType;
        self.aggregatorType = aggregatorType;
    }

    return self;
}

+ (instancetype)requestWithQuantityType:(HKQuantityType *)quantityType
                               quantity:(HKQuantityTypeIdentifier) quantity
                                   unit:(HKUnit *)unit
                              startDate:(NSDate *)startDate
                                endDate:(NSDate *)endDate
                           intervalType:(RCTInterval)intervalType
                         aggregatorType:(RCTAggregatorType)aggregatorType {
    return [[self alloc] initWithQuantityType:quantityType
                                     quantity: quantity
                                         unit:unit
                                    startDate:startDate
                                      endDate:endDate
                                 intervalType:intervalType
                               aggregatorType:aggregatorType];
}

- (NSDateComponents *)interval {
    NSDateComponents *result = [[NSDateComponents alloc] init];
    switch (_intervalType) {
        case RCTIntervalMonth: {
            result.month = 1;
            break;
        }
        case RCTIntervalDay: {
            result.day = 1;
            break;
        }
    }
    return result;
}

- (HKStatisticsOptions)statisticsOptions {
    switch (_aggregatorType) {
        case RCTAggregatorTypeMin: {
            return HKStatisticsOptionDiscreteMin;
        }
        case RCTAggregatorTypeMax: {
            return HKStatisticsOptionDiscreteMax;
        }
        case RCTAggregatorTypeAverage: {
            return HKStatisticsOptionDiscreteAverage;
        }
        case RCTAggregatorTypeFirst: {
            return HKStatisticsOptionDiscreteMin;
        }
        case RCTAggregatorTypeLast: {
            return HKStatisticsOptionDiscreteMin;
        }
        case RTCAggregatorCumulativeSum: {
            return HKStatisticsOptionCumulativeSum;
        }
        default: {
            return nil;
        }
    }
}

- (HKQuantity *)fetchValue:(HKStatistics *)statistics {
    switch (_aggregatorType) {
        case RCTAggregatorTypeMin: {
            return statistics.minimumQuantity;
        }
        case RCTAggregatorTypeMax: {
            return statistics.maximumQuantity;
        }
        case RCTAggregatorTypeAverage: {
            return statistics.averageQuantity;
        }
        case RCTAggregatorTypeFirst: {
            return nil;
        }
        case RCTAggregatorTypeLast: {
            return nil;
        }
        case RTCAggregatorCumulativeSum: {
            return statistics.sumQuantity;
        }
        default: {
            return nil;
        }
    }
}

- (NSString *)makeStringWithPrefix:(NSString *)string {
    return [[NSString alloc] initWithFormat:@"%@:%@:%@", _quantity, [self aggregatorName], string];
}

- (NSString *) aggregatorName {
    switch (_aggregatorType) {
        case RCTAggregatorTypeMin: {
            return @"min";
        }
        case RCTAggregatorTypeMax: {
            return @"max";
        }
        case RCTAggregatorTypeAverage: {
            return @"average";
        }
        case RCTAggregatorTypeFirst: {
            return @"first";
        }
        case RCTAggregatorTypeLast: {
            return @"last";
        }
        case RTCAggregatorCumulativeSum: {
            return @"sum";
        }
        default: {
            return nil;
        }
    }
}

@end