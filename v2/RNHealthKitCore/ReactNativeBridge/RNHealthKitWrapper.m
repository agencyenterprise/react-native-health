#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNHealthKitWrapper, NSObject)
RCT_EXTERN_METHOD(initHealthKit:(NSArray)read write: (NSArray)write  resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
RCT_EXTERN_METHOD(getQuantitySamples:(NSString)type query: (NSDictionary)query  resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
RCT_EXTERN_METHOD(getQuantitySamplesAggregation:(NSString)type query: (NSDictionary)query  resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
RCT_EXTERN_METHOD(saveQuantitySample:(NSString)type sample: (NSDictionary)sample resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
@end
