//
//  RCTAppleHealthKit.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTUtils.h>
#import <React/RCTLog.h>
#import <React/RCTEventDispatcher.h>

@interface RCTAppleHealthKit : RCTEventEmitter <RCTBridgeModule>

@property (nonatomic) HKHealthStore *healthStore;
@property (nonatomic, assign) BOOL hasListeners;

- (HKHealthStore *)_initializeHealthStore;
- (void)isHealthKitAvailable:(RCTResponseSenderBlock)callback;
- (void)initializeHealthKit:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)checkPermission:(NSString *)input callback:(RCTResponseSenderBlock)callback;
- (void)getModuleInfo:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)getAuthorizationStatus:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)initializeBackgroundObservers:(RCTBridge *)bridge;

@end
