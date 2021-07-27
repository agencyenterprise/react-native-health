//
//  RCTAppleHealthKit+Methods_Hearing.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Hearing)

- (void)hearing_getEnvironmentalAudioExposure:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)hearing_getHeadphoneAudioExposure:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
