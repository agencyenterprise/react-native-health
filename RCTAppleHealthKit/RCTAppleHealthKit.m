//
//  RCTAppleHealthKit.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"
#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+Queries.h"

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
#import "RCTAppleHealthkit+Methods_Clinics.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>
#import <os/lock.h>


@implementation RCTAppleHealthKit {
    BOOL _observersInitialized;
    os_unfair_lock _initLock;
}

bool hasListeners;

RCT_EXPORT_MODULE();


+ (id)allocWithZone:(NSZone *)zone {
    static RCTAppleHealthKit *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

+ (RCTCallableJSModules *)sharedJsModule {
    static RCTCallableJSModules *sharedJsModule = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedJsModule = [RCTCallableJSModules new];
    });
    return sharedJsModule;
}

- (id) init
{
    return [super init];
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
    [self fitness_initializeStepEventObserver:input callback:callback];
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

RCT_EXPORT_METHOD(getLatestPeakFlow:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getLatestPeakFlow:input callback:callback];
}

RCT_EXPORT_METHOD(getPeakFlowSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_getPeakFlowSamples:input callback:callback];
}

RCT_EXPORT_METHOD(savePeakFlow:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self body_savePeakFlow:input callback:callback];
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

+ (NSTimeInterval)syncIntervalFromString:(NSString *)interval {
    if ([interval isEqualToString:@"every1hour"])   return 3600.0;
    if ([interval isEqualToString:@"every6hours"])  return 21600.0;
    if ([interval isEqualToString:@"every12hours"]) return 43200.0;
    if ([interval isEqualToString:@"every24hours"]) return 86400.0;
    if ([interval isEqualToString:@"every48hours"]) return 172800.0;
    if ([interval isEqualToString:@"everyweek"])    return 604800.0;
    NSLog(@"[HealthKit] syncInterval: unrecognized string '%@', falling back to 86400s", interval);
    return 86400.0;
}

RCT_EXPORT_METHOD(configureBackgroundSync:(NSDictionary *)input)
{
    [self _initializeHealthStore];

    // Lazily wire background observers the first time JS calls configureBackgroundSync.
    // AppDelegate hooks (sourceURL:, RCTJavaScriptDidLoad) don't fire under Expo New Arch —
    // this is the only guaranteed JS-reachable entry point on this setup.
    // Uses a BOOL ivar (not dispatch_once) so a nil-bridge first call can retry on the next call.
    // Persist metrics list so AppDelegate can re-register the same types on killed-state launch.
    // nil and @[] are treated identically as "register all" — the JS caller guards against
    // passing an empty array (backgroundSync.ts line 90), so this case does not arise in practice.
    NSArray *metrics = [input objectForKey:@"metrics"];
    if (metrics.count > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:metrics forKey:@"RNHealth_SyncMetrics"];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RNHealth_SyncMetrics"];
    }

    if (self.bridge) {
        NSLog(@"[HealthKit] configureBackgroundSync — initializing background observers");
        [self initializeBackgroundObservers:self.bridge metrics:metrics];
    } else {
        NSLog(@"[HealthKit] configureBackgroundSync — WARNING: self.bridge is nil, observers NOT registered, will retry");
    }

    // Default to NO (opt-in) to match observer behavior: "Defaults to disabled if the key
    // was never written". Caller must explicitly pass enabled: true to enable background sync.
    BOOL enabled = [input objectForKey:@"enabled"]
        ? [[input objectForKey:@"enabled"] boolValue]
        : NO;
    [[NSUserDefaults standardUserDefaults] setBool:enabled forKey:@"RNHealth_SyncEnabled"];

    // Always persist syncInterval so it survives enable/disable cycles.
    // Stored even when disabled so re-enabling later uses the correct value.
    // Accepts either a named string alias ('every1hour', …) or a raw NSNumber of seconds.
    id interval = [input objectForKey:@"syncInterval"];
    if (interval) {
        NSTimeInterval seconds;
        if ([interval isKindOfClass:[NSNumber class]]) {
            double raw = [interval doubleValue];
            // Round floats to nearest integer, clamp to 1s minimum.
            // Non-finite, zero, or negative values fall back to 24h default.
            seconds = (isfinite(raw) && raw > 0) ? MAX(1.0, round(raw)) : 86400.0;
        } else if ([interval isKindOfClass:[NSString class]]) {
            seconds = [RCTAppleHealthKit syncIntervalFromString:(NSString *)interval];
        } else {
            NSLog(@"[HealthKit] syncInterval: unexpected type %@, using default 86400s", NSStringFromClass([interval class]));
            seconds = 86400.0;
        }
        [[NSUserDefaults standardUserDefaults] setDouble:seconds forKey:@"RNHealth_SyncInterval"];
        NSLog(@"[HealthKit] Background sync %@, interval %.0fs", enabled ? @"enabled" : @"disabled", seconds);
    } else {
        NSLog(@"[HealthKit] Background sync %@", enabled ? @"enabled" : @"disabled");
    }
}

+ (NSDate *)startDateFromPeriod:(NSString *)period {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *now     = [NSDate date];
    if ([period isEqualToString:@"last24hours"]) {
        return [cal dateByAddingUnit:NSCalendarUnitHour  value:-24  toDate:now options:0];
    }
    if ([period isEqualToString:@"today"]) {
        return [cal startOfDayForDate:now];
    }
    if ([period isEqualToString:@"last7days"]) {
        return [cal dateByAddingUnit:NSCalendarUnitDay   value:-7   toDate:now options:0];
    }
    if ([period isEqualToString:@"last30days"]) {
        return [cal dateByAddingUnit:NSCalendarUnitDay   value:-30  toDate:now options:0];
    }
    if ([period isEqualToString:@"last3months"]) {
        return [cal dateByAddingUnit:NSCalendarUnitMonth value:-3   toDate:now options:0];
    }
    if ([period isEqualToString:@"last6months"]) {
        return [cal dateByAddingUnit:NSCalendarUnitMonth value:-6   toDate:now options:0];
    }
    if ([period isEqualToString:@"lastyear"]) {
        return [cal dateByAddingUnit:NSCalendarUnitYear  value:-1   toDate:now options:0];
    }
    return nil;
}

RCT_EXPORT_METHOD(getDeltaSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];

    NSString *type = [RCTAppleHealthKit stringFromOptions:input key:@"type" withDefault:@""];

    // Validate required type field
    if (!type || [type length] == 0) {
        callback(@[RCTMakeError(@"getDeltaSamples: missing required 'type' field", nil, @{
            @"expectedTypes": @[
                @"HeartRate", @"RestingHeartRate", @"HeartRateVariabilitySDNN",
                @"StepCount", @"Walking", @"Running", @"Cycling", @"StairClimbing", @"Swimming",
                @"ActiveEnergyBurned", @"BasalEnergyBurned",
                @"BodyMass", @"BodyMassIndex", @"Height", @"BodyFatPercentage",
                @"OxygenSaturation", @"RespiratoryRate", @"BodyTemperature", @"BloodGlucose",
                @"Vo2Max", @"InsulinDelivery", @"DietaryCholesterol",
                @"SleepAnalysis", @"BloodPressure", @"Workout",
                @"AllergyRecord", @"ConditionRecord", @"CoverageRecord", @"ImmunizationRecord",
                @"LabResultRecord", @"MedicationRecord", @"ProcedureRecord", @"VitalSignRecord",
            ],
        })]);
        return;
    }

    // Workout: delegate to existing anchored workout method unchanged
    if ([type isEqualToString:@"Workout"]) {
        [self workout_getAnchoredQuery:input callback:callback];
        return;
    }

    HKQuantityType *quantityType = (HKQuantityType *)[RCTAppleHealthKit quantityTypeFromName:type];

    // Shared params — resolved identically for all HK type families
    HKQueryAnchor *anchor = [RCTAppleHealthKit hkAnchorFromOptions:input];
    NSUInteger limit      = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL includeManuallyAdded = [RCTAppleHealthKit boolFromOptions:input key:@"includeManuallyAdded" withDefault:YES];

    // Date range: explicit startDate wins; period string is the fallback.
    // For anchored queries with no explicit date range, startDate stays nil to fetch true delta.
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSString *periodString = [input objectForKey:@"period"];
    if (startDate == nil && periodString.length) {
        startDate = [RCTAppleHealthKit startDateFromPeriod:periodString];
    }
    // Only default to last24hours if not using anchor. Anchored queries with no explicit
    // date range fetch true delta (all changes since anchor). Non-anchored queries default
    // to last24hours for backwards compatibility.
    if (startDate == nil && anchor == nil) {
        startDate = [RCTAppleHealthKit startDateFromPeriod:@"last24hours"];
    }
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    // Date predicate only applies to non-anchored queries. For anchored queries, HealthKit
    // manages the window automatically from the anchor. Applying a date predicate to anchored
    // queries silently drops samples between anchor and startDate, breaking incremental sync.
    if (anchor != nil && (startDate != nil || periodString.length > 0)) {
        NSLog(@"[HealthKit] getDeltaSamples: anchor takes precedence — startDate/period ignored when anchor is provided");
    }
    NSPredicate *predicate = nil;
    if (anchor == nil) {
        predicate = [RCTAppleHealthKit predicateForAnchoredQueries:anchor startDate:startDate endDate:endDate];
    }

    // ── Quantity types (HeartRate, Steps, Weight, SpO2, HRV, etc.) ─────────────
    if (quantityType) {
        HKUnit *unit;
        NSString *unitString = [input objectForKey:@"unit"];
        if (unitString.length) {
            @try { unit = [HKUnit unitFromString:unitString]; }
            @catch (NSException *e) { unit = [RCTAppleHealthKit defaultHKUnitForType:type]; }
        } else {
            unit = [RCTAppleHealthKit defaultHKUnitForType:type];
        }

        [self fetchAnchoredSamplesOfType:quantityType
                                    unit:unit
                               predicate:predicate
                                  anchor:anchor
                                   limit:limit
                      includeManuallyAdded:includeManuallyAdded
                              completion:^(NSDictionary *results, NSError *error) {
            if (error) {
                callback(@[RCTMakeError(@"getDeltaSamples error", error, @{
                    @"code":   @(error.code),
                    @"domain": error.domain ?: @"",
                    @"type":   type,
                })]);
                return;
            }
            callback(@[[NSNull null], results]);
        }];
        return;
    }

    // ── Sleep (HKCategoryType) ─────────────────────────────────────────────────
    if ([type isEqualToString:@"SleepAnalysis"]) {
        HKCategoryType *categoryType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
        [self fetchAnchoredCategorySamplesOfType:categoryType
                                       predicate:predicate
                                          anchor:anchor
                                           limit:limit
                                      completion:^(NSDictionary *results, NSError *error) {
            if (error) {
                callback(@[RCTMakeError(@"getDeltaSamples error", error, @{
                    @"code":   @(error.code),
                    @"domain": error.domain ?: @"",
                    @"type":   type,
                })]);
                return;
            }
            callback(@[[NSNull null], results]);
        }];
        return;
    }

    // ── BloodPressure (HKCorrelationType) ─────────────────────────────────────
    if ([type isEqualToString:@"BloodPressure"]) {
        HKCorrelationType *correlationType = [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
        [self fetchAnchoredCorrelationSamplesOfType:correlationType
                                          predicate:predicate
                                             anchor:anchor
                                              limit:limit
                                         completion:^(NSDictionary *results, NSError *error) {
            if (error) {
                callback(@[RCTMakeError(@"getDeltaSamples error", error, @{
                    @"code":   @(error.code),
                    @"domain": error.domain ?: @"",
                    @"type":   type,
                })]);
                return;
            }
            callback(@[[NSNull null], results]);
        }];
        return;
    }

    // ── Clinical / FHIR types (LabResultRecord, AllergyRecord, etc.) ──────────
    if (@available(iOS 12.0, *)) {
        HKClinicalType *clinicalType = (HKClinicalType *)[RCTAppleHealthKit clinicalTypeFromName:type];
        if (clinicalType) {
            [self fetchAnchoredClinicalSamplesOfType:clinicalType
                                           predicate:predicate
                                              anchor:anchor
                                               limit:limit
                                          completion:^(NSDictionary *results, NSError *error) {
                if (error) {
                    callback(@[RCTMakeError(@"getDeltaSamples error", error, @{
                    @"code":   @(error.code),
                    @"domain": error.domain ?: @"",
                    @"type":   type,
                })]);
                    return;
                }
                callback(@[[NSNull null], results]);
            }];
            return;
        }
    }

    callback(@[RCTMakeError(@"getDeltaSamples: unsupported type", nil, @{ @"type": type })]);
}

RCT_EXPORT_METHOD(getWorkoutRouteSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self workout_getRoute:input callback:callback];
}

RCT_EXPORT_METHOD(setObserver:(NSDictionary *)input)
{
    [self _initializeHealthStore];
    [self fitness_setObserver:input];
}

RCT_EXPORT_METHOD(getStepCountSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_getStepCountSamples:input callback:callback];
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

RCT_EXPORT_METHOD(saveWalkingRunningDistance:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self fitness_saveWalkingRunningDistance:input callback:callback];
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

RCT_EXPORT_METHOD(getFiberSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
   [self dietary_getFiberSamples:input callback:callback];
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
    [self _initializeHealthStore];
    [self getWater:input callback:callback];
}

RCT_EXPORT_METHOD(saveHeartRateSample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self vitals_saveHeartRateSample:input callback:callback];
}

RCT_EXPORT_METHOD(getWaterSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self getWaterSamples:input callback:callback];
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

RCT_EXPORT_METHOD(saveBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self vitals_saveBloodPressureSamples:input callback:callback];
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

RCT_EXPORT_METHOD(getInsulinDeliverySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_getInsulinDeliverySamples:input callback:callback];
}

RCT_EXPORT_METHOD(saveInsulinDeliverySample:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_saveInsulinDeliverySample:input callback:callback];
}

RCT_EXPORT_METHOD(deleteInsulinDeliverySample:(NSString *)oid callback:(RCTResponseSenderBlock)callback)
{
    [self _initializeHealthStore];
    [self results_deleteInsulinDeliverySample:oid callback:callback];
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

RCT_EXPORT_METHOD(getMedicationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self clinics_getMedications:input callback:callback];
}

RCT_EXPORT_METHOD(getConditionRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self clinics_getConditions:input callback:callback];
}

RCT_EXPORT_METHOD(getAllergyRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self clinics_getAllergyRecords:input callback:callback];
}
RCT_EXPORT_METHOD(getImmunizationRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self clinics_getImmunizationRecords:input callback:callback];
}
RCT_EXPORT_METHOD(getProcedureRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self clinics_getProcedureRecords:input callback:callback];
}
RCT_EXPORT_METHOD(getLabRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self clinics_getLabRecords:input callback:callback];
}
RCT_EXPORT_METHOD(getClinicalVitalRecords:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self clinics_getClinicalVitalsRecords:input callback:callback];
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

        @try {
            [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSString *errMsg = [NSString stringWithFormat:@"Error with HealthKit authorization: %@", error];
                    NSLog(@"%@", errMsg);
                    callback(@[RCTMakeError(errMsg, nil, nil)]);
                    return;
                } else {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        callback(@[[NSNull null], @true]);
                    });
                }
            }];
        } @catch (NSException *exception) {
            NSString *errMsg = [NSString stringWithFormat:@"initHealthKit raised an exception: %@", exception.reason];
            NSLog(@"%@", errMsg);
            callback(@[RCTMakeError(errMsg, nil, nil)]);
        }
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
        @"SleepAnalysis",
        @"InsulinDelivery"
    ];
    
    NSArray *templates = @[@"healthKit:%@:new", @"healthKit:%@:failure", @"healthKit:%@:enabled", @"healthKit:%@:sample", @"healthKit:%@:setup:success", @"healthKit:%@:setup:failure", @"healthKit:%@:delta"];
    
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
            readPermsArray = [[self getReadPermsFromOptions:readPermsNamesArray] allObjects];
            writePermsArray = [[self getWritePermsFromOptions:writePermsNamesArray] allObjects];
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
// Maps @helloheart/core HealthMetric enum values to the HK type string passed to
// fitness_registerObserver. Every entry here must also appear in allFitnessObservers.
// Metrics with no HK observer type (totalCholesterol, hdlCholesterol, ldlCholesterol,
// triglycerides) are intentionally absent — they come from clinical records only.
// bloodPressure maps to BloodPressureSystolic as a proxy: any new BP reading writes
// both systolic and diastolic simultaneously, so the systolic observer fires reliably.
+ (NSDictionary<NSString *, NSString *> *)healthMetricToHKTypeMap {
    return @{
        @"heartRate":        @"HeartRate",
        @"restingHeartRate": @"RestingHeartRate",
        @"hrv":              @"HeartRateVariabilitySDNN",
        @"steps":            @"StepCount",
        @"activeEnergy":     @"ActiveEnergyBurned",
        @"sleep":            @"SleepAnalysis",
        @"vo2Max":           @"Vo2Max",
        @"spO2":             @"OxygenSaturation",
        @"respiratoryRate":  @"RespiratoryRate",
        @"bodyTemperature":  @"BodyTemperature",
        @"weight":           @"BodyMass",
        @"height":           @"Height",
        @"bmi":              @"BodyMassIndex",
        @"bodyFat":          @"BodyFatPercentage",
        @"bloodGlucose":     @"BloodGlucose",
        @"bloodPressure":    @"BloodPressureSystolic",
    };
}

- (void)initializeBackgroundObservers:(RCTBridge *)bridge {
    NSArray *savedMetrics = [[NSUserDefaults standardUserDefaults] objectForKey:@"RNHealth_SyncMetrics"];
    [self initializeBackgroundObservers:bridge metrics:savedMetrics];
}

- (void)initializeBackgroundObservers:(RCTBridge *)bridge metrics:(NSArray<NSString *> *)metrics {
    os_unfair_lock_lock(&_initLock);
    if (_observersInitialized) {
        os_unfair_lock_unlock(&_initLock);
        return;
    }

    [self _initializeHealthStore];

    if (bridge) self.bridge = bridge;

    if ([HKHealthStore isHealthDataAvailable]) {
        NSArray *allFitnessObservers = @[
            @"ActiveEnergyBurned",
            @"BasalEnergyBurned",
            @"BloodGlucose",
            @"BloodPressureSystolic",
            @"BodyFatPercentage",
            @"BodyMass",
            @"BodyMassIndex",
            @"BodyTemperature",
            @"Cycling",
            @"HeartRate",
            @"HeartRateVariabilitySDNN",
            @"Height",
            @"MindfulSession",
            @"OxygenSaturation",
            @"RespiratoryRate",
            @"RestingHeartRate",
            @"Running",
            @"SleepAnalysis",
            @"StairClimbing",
            @"StepCount",
            @"Swimming",
            @"Vo2Max",
            @"Walking",
            @"Workout",
        ];

        NSArray *fitnessToRegister;
        if (metrics.count > 0) {
            // Convert JS HealthMetric values → native HK type strings
            NSDictionary *map = [RCTAppleHealthKit healthMetricToHKTypeMap];
            NSMutableSet *requestedHKTypes = [NSMutableSet set];
            for (NSString *metric in metrics) {
                NSString *hkType = map[metric];
                if (hkType) {
                    [requestedHKTypes addObject:hkType];
                } else {
                    NSLog(@"[HealthKit] Unknown metric '%@' — not in healthMetricToHKTypeMap, skipping", metric);
                }
            }
            fitnessToRegister = [allFitnessObservers filteredArrayUsingPredicate:
                [NSPredicate predicateWithBlock:^BOOL(NSString *type, NSDictionary *_) {
                    return [requestedHKTypes containsObject:type];
                }]];
            NSLog(@"[HealthKit] Registering observers for %lu metrics: %@",
                  (unsigned long)fitnessToRegister.count,
                  [fitnessToRegister componentsJoinedByString:@", "]);
        } else {
            fitnessToRegister = allFitnessObservers;
        }

        for (NSString *type in fitnessToRegister) {
            [self fitness_registerObserver:type bridge:bridge];
        }

        if (metrics.count > 0 && fitnessToRegister.count == 0) {
            NSLog(@"[HealthKit] WARNING — no observers registered: none of the requested metrics have an HK observer type. "
                  @"Unsupported metrics (e.g. totalCholesterol, triglycerides) come from clinical records only. "
                  @"Requested: %@", [metrics componentsJoinedByString:@", "]);
            // _observersInitialized intentionally NOT set — allows retry if the caller
            // provides a corrected metrics list in a subsequent configureBackgroundSync call.
            os_unfair_lock_unlock(&_initLock);
            return;
        }

        // Clinical observers and InsulinDelivery are skipped when a specific metrics
        // list is provided — they would fire background wakes for unauthorized types.
        // When metrics is nil (register all), they are included as before.
        if (metrics.count == 0) {
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

            for (NSString *type in clinicalObservers) {
                [self clinical_registerObserver:type bridge:bridge];
            }

            [self results_registerObservers:bridge];
        }

        NSLog(@"[HealthKit] Background observers added to the app");
        [self startObserving];
    } else {
        NSLog(@"[HealthKit] Apple HealthKit is not available in this platform");
    }

    _observersInitialized = YES;
    os_unfair_lock_unlock(&_initLock);
}

// Will be called when this module's first listener is added.
-(void)startObserving {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    for (NSString *notificationName in [self supportedEvents]) {
        [center removeObserver:self name:notificationName object:nil];
        [center addObserver:self
               selector:@selector(emitEventInternal:)
                   name:notificationName
                 object:nil];
    }
    self.hasListeners = YES;
}

- (void)emitEventInternal:(NSNotification *)notification {
  if (self.hasListeners && self.bridge) {
    self.callableJSModules = [RCTAppleHealthKit sharedJsModule];
    [self.callableJSModules setBridge:self.bridge];
    [self sendEventWithName:notification.name
                   body:notification.userInfo];
  }
}

- (void)emitEventWithName:(NSString *)name andPayload:(NSDictionary *)payload {
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                    object:self
                                                  userInfo:payload];
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    self.hasListeners = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
