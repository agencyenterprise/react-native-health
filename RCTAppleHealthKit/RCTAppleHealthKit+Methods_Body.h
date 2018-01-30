//
//  RCTAppleHealthKit+Methods_Body.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Body)

- (void)body_getLatestWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getWeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getHeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)body_getLatestBodyFatPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_getLatestLeanBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
