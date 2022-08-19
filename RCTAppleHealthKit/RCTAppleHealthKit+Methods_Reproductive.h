//
//  RCTAppleHealthKit+Methods_Mindfulness.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Reproductive)

- (void)reproductive_getSexualActivity:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)reproductive_saveSexualActivity:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
