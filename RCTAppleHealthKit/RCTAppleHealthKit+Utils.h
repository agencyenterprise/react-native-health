//
//  RCTAppleHealthKit+Utils.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Utils)

+ (HKSampleType *)quantityTypeFromName:(NSString *)type;
+ (HKQueryAnchor *)hkAnchorFromOptions:(NSDictionary *)options;
+ (HKUnit *)hkUnitFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(HKUnit *)defaultValue;
+ (NSUInteger)uintFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSUInteger)defaultValue;
+ (double)doubleFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(double)defaultValue;
+ (NSDate *)dateFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSDate *)defaultValue;
+ (NSString *)stringFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSString *)defaultValue;
+ (bool)boolFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(bool)defaultValue;
+ (HKWorkoutActivityType)hkWorkoutActivityTypeFromOptions: (NSDictionary *)options key: (NSString *)key withDefault: (HKWorkoutActivityType)defaultValue;
+ (HKQuantity *)hkQuantityFromOptions:(NSDictionary *)options valueKey: (NSString *)valueKey unitKey: (NSString *)unitKey;

+ (NSMutableArray *)reverseNSMutableArray:(NSMutableArray *)array;
+ (NSString*) stringForHKWorkoutActivityType:(int) enumValue;

@end
