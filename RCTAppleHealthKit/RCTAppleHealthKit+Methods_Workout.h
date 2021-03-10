//
//  RCTAppleHealthKit+Methods_Workout.h
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Workout)

- (void)workout_getAnchoredQuery:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)workout_save: (NSDictionary *)input callback: (RCTResponseSenderBlock)callback;

@end
