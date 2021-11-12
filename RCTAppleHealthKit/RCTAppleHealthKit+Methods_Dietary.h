//
//  RCTAppleHealthKit+Methods_Dietary.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Dietary)

- (void)saveFood:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)saveWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)getWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)dietary_getEnergyConsumedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getProteinSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getTotalFatSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
@end
