//
//  RCTAppleHealthKit.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTUtils.h>
#import <React/RCTLog.h>

@interface RCTAppleHealthKit : NSObject <RCTBridgeModule>

@property (nonatomic) HKHealthStore *healthStore;
@property BOOL isSync;

- (void)isHealthKitAvailable:(RCTResponseSenderBlock)callback;
- (void)initializeHealthKit:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)checkPermission:(NSString *)input callback:(RCTResponseSenderBlock)callback;
- (void)getModuleInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
