//
//  RCTAppleHealthKit+Methods_Characteristic.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Characteristic)

- (void)characteristic_getBiologicalSex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)characteristic_getDateOfBirth:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)characteristic_getBloodType:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
