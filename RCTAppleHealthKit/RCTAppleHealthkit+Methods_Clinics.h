//
//  RCTAppleHealthkit+Methods_Clinics.h
//  RCTAppleHealthKit
//
//  Created by Yair Pinchasi on 21/08/2025.
//  Copyright © 2025 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Clinics)

- (void)clinics_getMedications:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinics_getConditions:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinics_getAllergyRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinics_getImmunizationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinics_getProcedureRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinics_getLabRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)clinics_getClinicalVitalsRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
