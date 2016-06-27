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

RCT_EXPORT_METHOD(getLatestBmi:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback)
{
    [self body_getLatestBodyMassIndex:input callback:callback];
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
            callback(@[RCTMakeError(@"at least 1 write or read permission must be set in options.permissions", nil, nil)]);
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
        callback(@[RCTMakeError(@"HealthKit not available....", nil, nil)]);
    }
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


@end
