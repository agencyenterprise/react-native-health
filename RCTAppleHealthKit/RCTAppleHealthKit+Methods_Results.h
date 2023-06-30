//
//  RCTAppleHealthKit+Methods_Results.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Results)

- (void)results_getBloodGlucoseSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)results_getCarbohydratesSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)results_getInsulinDeliverySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)results_saveBloodGlucoseSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)results_saveCarbohydratesSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)results_deleteBloodGlucoseSample:(NSString *)oid callback:(RCTResponseSenderBlock)callback;
- (void)results_deleteCarbohydratesSample:(NSString *)oid callback:(RCTResponseSenderBlock)callback;
- (void)results_saveInsulinDeliverySample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)results_deleteInsulinDeliverySample:(NSString *)oid callback:(RCTResponseSenderBlock)callback;
- (void)results_registerObservers:(RCTBridge *)bridge hasListeners:(bool)hasListeners;

@end
