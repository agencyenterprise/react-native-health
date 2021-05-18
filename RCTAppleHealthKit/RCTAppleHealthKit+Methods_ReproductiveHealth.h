//
//  RCTAppleHealthKit+Methods_ReproductiveHealth.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_ReproductiveHealth)
- (void)reproductiveHealth_getBasalBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)reproductiveHealth_getMenstrualFlowSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
@end
