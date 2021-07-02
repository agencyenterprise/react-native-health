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

- (void)clinicalRecords_getClinicalRecords:(HKClinicalType *)recordType
                     input:(NSDictionary *)input
                  callback:(RCTResponseSenderBlock)callback
{
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
     callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
     return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchClinicalRecordsOfType:recordType predicate:predicate ascending:ascending limit:limit completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            callback(@[RCTJSErrorFromNSError(error)]);
            return;
        }
    }];
}

- (void)clinicalRecords_getAllergyRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *allergyRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierAllergyRecord];    
    [self clinicalRecords_getClinicalRecords:allergyRecordType input:input callback:callback];
}

- (void)clinicalRecords_getConditionRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *conditionRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierConditionRecord];
    [self clinicalRecords_getClinicalRecords:conditionRecordType input:input callback:callback];
}

- (void)clinicalRecords_getCoverageRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *coverageRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierCoverageRecord];
    [self clinicalRecords_getClinicalRecords:coverageRecordType input:input callback:callback];
}

- (void)clinicalRecords_getImmunizationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *immunizationRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierImmunizationRecord];
    [self clinicalRecords_getClinicalRecords:immunizationRecordType input:input callback:callback];
}

- (void)clinicalRecords_getLabResultRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *labResultRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierLabResultRecord];
    [self clinicalRecords_getClinicalRecords:labResultRecordType input:input callback:callback];
}

- (void)clinicalRecords_getMedicationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *medicationRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierMedicationRecord];
    [self clinicalRecords_getClinicalRecords:medicationRecordType input:input callback:callback];
}

- (void)clinicalRecords_getProcedureRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *procedureRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierProcedureRecord];
    [self clinicalRecords_getClinicalRecords:procedureRecordType input:input callback:callback];
}

- (void)clinicalRecords_getVitalSignRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKClinicalType *vitalSignRecordType = [HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierVitalSignRecord];
    [self clinicalRecords_getClinicalRecords:vitalSignRecordType input:input callback:callback];
}

@end
