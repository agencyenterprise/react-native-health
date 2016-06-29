//
//  RCTAppleHealthKit+Utils.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Utils)

+ (NSDate *)parseISO8601DateFromString:(NSString *)date;
+ (NSString *)buildISO8601StringFromDate:(NSDate *)date;
+ (NSPredicate *)predicateForSamplesToday;
+ (NSPredicate *)predicateForSamplesOnDay:(NSDate *)date;
+ (NSPredicate *)predicateForSamplesBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (NSPredicate *)predicateForSamplesOnDayFromTimestamp:(NSString *)timestamp;
+ (double)doubleValueFromOptions:(NSDictionary *)options;
+ (NSDate *)dateFromOptions:(NSDictionary *)options;
+ (NSDate *)dateFromOptionsDefaultNow:(NSDictionary *)options;
+ (NSDate *)startDateFromOptions:(NSDictionary *)options;
+ (NSDate *)endDateFromOptions:(NSDictionary *)options;
+ (NSDate *)endDateFromOptionsDefaultNow:(NSDictionary *)options;
+ (HKUnit *)hkUnitFromOptions:(NSDictionary *)options;

@end
