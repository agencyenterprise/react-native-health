//
// Created by Alex.M on 11.11.2021.
// Copyright (c) 2021 Greg Wilson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RCTAggregatorTypeMin,
    RCTAggregatorTypeMax,
    RCTAggregatorTypeAverage,
    RTCAggregatorCumulativeSum,
    RCTAggregatorTypeFirst,
    RCTAggregatorTypeLast
} RCTAggregatorType;
