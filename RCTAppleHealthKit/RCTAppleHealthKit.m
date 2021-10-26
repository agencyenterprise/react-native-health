//
//  RCTAppleHealthKit.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"

#import "RCTAppleHealthKit+Methods_Activity.h"
#import "RCTAppleHealthKit+Methods_Body.h"
#import "RCTAppleHealthKit+Methods_Fitness.h"
#import "RCTAppleHealthKit+Methods_Dietary.h"
#import "RCTAppleHealthKit+Methods_Characteristic.h"
#import "RCTAppleHealthKit+Methods_Vitals.h"
#import "RCTAppleHealthKit+Methods_Results.h"
#import "RCTAppleHealthKit+Methods_Sleep.h"
#import "RCTAppleHealthKit+Methods_Mindfulness.h"
#import "RCTAppleHealthKit+Methods_Workout.h"
#import "RCTAppleHealthKit+Methods_LabTests.h"
#import "RCTAppleHealthKit+Methods_Hearing.h"
#import "RCTAppleHealthKit+Methods_Summary.h"
#import "RCTAppleHealthKit+Methods_ClinicalRecords.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

RCTAppleHealthKit *shared;

@implementation RCTAppleHealthKit

@synthesize bridge = _bridge;

bool hasListeners;

RCT_EXPORT_MODULE();

- (id) init
{
    if (shared != nil) {
        return shared;
    }

    self = [super init];
    shared = self;
    return self;
}

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

RCT_EXPORT_METHOD(isAvailable:(RCTResponseSenderBlock)callback)
{
    [self isHealthKitAvailable:callback];
}

RCT_EXPORT_METHOD(initHealthKit:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self initializeHealthKit:input callback:callback];
}

RCT_EXPORT_METHOD(initStepCountObserver:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_initializeStepEventObserver:input hasListeners:hasListeners callback:callback];
}

RCT_EXPORT_METHOD(getBiologicalSex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self characteristic_getBiologicalSex:input callback:callback];
}

RCT_EXPORT_METHOD(getBloodType:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self characteristic_getBloodType:input callback:callback];
}

RCT_EXPORT_METHOD(getDateOfBirth:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self characteristic_getDateOfBirth:input callback:callback];
}

RCT_EXPORT_METHOD(getLatestWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLatestWeight:input callback:callback];
}

RCT_EXPORT_METHOD(getWeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getWeightSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_saveWeight:input callback:callback];
}

RCT_EXPORT_METHOD(getLatestHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLatestHeight:input callback:callback];
}

RCT_EXPORT_METHOD(getHeightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getHeightSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveHeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_saveHeight:input callback:callback];
}

RCT_EXPORT_METHOD(getLatestWaistCircumference:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLatestWaistCircumference:input callback:callback];
}

RCT_EXPORT_METHOD(getWaistCircumferenceSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getWaistCircumferenceSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveWaistCircumference:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_saveWaistCircumference:input callback:callback];
}

RCT_EXPORT_METHOD(getLatestBmi:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLatestBodyMassIndex:input callback:callback];
}

RCT_EXPORT_METHOD(getBmiSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getBodyMassIndexSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveBmi:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_saveBodyMassIndex:input callback:callback];
}

RCT_EXPORT_METHOD(getLatestBodyFatPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLatestBodyFatPercentage:input callback:callback];
}

RCT_EXPORT_METHOD(getBodyFatPercentageSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getBodyFatPercentageSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveBodyFatPercentage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_saveBodyFatPercentage:input callback:callback];
}

RCT_EXPORT_METHOD(saveBodyTemperature:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_saveBodyTemperature:input callback:callback];
}

RCT_EXPORT_METHOD(getLatestLeanBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLatestLeanBodyMass:input callback:callback];
}

RCT_EXPORT_METHOD(getLeanBodyMassSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLeanBodyMassSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveLeanBodyMass:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_saveLeanBodyMass:input callback:callback];
}

RCT_EXPORT_METHOD(getStepCount:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getStepCountOnDay:input callback:callback];
}

RCT_EXPORT_METHOD(getSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getAnchoredWorkouts:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self workout_getAnchoredQuery:input callback:callback];
}

RCT_EXPORT_METHOD(setObserver:(NSDictionary *)input)
{
    [self _initializeHealthStore];
    [self fitness_setObserver:input];
}

RCT_EXPORT_METHOD(getDailyStepCountSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDailyStepSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveSteps:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_saveSteps:input callback:callback];
}

RCT_EXPORT_METHOD(getDistanceWalkingRunning:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDistanceWalkingRunningOnDay:input callback:callback];
}

RCT_EXPORT_METHOD(getDailyDistanceWalkingRunningSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDailyDistanceWalkingRunningSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getDistanceCycling:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDistanceCyclingOnDay:input callback:callback];
}

RCT_EXPORT_METHOD(getDailyDistanceCyclingSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDailyDistanceCyclingSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getDistanceSwimming:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDistanceSwimmingOnDay:input callback:callback];
}

RCT_EXPORT_METHOD(getDailyDistanceSwimmingSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDailyDistanceSwimmingSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getFlightsClimbed:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getFlightsClimbedOnDay:input callback:callback];
}

RCT_EXPORT_METHOD(getDailyFlightsClimbedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getDailyFlightsClimbedSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getEnergyConsumedSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
   [self dietary_getEnergyConsumedSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getProteinSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
   [self dietary_getProteinSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getTotalFatSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
   [self dietary_getTotalFatSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveFood:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self saveFood:input callback:callback];
}

RCT_EXPORT_METHOD(saveWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self saveWater:input callback:callback];
}

RCT_EXPORT_METHOD(getWater:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self getWater:input callback:callback];
}

RCT_EXPORT_METHOD(getHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getHeartRateSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getRestingHeartRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getRestingHeartRate:input callback:callback];
}

RCT_EXPORT_METHOD(getWalkingHeartRateAverage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getWalkingHeartRateAverage:input callback:callback];
}

RCT_EXPORT_METHOD(getActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
   [self _initializeHealthStore];
   [self activity_getActiveEnergyBurned:input callback:callback];
}

RCT_EXPORT_METHOD(getBasalEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self activity_getBasalEnergyBurned:input callback:callback];
}

RCT_EXPORT_METHOD(getAppleExerciseTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self activity_getAppleExerciseTime:input callback:callback];
}

RCT_EXPORT_METHOD(getAppleStandTime:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self activity_getAppleStandTime:input callback:callback];
}

RCT_EXPORT_METHOD(getVo2MaxSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getVo2MaxSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getBodyTemperatureSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getBloodPressureSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getRespiratoryRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getRespiratoryRateSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getHeartRateVariabilitySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getHeartRateVariabilitySamples:input callback:callback];
}

RCT_EXPORT_METHOD(getHeartbeatSeriesSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getHeartbeatSeriesSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getRestingHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getRestingHeartRateSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getOxygenSaturationSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getOxygenSaturationSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getElectrocardiogramSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_getElectrocardiogramSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getBloodGlucoseSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_getBloodGlucoseSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getCarbohydratesSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_getCarbohydratesSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveCarbohydratesSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_saveCarbohydratesSample:input callback:callback];
}

RCT_EXPORT_METHOD(deleteCarbohydratesSample:(NSString *)oid callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_deleteCarbohydratesSample:oid callback:callback];
}

RCT_EXPORT_METHOD(saveBloodGlucoseSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_saveBloodGlucoseSample:input callback:callback];
}

RCT_EXPORT_METHOD(deleteBloodGlucoseSample:(NSString *)oid callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_deleteBloodGlucoseSample:oid callback:callback];
}

RCT_EXPORT_METHOD(getSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self sleep_getSleepSamples:input callback:callback];
}

RCT_EXPORT_METHOD(getInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self getModuleInfo:input callback:callback];
}

RCT_EXPORT_METHOD(getMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self mindfulness_getMindfulSession:input callback:callback];
}

RCT_EXPORT_METHOD(saveMindfulSession:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self mindfulness_saveMindfulSession:input callback:callback];
}

RCT_EXPORT_METHOD(saveWorkout:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self workout_save:input callback:callback];
}

RCT_EXPORT_METHOD(getAuthStatus: (NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self getAuthorizationStatus:input callback:callback];
}

RCT_EXPORT_METHOD(getLatestBloodAlcoholContent: (NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self labTests_getLatestBloodAlcoholContent:input callback:callback];
}

RCT_EXPORT_METHOD(getBloodAlcoholContentSamples: (NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self labTests_getBloodAlcoholContentSamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveBloodAlcoholContent: (NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self labTests_saveBloodAlcoholContent:input callback:callback];
}

RCT_EXPORT_METHOD(getEnvironmentalAudioExposure: (NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self hearing_getEnvironmentalAudioExposure:input callback:callback];
}

RCT_EXPORT_METHOD(getHeadphoneAudioExposure: (NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self hearing_getHeadphoneAudioExposure:input callback:callback];
}

RCT_EXPORT_METHOD(getActivitySummary: (NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self summary_getActivitySummary:input callback:callback];
}

RCT_EXPORT_METHOD(getClinicalRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self clinicalRecords_getClinicalRecords:input callback:callback];
}

- (HKHealthStore *)_initializeHealthStore {
  if(![self healthStore]) {
    self.healthStore = [[HKHealthStore alloc] init];
  }
  return [self healthStore];
}


- (void)isHealthKitAvailable:(RCTResponseSenderBlock)callback
{
    BOOL isAvailable = NO;

    if ([HKHealthStore isHealthDataAvailable]) {
        isAvailable = YES;
    }

    callback(@[[NSNull null], @(isAvailable)]);
}


- (void)initializeHealthKit:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    [self _initializeHealthStore];

    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes;
        NSSet *readDataTypes;

        // get permissions from input object provided by JS options argument
        NSDictionary* permissions =[input objectForKey:@"permissions"];
        if(permissions != nil){
            NSArray* readPermsArray = [permissions objectForKey:@"read"];
            NSArray* writePermsArray = [permissions objectForKey:@"write"];
            NSSet* readPerms = [self getReadPermsFromOptions:readPermsArray];
            NSSet* writePerms = [self getWritePermsFromOptions:writePermsArray];

            if(readPerms != nil) {
                readDataTypes = readPerms;
            }
            if(writePerms != nil) {
                writeDataTypes = writePerms;
            }
        } else {
            callback(@[RCTMakeError(@"permissions must be provided in the initialization options", nil, nil)]);
            return;
        }

        // make sure at least 1 read or write permission is provided
        if(!writeDataTypes && !readDataTypes){
            callback(@[RCTMakeError(@"at least 1 read or write permission must be set in options.permissions", nil, nil)]);
            return;
        }

        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                NSLog(errMsg);
                callback(@[RCTMakeError(errMsg, nil, nil)]);
                return;
            } else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    callback(@[[NSNull null], @true]);
                });
            }
        }];
    } else {
        callback(@[RCTMakeError(@"HealthKit data is not available", nil, nil)]);
    }
}

- (NSArray<NSString *> *)supportedEvents {
    NSArray *types = @[
        @"ActiveEnergyBurned",
        @"BasalEnergyBurned",
        @"Cycling",
        @"HeartRate",
        @"HeartRateVariabilitySDNN",
        @"RestingHeartRate",
        @"Running",
        @"StairClimbing",
        @"StepCount",
        @"Swimming",
        @"Vo2Max",
        @"Walking",
        @"Workout",
        @"MindfulSession",
        @"AllergyRecord",
        @"ConditionRecord",
        @"CoverageRecord",
        @"ImmunizationRecord",
        @"LabResultRecord",
        @"MedicationRecord",
        @"ProcedureRecord",
        @"VitalSignRecord",
        @"SleepAnalysis"
    ];
    
    NSArray *templates = @[@"healthKit:%@:new", @"healthKit:%@:failure", @"healthKit:%@:enabled", @"healthKit:%@:sample", @"healthKit:%@:setup:success", @"healthKit:%@:setup:failure"];
    
    NSMutableArray *supportedEvents = [[NSMutableArray alloc] init];

    for(NSString * type in types) {
        for(NSString * template in templates) {
            NSString *successEvent = [NSString stringWithFormat:template, type];
            [supportedEvents addObject: successEvent];
        }
    }
    [supportedEvents addObject: @"change:steps"];
  return supportedEvents;
}

- (void)getModuleInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDictionary *info = @{
            @"name" : @"react-native-apple-healthkit",
            @"description" : @"A React Native bridge module for interacting with Apple HealthKit data",
            @"className" : @"RCTAppleHealthKit",
            @"author": @"Greg Wilson",
    };
    callback(@[[NSNull null], info]);
}

- (void)getAuthorizationStatus:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
  
    [self _initializeHealthStore];
    if ([HKHealthStore isHealthDataAvailable]) {

        NSArray* readPermsArray;
        NSArray* writePermsArray;

        NSDictionary* permissions =[input objectForKey:@"permissions"];
        if(permissions != nil && [permissions objectForKey:@"read"] != nil && [permissions objectForKey:@"write"] != nil){
            NSArray* readPermsNamesArray = [permissions objectForKey:@"read"];
            NSArray* writePermsNamesArray = [permissions objectForKey:@"write"];
            readPermsArray = [self getReadPermsFromOptions:readPermsNamesArray];
            writePermsArray = [self getWritePermsFromOptions:writePermsNamesArray];
        } else {
            callback(@[RCTMakeError(@"permissions must be included in permissions object with read and write options", nil, nil)]);
            return;
        }


        NSMutableArray * read = [NSMutableArray arrayWithCapacity: 1];
        for(HKObjectType * perm in readPermsArray) {
            [read  addObject:[NSNumber numberWithInt:[self.healthStore authorizationStatusForType: perm]]];
        }
        NSMutableArray * write = [NSMutableArray arrayWithCapacity: 1];
        for(HKObjectType * perm in writePermsArray) {
            [write  addObject:[NSNumber numberWithInt:[self.healthStore authorizationStatusForType: perm]]];
        }
        callback(@[[NSNull null], @{
                       @"permissions":
                           @{
                               @"read": read,
                               @"write": write
                               }
                       }]);
    } else {
        callback(@[RCTMakeError(@"HealthKit data is not available", nil, nil)]);
    }
}

/*!
    Initialize background delivery for the specified types. This allows for HealthKit to notify the app when a new
    sample of data is added to it

    This method must be called at the application:didFinishLaunchingWithOptions: method, in AppDelegate.m
 */
- (void)initializeBackgroundObservers:(RCTBridge *)bridge
{
    NSLog(@"[HealthKit] Background observers will be added to the app");

    [self _initializeHealthStore];

    self.bridge = bridge;

    if ([HKHealthStore isHealthDataAvailable]) {
        NSArray *fitnessObservers = @[
            @"ActiveEnergyBurned",
            @"BasalEnergyBurned",
            @"Cycling",
            @"HeartRate",
            @"HeartRateVariabilitySDNN",
            @"RestingHeartRate",
            @"Running",
            @"StairClimbing",
            @"StepCount",
            @"Swimming",
            @"Vo2Max",
            @"Walking",
            @"Workout",
            @"MindfulSession",
            @"SleepAnalysis",
        ];

        for(NSString * type in fitnessObservers) {
            [self fitness_registerObserver:type bridge:bridge hasListeners:hasListeners];
        }
        
        NSArray *clinicalObservers = @[
            @"AllergyRecord",
            @"ConditionRecord",
            @"CoverageRecord",
            @"ImmunizationRecord",
            @"LabResultRecord",
            @"MedicationRecord",
            @"ProcedureRecord",
            @"VitalSignRecord"
        ];
        
        for(NSString * type in clinicalObservers) {
            [self clinical_registerObserver:type bridge:bridge hasListeners:hasListeners];
        }

        NSLog(@"[HealthKit] Background observers added to the app");
        [self startObserving];
    } else {
        NSLog(@"[HealthKit] Apple HealthKit is not available in this platform");
    }
}

// Will be called when this module's first listener is added.
-(void)startObserving {
    self.hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    self.hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}

@end
