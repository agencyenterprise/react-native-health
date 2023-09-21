//
//  RCTAppleHealthKit+Utils.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"
#import "RCTTypes.h"

extern NSString * const kMetadataKey;
extern NSString * const kTypesKey;

@interface RCTAppleHealthKit (Utils)

+ (NSDate *)parseISO8601DateFromString:(NSString *)date;
+ (NSString *)buildISO8601StringFromDate:(NSDate *)date;
+ (NSString *)buildStringFromDateForStatistics:(NSDate *)date;
+ (NSPredicate *)predicateForSamplesToday;
+ (NSPredicate *)predicateForSamplesOnDay:(NSDate *)date;
+ (NSPredicate *)predicateForSamplesBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (NSPredicate *)predicateForSamplesOnDayFromTimestamp:(NSString *)timestamp;
+ (NSPredicate *)predicateForAnchoredQueries:(HKQueryAnchor *)anchor startDate:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (NSPredicate *)predicateForStatisticsBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate;
+ (double)doubleValueFromOptions:(NSDictionary *)options;
+ (NSDate *)dateFromOptions:(NSDictionary *)options;
+ (NSDate *)dateFromOptionsDefaultNow:(NSDictionary *)options;
+ (NSDate *)startDateFromOptions:(NSDictionary *)options;
+ (NSDate *)endDateFromOptions:(NSDictionary *)options;
+ (NSDate *)endDateFromOptionsDefaultNow:(NSDictionary *)options;
+ (RCTStatisticRequest *)statisticRequestFromOptions:(NSDictionary *)options quantity: (HKQuantityTypeIdentifier) quantity defaultUnit: (HKUnit*) defaultUnit;
+ (HKSampleType *)quantityTypeFromName:(NSString *)type;
+ (nullable HKSampleType *)clinicalTypeFromName:(NSString *)type;
+ (HKQueryAnchor *)hkAnchorFromOptions:(NSDictionary *)options;
+ (HKUnit *)hkUnitFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(HKUnit *)defaultValue;
+ (NSUInteger)uintFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSUInteger)defaultValue;
+ (double)doubleFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(double)defaultValue;
+ (NSDate *)dateFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSDate *)defaultValue;
+ (NSString *)stringFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSString *)defaultValue;
+ (bool)boolFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(bool)defaultValue;
+ (HKWorkoutActivityType)hkWorkoutActivityTypeFromOptions: (NSDictionary *)options key: (NSString *)key withDefault: (HKWorkoutActivityType)defaultValue;
+ (HKQuantity *)hkQuantityFromOptions:(NSDictionary *)options valueKey: (NSString *)valueKey unitKey: (NSString *)unitKey;
+ (NSDictionary *)metadataFromOptions:(NSDictionary *)options withDefault:(NSDictionary *)defaultValue;
+ (NSArray *)typesFromOptions:(NSDictionary *)options;

+ (NSArray *)formatWorkoutEvents:(NSArray *)workoutEvents;
+ (NSMutableArray *)reverseNSMutableArray:(NSMutableArray *)array;
+ (NSString *) stringForHKWorkoutActivityType:(int) enumValue;
+ (NSString *) md5HashString:(NSString *) input;
+ (NSString *) stringFromObject:(NSObject *)obj;
+ (NSString *) formattingStringHash:(NSString *)input;
+ (NSNumber *) calculateMedian:(NSArray *)input;
+ (NSInteger) daysFromSeconds:(NSDate *)startDate endDate: (NSDate *)endDate;
+ (HKSample *) firstByDateFromSamples:(NSArray<__kindof HKSample *>*)input;
+ (HKSample *) lastByDateFromSamples:(NSArray<__kindof HKSample *>*)input;

@end
