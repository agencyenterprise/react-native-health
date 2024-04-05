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

// MARK: - Dietary

// MARK: - Macronutrients

- (void)statistics_getStatisticDietaryEnergyConsumed:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryProtein:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryFiber:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryTotalFat:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietarySugar:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryFatMonounsaturated:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryFatPolyunsaturated:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryFatSaturated:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryCholesterol:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryCarbohydrates:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Vitamins

- (void)statistics_getStatisticDietaryVitaminA:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryThiamin:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryRiboflavin:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryNiacin:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryPantothenicAcid:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminB6:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryBiotin:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminB12:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminC:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminD:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminE:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryVitaminK:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryFolate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Minerals

- (void)statistics_getStatisticDietaryCalcium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryChloride:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryIron:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryMagnesium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryPhosphorus:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryPotassium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietarySodium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryZinc:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Hydration

- (void)statistics_getStatisticDietaryWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Caffeination

- (void)statistics_getStatisticDietaryCaffeine:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Ultratrace Minerals

- (void)statistics_getStatisticDietaryChromium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryCopper:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryIodine:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryManganese:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietaryMolybdenum:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)statistics_getStatisticDietarySelenium:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;


- (void)statistics_getStatisticInsulinDelivery:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Activity

- (void)statistics_getStatisticDistanceWheelchair:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)statistics_getStatisticAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Body Measurments

- (void)statistics_getStatisticAppleSleepingWristTemperature:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Vital Signs

- (void)statistics_getStatisticHeartRateRecoveryOneMinute:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)statistics_getStatisticAtrialFibrillationBurden:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - Lab And Test Results

- (void)statistics_getStatisticNumberOfTimesFallen:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)statistics_getStatisticPeakExpiratoryFlowRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

- (void)statistics_getStatisticPeripheralPerfusionIndex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

// MARK: - UV Exposure

- (void)statistics_getStatisticUvExposure:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
