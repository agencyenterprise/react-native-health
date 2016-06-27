//
//  RCTAppleHealthKit+Methods_Body.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Body)

- (void)body_getCurrentWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)body_saveWeight:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
