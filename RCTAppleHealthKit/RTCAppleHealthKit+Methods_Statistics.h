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

@end
