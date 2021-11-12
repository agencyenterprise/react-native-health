//
//  RCTAppleHealthKit+Methods_Body.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Body)

- (void)body_getLatestWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getWeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getBodyMassIndexSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getHeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestWaistCircumference:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getWaistCircumferenceSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveWaistCircumference:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestBodyFatPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getBodyFatPercentageSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveBodyFatPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_saveBodyTemperature:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestLeanBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getLeanBodyMassSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveLeanBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
