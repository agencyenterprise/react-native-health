//
//  RCTAppleHealthKit+Methods_Mindfulness.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Mindfulness)

- (void)mindfulness_getMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)mindfulness_saveMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
