//
//  RCTAppleHealthKit+Methods_Workout.h
//  RCTAppleHealthKit
//
//  Created by Ahmed Fathy Ghazy on 4/27/18.
//  Copyright © 2018 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Workout)

-(void)workout_get:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
-(void)workout_save: (NSDictionary *)input callback: (RCTResponseSenderBlock)callback;

@end