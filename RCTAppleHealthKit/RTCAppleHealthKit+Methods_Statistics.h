//
//  RTCAppleHealthKit+Methods_Statistics.h
//  RCTAppleHealthKit
//
//  Created by Alex.M on 29.10.2021.
//  Copyright © 2021 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Statistics)

- (void)statistics_getStatisticBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticBloodGlucose:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticBloodPressureSystolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticBloodPressureDiastolic:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticBodyMassIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticStepCount:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticHeartRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticBodyTemperature:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticOxygenSaturation:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticRestingHeartRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// Dietary

- (void)statistics_getStatisticDietaryEnergyConsumed:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryProtein:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryFiber:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryTotalFat:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietarySugar:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryFatSaturated:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryCholesterol:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryCarbohydrates:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryCalcium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryIron:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryPotassium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietarySodium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminA:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminC:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminD:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)statistics_getStatisticInsulinDelivery:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
