//
//  RCTAppleHealthKit.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"
#import "RCTAppleHealthKit+Utils.h"

#import "RCTAppleHealthKit+Methods_Body.h"
#import "RCTAppleHealthKit+Methods_Fitness.h"

@implementation RCTAppleHealthKit

RCT_EXPORT_MODULE();


RCT_EXPORT_METHOD(isAvailable:(RCTResponseSenderBlock)callback)
{
    [self isHealthKitAvailable:callback];
}

RCT_EXPORT_METHOD(initHealthKit:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self initializeHealthKit:input callback:callback];
}

RCT_EXPORT_METHOD(getCurrentWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self body_getCurrentWeight:input callback:callback];
}

RCT_EXPORT_METHOD(saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self body_saveWeight:input callback:callback];
}

RCT_EXPORT_METHOD(getStepCountForToday:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self fitness_getStepCountForToday:input callback:callback];
}

RCT_EXPORT_METHOD(getInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self getModuleInfo:input callback:callback];
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
    self.healthStore = [[HKHealthStore alloc] init];
    
    if ([HKHealthStore isHealthDataAvailable]) {
        
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
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
        }
        
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                callback(@[RCTMakeError(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", nil, nil)]);
                return;
            } else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    callback(@[[NSNull null], @true]);
                });
            }
        }];
    } else {
        callback(@[RCTMakeError(@"HealthKit not available....", nil, nil)]);
    }
}

//
//- (void)getHealthKitUserWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
//{
////    NSMassFormatter *massFormatter = [[NSMassFormatter alloc] init];
////    massFormatter.unitStyle = NSFormattingUnitStyleLong;
//
//    //    NSMassFormatterUnit weightFormatterUnit = NSMassFormatterUnitPound;
//    //    NSString *weightUnitString = [massFormatter unitStringFromValue:10 unit:weightFormatterUnit];
//    //    NSString *localizedWeightUnitDescriptionFormat = NSLocalizedString(@"Weight (%@)", nil);
//
//    // Query to get the user's latest weight, if it exists.
//    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
//
//    [self fetchMostRecentQuantitySampleOfType:weightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
//        if (!mostRecentQuantity) {
//            NSLog(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.");
//            callback(@[RCTMakeError(@"Either an error occured fetching the user's weight information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
//        }
//        else {
//            // Determine the weight in the required unit.
//            HKUnit *weightUnit = [HKUnit poundUnit];
//            double usersWeight = [mostRecentQuantity doubleValueForUnit:weightUnit];
//
//            callback(@[[NSNull null], @(usersWeight)]);
//        }
//    }];
//}

//
//- (void)saveHealthKitUserWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
//{
//    double weight= [[input objectForKey:@"weight"] doubleValue];
//
//    HKUnit *poundUnit = [HKUnit poundUnit];
//    HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:poundUnit doubleValue:weight];
//
//    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
//    NSDate *now = [NSDate date];
//
//    HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:now endDate:now];
//
//    [self.healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
//        if (!success) {
//            NSLog(@"An error occured saving the weight sample %@. In your app, try to handle this gracefully. The error was: %@.", weightSample, error);
//            callback(@[RCTMakeError(@"An error occured saving the weight sample", nil, nil)]);
//            return;
//            // abort();
//        }
//        callback(@[[NSNull null], @(weight)]);
//    }];
//}


//- (void)getHealthKitUserStepCount:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
//{
//    HKQuantityType *stepCountType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
//    HKUnit *stepsUnit = [HKUnit countUnit];
//
//    [self fetchSumOfSamplesTodayForType:stepCountType unit:stepsUnit completion:^(double totalSteps, NSError *error) {
//        if (!totalSteps) {
//            NSLog(@"Either an error occured fetching the user's step count information or none has been stored yet. In your app, try to handle this gracefully.");
//            callback(@[RCTMakeError(@"Either an error occured fetching the user's step count information or none has been stored yet. In your app, try to handle this gracefully.", nil, nil)]);
//            return;
//        }
//
//        callback(@[[NSNull null], @(totalSteps)]);
//    }];
//}



- (void)getModuleInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    callback(@[[NSNull null], @"ReactNative Apple HealthKit Native Module. Created By Greg Wilson."]);
}




@end
