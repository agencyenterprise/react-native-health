#import "RCTAppleHealthKit+Methods_Results.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Results)


- (void)results_getBloodGlucoseSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bloodGlucoseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];

    HKUnit *mmoLPerL = [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]];
    
    HKUnit *mgPerdL = [[HKUnit gramUnitWithMetricPrefix:HKMetricPrefixMilli] unitDividedByUnit:[HKUnit literUnitWithMetricPrefix:HKMetricPrefixDeci]];

    

    HKUnit *unit = [RCTAppleHealthKit stringFromOptions:input key:@"unit" withDefault:mgPerdL];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bloodGlucoseType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"An error occured while retrieving the glucose sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while retrieving the glucose sample", error, nil)]);
            return;
        }
    }];
}

- (void)results_saveBloodGlucoseSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bloodGlucoseType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];

    HKUnit *mmoLPerL = [[HKUnit moleUnitWithMetricPrefix:HKMetricPrefixMilli molarMass:HKUnitMolarMassBloodGlucose] unitDividedByUnit:[HKUnit literUnit]];

    HKUnit *mgPerdL = [[HKUnit gramUnitWithMetricPrefix:HKMetricPrefixMilli] unitDividedByUnit:[HKUnit literUnitWithMetricPrefix:HKMetricPrefixDeci]];

    double value = [RCTAppleHealthKit doubleValueFromOptions:input];
    NSDate *sampleDate = [RCTAppleHealthKit dateFromOptions:input key:@"date" withDefault:[NSDate date]];
    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:mgPerdL];


    HKQuantity *glucoseQuantity = [HKQuantity quantityWithUnit:unit doubleValue:value];
    HKQuantitySample *glucoseSample = [HKQuantitySample quantitySampleWithType:bloodGlucoseType quantity:glucoseQuantity startDate:sampleDate endDate:sampleDate];

    [self.healthStore saveObject:glucoseSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured while saving the glucose sample %@. The error was: ", error);
            callback(@[RCTMakeError(@"An error occured while saving the glucose sample", error, nil)]);
            return;
        }
        callback(@[[NSNull null], @(value)]);
    }];
}

@end
