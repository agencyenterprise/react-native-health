#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNHealthKitWrapper, NSObject)
RCT_EXTERN_METHOD(initHealthKit:(NSArray)read write: (NSArray)write  resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
RCT_EXTERN_METHOD(getQuantitySamples:(NSDictionary)query  resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
RCT_EXTERN_METHOD(getQuantitySamplesAggregation:(NSDictionary)query  resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
RCT_EXTERN_METHOD(saveQuantitySample:(NSDictionary)sample resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);

+ (BOOL)requiresMainQueueSetup
{
  return YES;
}

@end
