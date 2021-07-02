//
//  RCTAppleHealthKit+Methods_ClinicalRecords.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_ClinicalRecords)

- (void)clinicalRecords_getClinicalRecords:(HKClinicalType *)recordType input:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getAllergyRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getConditionRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getCoverageRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getImmunizationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getLabResultRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getMedicationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getProcedureRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinicalRecords_getVitalSignRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
