//
//  RCTAppleHealthKit+Methods_Characteristic.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-29.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Characteristic)

- (void)characteristic_getBiologicalSex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)characteristic_getDateOfBirth:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
