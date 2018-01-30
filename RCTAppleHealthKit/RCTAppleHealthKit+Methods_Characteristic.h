//
//  RCTAppleHealthKit+Methods_Characteristic.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-29.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Characteristic)

- (void)characteristic_getBiologicalSex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)characteristic_getDateOfBirth:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
