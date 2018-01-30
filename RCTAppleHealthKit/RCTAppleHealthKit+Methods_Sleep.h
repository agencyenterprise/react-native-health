//
//  RCTAppleHealthKit+Methods_Sleep.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-11-06.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Sleep)

- (void)sleep_getSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
