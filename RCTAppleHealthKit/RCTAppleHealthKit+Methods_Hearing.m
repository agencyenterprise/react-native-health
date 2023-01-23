//
//  RCTAppleHealthKit+Methods_Hearing.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Methods_Hearing.h"
#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+Queries.h"

@implementation RCTAppleHealthKit (Methods_Hearing)

- (void)hearing_getEnvironmentalAudioExposure:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
 {
     if (@available(iOS 13.0, *)) {
         HKQuantityType *environmentalAudioExposureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierEnvironmentalAudioExposure];
         HKUnit *unit = [HKUnit decibelAWeightedSoundPressureLevelUnit];
         NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
         BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
         NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
         NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
         if(startDate == nil){
             callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
             return;
         }
         NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

         [self fetchQuantitySamplesOfType:environmentalAudioExposureType
                                     unit:unit
                                predicate:predicate
                                ascending:ascending
                                    limit:limit
                               completion:^(NSArray *results, NSError *error) {
             if(results){
                 callback(@[[NSNull null], results]);
                 return;
             } else {
                 callback(@[RCTJSErrorFromNSError(error)]);
                 return;
             }
         }];
     } else {
         callback(@[RCTMakeError(@"EnvironmentalAudioExposure is not available for this iOS version", nil, nil)]);
     }
 }

- (void)hearing_getHeadphoneAudioExposure:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
 {
     if (@available(iOS 13.0, *)) {
         HKQuantityType *headphoneAudioExposure = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeadphoneAudioExposure];
         HKUnit *unit = [HKUnit decibelAWeightedSoundPressureLevelUnit];
         NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
         BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
         NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
         NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
         if(startDate == nil){
             callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
             return;
         }
         NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

         [self fetchQuantitySamplesOfType:headphoneAudioExposure
                                     unit:unit
                                predicate:predicate
                                ascending:ascending
                                    limit:limit
                               completion:^(NSArray *results, NSError *error) {
             if(results){
                 callback(@[[NSNull null], results]);
                 return;
             } else {
                 callback(@[RCTJSErrorFromNSError(error)]);
                 return;
             }
         }];
     } else {
         callback(@[RCTMakeError(@"HeadphoneAudioExposure is not available for this iOS version", nil, nil)]);
     }
 }

@end
