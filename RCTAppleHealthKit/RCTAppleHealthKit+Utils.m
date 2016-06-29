//
//  RCTAppleHealthKit+Utils.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Utils)

#pragma mark - Utilities

+ (NSDate *)parseISO8601DateFromString:(NSString *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.locale = posix;
//    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
    return [dateFormatter dateFromString:date];
}

+ (NSString *)buildISO8601StringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.locale = posix;
//    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
    return [dateFormatter stringFromDate:date];
}

+ (NSPredicate *)predicateForSamplesToday {
    NSDate *now = [NSDate date];
    return [RCTAppleHealthKit predicateForSamplesOnDay:now];
}

+ (NSPredicate *)predicateForSamplesOnDayFromTimestamp:(NSString *)timestamp {
    NSDate *day = [RCTAppleHealthKit parseISO8601DateFromString:timestamp];
    return [RCTAppleHealthKit predicateForSamplesOnDay:day];
}

+ (NSPredicate *)predicateForSamplesOnDay:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *startDate = [calendar startOfDayForDate:date];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}

+ (NSPredicate *)predicateForSamplesBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *start = [calendar startOfDayForDate:startDate];
    NSDate *end = endDate;
//    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}




+ (double)doubleValueFromOptions:(NSDictionary *)options {
    double value = [[options objectForKey:@"value"] doubleValue];
    return value;
}


+ (NSDate *)dateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"date"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    }
    return date;
}

+ (NSDate *)dateFromOptionsDefaultNow:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"date"];
    if(dateString != nil){
        NSDate *date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        if(date == nil){
            // probably not a good idea... should return an error or just the null pointer
            date = [NSDate date];
        }
        return date;
    }
    NSDate *now = [NSDate date];
    return now;
}


//TODO: make a generic function that can return NSDate by key... have 'default now' as option


+ (NSDate *)startDateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"startDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        return date;
    }
    return date;
}

+ (NSDate *)endDateFromOptions:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"endDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    }
    return date;
}

+ (NSDate *)endDateFromOptionsDefaultNow:(NSDictionary *)options {
    NSString *dateString = [options objectForKey:@"endDate"];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
        return date;
    }
    if(date == nil){
        date = [NSDate date];
    }
    return date;
}



+ (HKUnit *)hkUnitFromOptions:(NSDictionary *)options {
    NSString *unitString = [options objectForKey:@"unit"];
    HKUnit *theUnit;

    if([unitString isEqualToString:@"gram"]){
        theUnit = [HKUnit gramUnit];
    }
    if([unitString isEqualToString:@"pound"]){
        theUnit = [HKUnit poundUnit];
    }
    if([unitString isEqualToString:@"meter"]){
        theUnit = [HKUnit meterUnit];
    }
    if([unitString isEqualToString:@"inch"]){
        theUnit = [HKUnit inchUnit];
    }
    if([unitString isEqualToString:@"foot"]){
        theUnit = [HKUnit footUnit];
    }
    if([unitString isEqualToString:@"second"]){
        theUnit = [HKUnit secondUnit];
    }
    if([unitString isEqualToString:@"minute"]){
        theUnit = [HKUnit minuteUnit];
    }
    if([unitString isEqualToString:@"hour"]){
        theUnit = [HKUnit hourUnit];
    }
    if([unitString isEqualToString:@"day"]){
        theUnit = [HKUnit dayUnit];
    }
    if([unitString isEqualToString:@"joule"]){
        theUnit = [HKUnit jouleUnit];
    }
    if([unitString isEqualToString:@"calorie"]){
        theUnit = [HKUnit calorieUnit];
    }
    if([unitString isEqualToString:@"count"]){
        theUnit = [HKUnit countUnit];
    }
    if([unitString isEqualToString:@"percent"]){
        theUnit = [HKUnit percentUnit];
    }
    return theUnit;
}




@end
