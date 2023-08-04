#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNHealthKitWrapper, NSObject)
RCT_EXTERN_METHOD(initHealthKit:(NSArray)read write: (NSArray)write  resolve: (RCTPromiseResolveBlock)resolve reject: (RCTPromiseRejectBlock)reject);
@end
