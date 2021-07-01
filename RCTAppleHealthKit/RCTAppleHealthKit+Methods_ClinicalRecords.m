//
//  RCTAppleHealthKit+Methods_ClinicalRecords.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit+Methods_ClinicalRecords.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_ClinicalRecords)

/*
    startDate?: string
    endDate?: string
    limit?: number
    ascending?: boolean
    type?: HealthObserver
    date?: string
    includeManuallyAdded?: boolean
    period?: number
    anchor?: string
    */

/*
 - (void)labTests_getBloodAlcoholContentSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
     
     HKQuantityType *bloodAlcoholContentType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];

     HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit percentUnit]];
     NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
     BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
     NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
     NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
     if(startDate == nil){
         callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
         return;
     }
     NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

     [self fetchQuantitySamplesOfType:bloodAlcoholContentType
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
     
 }
 */

/*
 func queryForSamples() {
     let sortDescriptors = [NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)]
     let query = HKSampleQuery(sampleType: sampleType, predicate: nil, limit: 100, sortDescriptors: sortDescriptors) {(_, samplesOrNil, error) in
         DispatchQueue.main.async {
             guard let samples = samplesOrNil else {
                 self.handleError(error)
                 return
             }
             
             self.samples = samples
             self.tableView.reloadData()
         }
     }
     
     healthStore.execute(query)
 }
 */

/*
 
 // Clinical Records
 if ([@"AllergyRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierAllergyRecord];
 } else if ([@"ConditionRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierConditionRecord];
 } else if ([@"CoverageRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierCoverageRecord];
 } else if ([@"ImmunizationRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierImmunizationRecord];
 } else if ([@"LabResultRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierLabResultRecord];
 } else if ([@"MedicationRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierMedicationRecord];
 } else if ([@"ProcedureRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierProcedureRecord];
 } else if ([@"VitalSignRecord" isEqualToString:key]) {
     return [HKObjectType clinicalTypeForIdentifier:HKClinicalTypeIdentifierVitalSignRecord];
 }
 */

- (void)clinicalRecords_getAllergyRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *allergyRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierAllergyRecord];
    
    // TODO: KL UNIT?
     HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit percentUnit]];
     NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
     BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
     NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
     NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
     if(startDate == nil){
         callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
         return;
     }
     NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchSamplesOfType:allergyRecordType unit:unit predicate:predicate ascending:ascending limit:limit completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
    }];
}

- (void)clinicalRecords_getConditionRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    //
}

- (void)clinicalRecords_getCoverageRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    //
}

- (void)clinicalRecords_getImmunizationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    //
}

- (void)clinicalRecords_getLabResultRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    //
}

- (void)clinicalRecords_getMedicationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    //
}

- (void)clinicalRecords_getProcedureRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    //
}

- (void)clinicalRecords_getVitalSignRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    //
}

@end

/*
 HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];

 HKUnit *count = [HKUnit countUnit];
 HKUnit *minute = [HKUnit minuteUnit];

 HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
 NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
 BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
 NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
 NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
 if(startDate == nil){
     callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
     return;
 }
 NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

 [self fetchQuantitySamplesOfType:heartRateType
                             unit:unit
                        predicate:predicate
                        ascending:ascending
                            limit:limit
                       completion:^(NSArray *results, NSError *error) {
                           if(results){
                               callback(@[[NSNull null], results]);
                               return;
                           } else {
                               NSLog(@"error getting heart rate samples: %@", error);
                               callback(@[RCTMakeError(@"error getting heart rate samples:", error, nil)]);
                               return;
                           }
                       }];
 */
