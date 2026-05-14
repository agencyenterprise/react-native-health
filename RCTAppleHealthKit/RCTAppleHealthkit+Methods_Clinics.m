//
//  RCTAppleHealthkit+Methods_Clinics.m
//  RCTAppleHealthKit
//
//  Created by Yair Pinchasi on 21/08/2025.
//  Copyright © 2025 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthkit+Methods_Clinics.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Clinics)

- (void)clinics_getMedications:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self fetchClinicalRecordsOfType:[HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierMedicationRecord]
                 predicate:nil
                 ascending:false
                     limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting medications: %@", error);
                                  callback(@[RCTMakeError(@"error getting medications", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)clinics_getConditions:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self fetchClinicalRecordsOfType:[HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierConditionRecord]
               predicate:nil
               ascending:false
                   limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting conditions: %@", error);
                                  callback(@[RCTMakeError(@"error getting conditions", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)clinics_getAllergyRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self fetchClinicalRecordsOfType:[HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierAllergyRecord]
               predicate:nil
               ascending:false
                   limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting allergies: %@", error);
                                  callback(@[RCTMakeError(@"error getting allergies", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)clinics_getImmunizationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self fetchClinicalRecordsOfType:[HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierImmunizationRecord]
               predicate:nil
               ascending:false
                   limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting immunizations: %@", error);
                                  callback(@[RCTMakeError(@"error getting immunizations", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)clinics_getProcedureRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self fetchClinicalRecordsOfType:[HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierProcedureRecord]
               predicate:nil
               ascending:false
                   limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting procedures: %@", error);
                                  callback(@[RCTMakeError(@"error getting procedures", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)clinics_getLabRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self fetchClinicalRecordsOfType:[HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierLabResultRecord]
                    predicate:nil
                    ascending:false
                        limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting lab records: %@", error);
                                  callback(@[RCTMakeError(@"error getting lab records", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)clinics_getClinicalVitalsRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self fetchClinicalRecordsOfType:[HKClinicalType clinicalTypeForIdentifier:HKClinicalTypeIdentifierVitalSignRecord]
               predicate:nil
               ascending:false
                   limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting clinical vitals: %@", error);
                                  callback(@[RCTMakeError(@"error getting clinical vitals", nil, nil)]);
                                  return;
                              }
                          }];
}

@end
