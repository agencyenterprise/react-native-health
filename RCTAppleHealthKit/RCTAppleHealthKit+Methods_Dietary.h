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
- (void)getWaterSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)dietary_getEnergyConsumedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getProteinSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getFiberSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getTotalFatSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)dietary_getSugarSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getFatMonounsaturatedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getFatPolyunsaturatedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getFatSaturatedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getCholesterolSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)dietary_getThiaminSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getRiboflavinSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getNiacinSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getPantothenicAcidSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getBiotinSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getFolateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getVitaminASamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getVitaminB6Samples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getVitaminB12Samples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getVitaminCSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getVitaminDSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getVitaminESamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getVitaminKSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)dietary_getCalciumSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getChlorideSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getIronSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getMagnesiumSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getPhosphorusSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getPotassiumSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getSodiumSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getZincSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getCaffeineSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)dietary_getChromiumSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getCopperSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getIodineSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getManganeseSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getMolybdenumSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)dietary_getSeleniumSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
