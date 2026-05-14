//
//  RCTAppleHealthKit+Utils.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"

NSString * const kMetadataKey = @"metadata";

@implementation RCTAppleHealthKit (Utils)

#pragma mark - Utilities

+ (NSArray *)formatWorkoutEvents:(NSArray *)workoutEvents
{
    NSMutableArray *formattedWorkEvents = [[NSMutableArray alloc] init];
    
    for (id workoutEvent in workoutEvents) {
        NSNumber *eventType = [workoutEvent valueForKey:@"type"];
        NSString *eventDescription = @"";
        
        switch([eventType intValue]) {
            case (int)HKWorkoutEventTypePause:
                eventDescription = @"pause";
                break;
            case (int)HKWorkoutEventTypeResume:
                eventDescription = @"resume";
                break;
            case (int)HKWorkoutEventTypeMotionPaused:
                eventDescription = @"motion paused";
                break;
            case (int)HKWorkoutEventTypeMotionResumed:
                eventDescription = @"motion resumed";
                break;
            case (int)HKWorkoutEventTypePauseOrResumeRequest:
                eventDescription = @"pause or resume request";
                break;
            case (int)HKWorkoutEventTypeLap:
                eventDescription = @"lap";
                break;
            case (int)HKWorkoutEventTypeSegment:
                eventDescription = @"segment";
                break;
            case (int)HKWorkoutEventTypeMarker:
                eventDescription = @"marker";
            default:
                eventDescription = @"";
        }
        
        
        NSObject *formattedEvent = @{
            @"eventTypeInt":eventType,
            @"eventType": eventDescription,
            @"startDate": [RCTAppleHealthKit buildISO8601StringFromDate:[[workoutEvent dateInterval] startDate]],
            @"endDate": [RCTAppleHealthKit buildISO8601StringFromDate:[[workoutEvent dateInterval] endDate]]
        };
        [formattedWorkEvents addObject: formattedEvent];
    }
    
    return formattedWorkEvents;
}

+ (NSDate *)parseISO8601DateFromString:(NSString *)date
{
    @try {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.locale = posix;
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
        return [dateFormatter dateFromString:date];
    } @catch (NSException *exception) {
        NSLog(@"RNHealth: An error occured while trying parse ISO8601 date from string");
        return nil;
    }
}


+ (NSString *)buildISO8601StringFromDate:(NSDate *)date
{
    @try {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        NSLocale *posix = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.locale = posix;
        dateFormatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ";
        return [dateFormatter stringFromDate:date];
    } @catch (NSException *exception) {
        NSLog(@"RNHealth: An error occured while trying parse ISO8601 string from date");
        return nil;
    }   
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
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}

+ (NSPredicate *)predicateForAnchoredQueries:(HKQueryAnchor *)anchor startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    if (startDate == nil) {
        return nil;
    } else {
        return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
    }

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

/*!
    Convert Human Readable name for a HealthKit data type into a HKObjectType format

    @param type The human readable format (e.g., 'HeartRate', 'StepCount', 'Workout')
    @return HKSampleType for standard quantity types, or nil if type is unsupported or clinical.
            Note: Clinical types (AllergyRecord, ConditionRecord, etc.) are NOT supported
            by this method and must be handled via clinicalTypeFromName instead.
 */
+ (HKSampleType *)quantityTypeFromName:(NSString *)type {
    if ([type isEqual:@"ActiveEnergyBurned"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    } else if ([type isEqual:@"BasalEnergyBurned"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    } else if ([type isEqual:@"Cycling"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    } else if ([type isEqual:@"HeartRate"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    } else if ([type isEqual:@"HeartRateVariabilitySDNN"] || [type isEqual:@"HeartRateVariability"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateVariabilitySDNN];
    } else if ([type isEqual:@"RestingHeartRate"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
    } else if ([type isEqual:@"Running"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    } else if ([type isEqual:@"StairClimbing"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    } else if ([type isEqual:@"StepCount"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([type isEqual:@"Swimming"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
    } else if ([type isEqual:@"Vo2Max"]){
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];
    } else if ([type isEqual:@"Walking"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([type isEqual:@"Workout"]) {
        return [HKObjectType workoutType];
    } else if ([type isEqual:@"DietaryCholesterol"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol];
    } else if ([type isEqual:@"InsulinDelivery"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];
    } else if ([type isEqual:@"BodyMass"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if ([type isEqual:@"BodyMassIndex"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    } else if ([type isEqual:@"Height"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    } else if ([type isEqual:@"BodyFatPercentage"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    } else if ([type isEqual:@"OxygenSaturation"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    } else if ([type isEqual:@"RespiratoryRate"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];
    } else if ([type isEqual:@"BodyTemperature"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    } else if ([type isEqual:@"BloodGlucose"]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    }

    return nil;
}

+ (HKSampleType *)clinicalTypeFromName:(NSString *)type {
    if (@available(iOS 12.0, *)) {
        if ([type isEqual:@"AllergyRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierAllergyRecord];
        } else if ([type isEqual:@"ConditionRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierConditionRecord];
        } else if ([type isEqual:@"ImmunizationRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierImmunizationRecord];
        } else if ([type isEqual:@"LabResultRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierLabResultRecord];
        } else if ([type isEqual:@"MedicationRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierMedicationRecord];
        } else if ([type isEqual:@"ProcedureRecord"]){
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierProcedureRecord];
        } else if ([type isEqual:@"VitalSignRecord"]) {
            return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierVitalSignRecord];
        }
    }
    
    if (@available(iOS 14.0, *)) {
         if ([type isEqual:@"CoverageRecord"]){
             return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierCoverageRecord];
         }
    }
    
    return nil;
}

+ (HKQueryAnchor *)hkAnchorFromOptions:(NSDictionary *)options {
    NSString *anchorString = [options objectForKey:@"anchor"];
    if (!anchorString.length) return nil;
    NSData* anchorData = [[NSData alloc] initWithBase64EncodedString:anchorString options:0];
    NSError *unarchiveError = nil;
    HKQueryAnchor *anchor = [NSKeyedUnarchiver unarchivedObjectOfClass:[HKQueryAnchor class] fromData:anchorData error:&unarchiveError];
    if (unarchiveError) {
        NSLog(@"RNHealth: Failed to unarchive anchor: %@", unarchiveError);
    }
    if(anchor == nil){
        return nil;
    }
    return anchor;
}


+ (HKUnit *)defaultHKUnitForType:(NSString *)type {
    if ([@[@"HeartRate", @"RestingHeartRate", @"WalkingHeartRateAverage"] containsObject:type]) {
        return [HKUnit unitFromString:@"count/min"];
    }
    if ([@[@"HeartRateVariabilitySDNN", @"HeartRateVariability"] containsObject:type]) {
        return [HKUnit secondUnitWithMetricPrefix:HKMetricPrefixMilli];
    }
    if ([@[@"ActiveEnergyBurned", @"BasalEnergyBurned"] containsObject:type]) {
        return [HKUnit kilocalorieUnit];
    }
    if ([@[@"Running", @"Cycling", @"Swimming"] containsObject:type]) {
        return [HKUnit meterUnit];
    }
    if ([@[@"Vo2Max"] containsObject:type]) {
        return [HKUnit unitFromString:@"ml/(kg*min)"];
    }
    if ([@[@"StepCount", @"FlightsClimbed", @"PushCount", @"Walking"] containsObject:type]) {
        return [HKUnit countUnit];
    }
    if ([@[@"BodyMass", @"LeanBodyMass"] containsObject:type]) {
        return [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    }
    if ([@[@"Height"] containsObject:type]) {
        return [HKUnit meterUnit];
    }
    if ([@[@"BodyTemperature", @"BasalBodyTemperature"] containsObject:type]) {
        return [HKUnit degreeCelsiusUnit];
    }
    if ([@[@"BloodGlucose"] containsObject:type]) {
        return [HKUnit unitFromString:@"mg/dL"];
    }
    if ([@[@"BloodPressureSystolic", @"BloodPressureDiastolic"] containsObject:type]) {
        return [HKUnit millimeterOfMercuryUnit];
    }
    if ([@[@"RespiratoryRate"] containsObject:type]) {
        return [HKUnit unitFromString:@"count/min"];
    }
    if ([@[@"OxygenSaturation", @"BodyFatPercentage"] containsObject:type]) {
        return [HKUnit percentUnit];
    }
    // DietaryWater uses literUnit; not included in dietary array below
    if ([@[@"DietaryWater"] containsObject:type]) {
        return [HKUnit literUnit];
    }
    if ([type isEqual:@"DietaryEnergyConsumed"]) {
        return [HKUnit kilocalorieUnit];
    }
    if ([type isEqual:@"DietaryCholesterol"]) {
        return [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixMilli];
    }
    if ([@[@"DietaryProtein", @"DietaryFatTotal",
            @"DietaryCarbohydrates", @"DietaryFiber", @"DietarySodium",
            @"DietaryCalcium", @"DietaryIron", @"DietaryPotassium",
            @"DietaryVitaminC", @"DietaryVitaminD"] containsObject:type]) {
        return [HKUnit gramUnit];
    }
    if ([type isEqual:@"InsulinDelivery"]) {
        return [HKUnit internationalUnit];
    }
    return [HKUnit countUnit];
}

+ (NSString *)normalizeUnitString:(NSString *)unitString {
    if ([unitString isEqualToString:@"mL/(kg·min)"] ||
        [unitString isEqualToString:@"ml/(kg*min)"]) {
        return @"ml/kg/min";
    }
    return unitString;
}

+ (HKUnit *)hkUnitFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(HKUnit *)defaultValue {
    NSString *unitString = [options objectForKey:key];
    HKUnit *theUnit;

    if ([unitString isEqualToString:@"gram"]) {
         theUnit = [HKUnit gramUnit];
    } else if ([unitString isEqualToString:@"kg"]) {
         theUnit = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    } else if ([unitString isEqualToString:@"stone"]) {
         theUnit = [HKUnit stoneUnit];
    } else if ([unitString isEqualToString:@"pound"]) {
         theUnit = [HKUnit poundUnit];
    } else if ([unitString isEqualToString:@"meter"]) {
         theUnit = [HKUnit meterUnit];
    } else if ([unitString isEqualToString:@"cm"]) {
         theUnit = [HKUnit meterUnitWithMetricPrefix:HKMetricPrefixCenti];
    } else if ([unitString isEqualToString:@"inch"]) {
         theUnit = [HKUnit inchUnit];
    } else if ([unitString isEqualToString:@"mile"]) {
         theUnit = [HKUnit mileUnit];
    } else if ([unitString isEqualToString:@"foot"]) {
         theUnit = [HKUnit footUnit];
    } else if ([unitString isEqualToString:@"second"]) {
         theUnit = [HKUnit secondUnit];
    } else if ([unitString isEqualToString:@"minute"]) {
         theUnit = [HKUnit minuteUnit];
    } else if ([unitString isEqualToString:@"hour"]) {
         theUnit = [HKUnit hourUnit];
    } else if ([unitString isEqualToString:@"day"]) {
         theUnit = [HKUnit dayUnit];
    } else if ([unitString isEqualToString:@"joule"]) {
         theUnit = [HKUnit jouleUnit];
    } else if ([unitString isEqualToString:@"calorie"]) {
         theUnit = [HKUnit calorieUnit];
    } else if ([unitString isEqualToString:@"count"]) {
         theUnit = [HKUnit countUnit];
    } else if ([unitString isEqualToString:@"percent"]) {
         theUnit = [HKUnit percentUnit];
    } else if ([unitString isEqualToString:@"bpm"]) {
         HKUnit *count = [HKUnit countUnit];
         HKUnit *minute = [HKUnit minuteUnit];
         theUnit = [count unitDividedByUnit:minute];
    } else if ([unitString isEqualToString:@"fahrenheit"]) {
         theUnit = [HKUnit degreeFahrenheitUnit];
    } else if ([unitString isEqualToString:@"celsius"]) {
         theUnit = [HKUnit degreeCelsiusUnit];
    } else if ([unitString isEqualToString:@"mmhg"]) {
         theUnit = [HKUnit millimeterOfMercuryUnit];
    } else if ([unitString isEqualToString:@"mmolPerL"]) {
         theUnit = [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]];
    } else if ([unitString isEqualToString:@"literPerMinute"]) {
         theUnit = [[HKUnit literUnit] unitDividedByUnit:[HKUnit minuteUnit]];
    } else if ([unitString isEqualToString:@"mgPerdL"]) {
         theUnit = [HKUnit unitFromString:@"mg/dL"];
    } else if ([unitString isEqualToString:@"ml/kg/min"] || [unitString isEqualToString:@"mlPerKgMin"]) {
        // "ml/kg/min" is the canonical form; "mlPerKgMin" kept for existing callers
        HKUnit *ml = [HKUnit literUnitWithMetricPrefix:HKMetricPrefixMilli];
        HKUnit *kg = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
        HKUnit *min = [HKUnit minuteUnit];
        theUnit = [ml unitDividedByUnit:[kg unitMultipliedByUnit:min]];
    }

    if(theUnit == nil){
        theUnit = defaultValue;
    }

    return theUnit;
}


+ (NSUInteger)uintFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSUInteger)defaultValue {
    NSUInteger val;
    NSNumber *num = [options objectForKey:key];
    if(num != nil){
        val = [num unsignedIntValue];
    } else {
        val = defaultValue;
    }
    return val;
}


+ (double)doubleFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(double)defaultValue {
    double val;
    NSNumber *num = [options objectForKey:key];
    if(num != nil){
        val = [num doubleValue];
    } else {
        val = defaultValue;
    }
    return val;
}


+ (NSDate *)dateFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSDate *)defaultValue {
    NSString *dateString = [options objectForKey:key];
    NSDate *date;
    if(dateString != nil){
        date = [RCTAppleHealthKit parseISO8601DateFromString:dateString];
    } else {
        date = defaultValue;
    }
    return date;
}


+ (NSString *)stringFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(NSString *)defaultValue {
    NSString *str = [options objectForKey:key];
    if(str == nil){
        str = defaultValue;
    }
    return str;
}


+ (bool)boolFromOptions:(NSDictionary *)options key:(NSString *)key withDefault:(bool)defaultValue {
    NSNumber *num = [options objectForKey:key];
    if(num == nil){
        return defaultValue;
    }
    return [num boolValue];
}

+ (NSDictionary *)metadataFromOptions:(NSDictionary *)options withDefault:(NSDictionary *)defaultValue {
    NSDictionary *metadata = [options objectForKey:kMetadataKey];
    if(metadata == nil){
        return defaultValue;
    }
    return metadata;
}

+ (NSMutableArray *)reverseNSMutableArray:(NSMutableArray *)array {
    if ([array count] <= 1)
        return array;
    NSUInteger i = 0;
    NSUInteger j = [array count] - 1;
    while (i < j) {
        [array exchangeObjectAtIndex:i
                  withObjectAtIndex:j];
        i++;
        j--;
    }
    return array;
}

+ (HKWorkoutActivityType)hkWorkoutActivityTypeFromOptions: (NSDictionary *)options key: (NSString *)key withDefault: (HKWorkoutActivityType)defaultValue {
    NSDictionary * stringToWorkoutActivityType = [RCTAppleHealthKit getStringToWorkoutActivityTypeDictionary];
    HKWorkoutActivityType activityType = defaultValue;

    if([options objectForKey:key] && [stringToWorkoutActivityType objectForKey:[options valueForKey:key]]) {
        NSString * activityString = [options valueForKey:key];
        activityType = [(NSNumber *)[stringToWorkoutActivityType objectForKey:activityString] integerValue];
    }
    return activityType;
}

+ (HKQuantity *)hkQuantityFromOptions:(NSDictionary *)options valueKey: (NSString *)valueKey unitKey: (NSString *)unitKey {
    const int outOfBoundValue = -1;
    double value = [RCTAppleHealthKit doubleFromOptions:options key:valueKey withDefault:outOfBoundValue];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:options key:unitKey withDefault:nil];

    if(unit != nil && value >= 0) {
        return [HKQuantity quantityWithUnit:unit doubleValue:value];
    }
    return nil;
}

+ (NSString*)stringForHKWorkoutActivityType:(int) enumValue{
    switch( enumValue ){
        case HKWorkoutActivityTypeAmericanFootball:
            return @"AmericanFootball";
        case HKWorkoutActivityTypeArchery:
            return @"Archery";
        case HKWorkoutActivityTypeAustralianFootball:
            return @"AustralianFootball";
        case HKWorkoutActivityTypeBadminton:
            return @"Badminton";
        case HKWorkoutActivityTypeBaseball:
            return @"Baseball";
        case HKWorkoutActivityTypeBasketball:
            return @"Basketball";
        case HKWorkoutActivityTypeBowling:
            return @"Bowling";
        case HKWorkoutActivityTypeBoxing:
            return @"Boxing";
        case HKWorkoutActivityTypeCardioDance:
            return @"CardioDance";
        case HKWorkoutActivityTypeClimbing:
            return @"Climbing";
        case HKWorkoutActivityTypeCooldown:
            return @"Cooldown";
        case HKWorkoutActivityTypeCricket:
            return @"Cricket";
        case HKWorkoutActivityTypeCrossTraining:
            return @"CrossTraining";
        case HKWorkoutActivityTypeCurling:
            return @"Curling";
        case HKWorkoutActivityTypeCycling:
            return @"Cycling";
        case HKWorkoutActivityTypeDance:
            return @"Dance";
        case HKWorkoutActivityTypeDanceInspiredTraining:
            return @"DanceInspiredTraining";
        case HKWorkoutActivityTypeDiscSports:
            return @"DiscSports";
        case HKWorkoutActivityTypeElliptical:
            return @"Elliptical";
        case HKWorkoutActivityTypeEquestrianSports:
            return @"EquestrianSports";
        case HKWorkoutActivityTypeFencing:
            return @"Fencing";
        case HKWorkoutActivityTypeFitnessGaming:
            return @"FitnessGaming";
        case HKWorkoutActivityTypeFishing:
            return @"Fishing";
        case HKWorkoutActivityTypeFunctionalStrengthTraining:
            return @"FunctionalStrengthTraining";
        case HKWorkoutActivityTypeGolf:
            return @"Golf";
        case HKWorkoutActivityTypeGymnastics:
            return @"Gymnastics";
        case HKWorkoutActivityTypeHandball:
            return @"Handball";
        case HKWorkoutActivityTypeHiking:
            return @"Hiking";
        case HKWorkoutActivityTypeHockey:
            return @"Hockey";
        case HKWorkoutActivityTypeHunting:
            return @"Hunting";
        case HKWorkoutActivityTypeLacrosse:
            return @"Lacrosse";
        case HKWorkoutActivityTypeMartialArts:
            return @"MartialArts";
        case HKWorkoutActivityTypeMindAndBody:
            return @"MindAndBody";
        case HKWorkoutActivityTypeMixedMetabolicCardioTraining:
            return @"MixedMetabolicCardioTraining";
        case HKWorkoutActivityTypePaddleSports:
            return @"PaddleSports";
        case HKWorkoutActivityTypePlay:
            return @"Play";
        case HKWorkoutActivityTypePickleball:
            return @"Pickleball";
        case HKWorkoutActivityTypePreparationAndRecovery:
            return @"PreparationAndRecovery";
        case HKWorkoutActivityTypeRacquetball:
            return @"Racquetball";
        case HKWorkoutActivityTypeRowing:
            return @"Rowing";
        case HKWorkoutActivityTypeRugby:
            return @"Rugby";
        case HKWorkoutActivityTypeRunning:
            return @"Running";
        case HKWorkoutActivityTypeSailing:
            return @"Sailing";
        case HKWorkoutActivityTypeSkatingSports:
            return @"SkatingSports";
        case HKWorkoutActivityTypeSnowSports:
            return @"SnowSports";
        case HKWorkoutActivityTypeSoccer:
            return @"Soccer";
        case HKWorkoutActivityTypeSocialDance:
            return @"SocialDance";
        case HKWorkoutActivityTypeSoftball:
            return @"Softball";
        case HKWorkoutActivityTypeSquash:
            return @"Squash";
        case HKWorkoutActivityTypeStairClimbing:
            return @"StairClimbing";
        case HKWorkoutActivityTypeSurfingSports:
            return @"SurfingSports";
        case HKWorkoutActivityTypeSwimming:
            return @"Swimming";
        case HKWorkoutActivityTypeTableTennis:
            return @"TableTennis";
        case HKWorkoutActivityTypeTennis:
            return @"Tennis";
        case HKWorkoutActivityTypeTrackAndField:
            return @"TrackAndField";
        case HKWorkoutActivityTypeTraditionalStrengthTraining:
            return @"TraditionalStrengthTraining";
        case HKWorkoutActivityTypeVolleyball:
            return @"Volleyball";
        case HKWorkoutActivityTypeWalking:
            return @"Walking";
        case HKWorkoutActivityTypeWaterFitness:
            return @"WaterFitness";
        case HKWorkoutActivityTypeWaterPolo:
            return @"WaterPolo";
        case HKWorkoutActivityTypeWaterSports:
            return @"WaterSports";
        case HKWorkoutActivityTypeWrestling:
            return @"Wrestling";
        case HKWorkoutActivityTypeYoga:
            return @"Yoga";
        case HKWorkoutActivityTypeOther:
            return @"Other";
        case HKWorkoutActivityTypeBarre:
            return @"Barre";
        case HKWorkoutActivityTypeCoreTraining:
            return @"CoreTraining";
        case HKWorkoutActivityTypeCrossCountrySkiing:
            return @"CrossCountrySkiing";
        case HKWorkoutActivityTypeDownhillSkiing:
            return @"DownhillSkiing";
        case HKWorkoutActivityTypeFlexibility:
            return @"Flexibility";
        case HKWorkoutActivityTypeHighIntensityIntervalTraining:
            return @"HighIntensityIntervalTraining";
        case HKWorkoutActivityTypeJumpRope:
            return @"JumpRope";
        case HKWorkoutActivityTypeKickboxing:
            return @"Kickboxing";
        case HKWorkoutActivityTypePilates:
            return @"Pilates";
        case HKWorkoutActivityTypeSnowboarding:
            return @"Snowboarding";
        case HKWorkoutActivityTypeStairs:
            return @"Stairs";
        case HKWorkoutActivityTypeStepTraining:
            return @"StepTraining";
        case HKWorkoutActivityTypeWheelchairWalkPace:
            return @"WheelchairWalkPace";
        case HKWorkoutActivityTypeWheelchairRunPace:
            return @"WheelchairRunPace";
        case HKWorkoutActivityTypeTaiChi:
            return @"TaiChi";
        case HKWorkoutActivityTypeMixedCardio:
            return @"MixedCardio";
        case HKWorkoutActivityTypeHandCycling:
            return @"HandCycling";
        default:
            return @"Other";
    }
}

@end
