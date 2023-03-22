//
//  RCTAppleHealthKit+TypesForMedianStatistic.m
//  RNAppleHealthKit
//
//  Created by Anastasia Mishur on 22.03.23.
//

#import "RCTAppleHealthKit+TypesForMedianStatistic.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"

@implementation RCTAppleHealthKit (TypesForMedianStatistic)

- (nullable HKSampleType *)getObjectFromText:(nonnull NSString*)key {
    HKSampleType * _Nullable sample = (HKSampleType *)[self getReadPermFromText:key];
    if (sample != nil) {
        return sample;
    } else {
        HKSampleType * _Nullable workoutObject = (HKSampleType *)[self getObjectForActivityType:key];
        return workoutObject;
    }
}

- (nullable HKObjectType *)getObjectForActivityType:(nonnull NSString*)key {
    UIDevice *deviceInfo = [UIDevice currentDevice];
    float systemVersion = deviceInfo.systemVersion.floatValue;

    // documented lower iOS version
    if (systemVersion < 8.0) {
        return nil;
    }

    if ([@"AmericanFootball" isEqualToString: key] ||
        [@"Archery" isEqualToString: key] ||
        [@"AustralianFootball" isEqualToString: key] ||
        [@"Badminton" isEqualToString: key] ||
        [@"Baseball" isEqualToString: key] ||
        [@"Basketball" isEqualToString: key] ||
        [@"Bowling" isEqualToString: key] ||
        [@"Boxing" isEqualToString: key] ||
        [@"Climbing" isEqualToString: key] ||
        [@"Cricket" isEqualToString: key] ||
        [@"CrossTraining" isEqualToString: key] ||
        [@"Curling" isEqualToString: key] ||
        [@"Cycling" isEqualToString: key] ||
        [@"Elliptical" isEqualToString: key] ||
        [@"EquestrianSports" isEqualToString: key] ||
        [@"Fencing" isEqualToString: key] ||
        [@"Fishing" isEqualToString: key] ||
        [@"FunctionalStrengthTraining" isEqualToString: key] ||
        [@"Golf" isEqualToString: key] ||
        [@"Gymnastics" isEqualToString: key] ||
        [@"Handball" isEqualToString: key] ||
        [@"Hiking" isEqualToString: key] ||
        [@"Hockey" isEqualToString: key] ||
        [@"Hunting" isEqualToString: key] ||
        [@"Lacrosse" isEqualToString: key] ||
        [@"MartialArts" isEqualToString: key] ||
        [@"MindAndBody" isEqualToString: key] ||
        [@"PaddleSports" isEqualToString: key] ||
        [@"Play" isEqualToString: key] ||
        [@"PreparationAndRecovery" isEqualToString: key] ||
        [@"Racquetball" isEqualToString: key] ||
        [@"Rowing" isEqualToString: key] ||
        [@"Rugby" isEqualToString: key] ||
        [@"Running" isEqualToString: key] ||
        [@"Sailing" isEqualToString: key] ||
        [@"SkatingSports" isEqualToString: key] ||
        [@"SnowSports" isEqualToString: key] ||
        [@"Soccer" isEqualToString: key] ||
        [@"Softball" isEqualToString: key] ||
        [@"Squash" isEqualToString: key] ||
        [@"StairClimbing" isEqualToString: key] ||
        [@"SurfingSports" isEqualToString: key] ||
        [@"Swimming" isEqualToString: key] ||
        [@"TableTennis" isEqualToString: key] ||
        [@"Tennis" isEqualToString: key] ||
        [@"TrackAndField" isEqualToString: key] ||
        [@"TraditionalStrengthTraining" isEqualToString: key] ||
        [@"Volleyball" isEqualToString: key] ||
        [@"Walking" isEqualToString: key] ||
        [@"WaterFitness" isEqualToString: key] ||
        [@"WaterPolo" isEqualToString: key] ||
        [@"WaterSports" isEqualToString: key] ||
        [@"Wrestling" isEqualToString: key] ||
        [@"Yoga" isEqualToString: key]) {
        return [HKObjectType workoutType];
    }

    if ([@"Barre" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"CoreTraining" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"CrossCountrySkiing" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"DownhillSkiing" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"Flexibility" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"HighIntensityIntervalTraining" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"JumpRope" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"Kickboxing" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"Pilates" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"Snowboarding" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"Stairs" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"StepTraining" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"WheelchairWalkPace" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"WheelchairRunPace" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    }

    if ([@"TaiChi" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType workoutType];
    } else if ([@"MixedCardio" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType workoutType];
    } else if ([@"HandCycling" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType workoutType];
    }

    if ([@"DiscSports" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType workoutType];
    } else if ([@"FitnessGaming" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType workoutType];
    }

    if ([@"CardioDance" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType workoutType];
    } else if ([@"Cooldown" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType workoutType];
    } else if ([@"Pickleball" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType workoutType];
    } else if ([@"SocialDance" isEqualToString: key] && systemVersion >= 14.0) {
       return [HKObjectType workoutType];
    }

    if ([@"HKWorkoutActivityTypeSwimBikeRun" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType workoutType];
    }

    return nil;
}

@end
