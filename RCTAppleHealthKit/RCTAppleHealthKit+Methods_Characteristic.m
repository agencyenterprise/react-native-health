//
//  RCTAppleHealthKit+Methods_Characteristic.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-29.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Characteristic.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Characteristic)


- (void)characteristic_getBiologicalSex:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    HKBiologicalSexObject *bioSex = [self.healthStore biologicalSexWithError:&error];
    NSString *value;

    switch (bioSex.biologicalSex) {
        case HKBiologicalSexNotSet:
            value = @"unknown";
            break;
        case HKBiologicalSexFemale:
            value = @"female";
            break;
        case HKBiologicalSexMale:
            value = @"male";
            break;
        case HKBiologicalSexOther:
            value = @"other";
            break;
    }

    if(value == nil){
        NSLog(@"error getting biological sex: %@", error);
        callback(@[RCTMakeError(@"error getting biological sex", error, nil)]);
        return;
    }

    NSDictionary *response = @{
            @"value" : value,
    };

    callback(@[[NSNull null], response]);
}


- (void)characteristic_getDateOfBirth:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    NSDate *dob = [self.healthStore dateOfBirthWithError:&error];

    if(error != nil){
        NSLog(@"error getting date of birth: %@", error);
        callback(@[RCTMakeError(@"error getting date of birth", error, nil)]);
        return;
    }
    if(dob == nil) {
        NSDictionary *response = @{
                                   @"value" : [NSNull null],
                                   @"age" : [NSNull null]
                                   };
        callback(@[[NSNull null], response]);
        return;
    }

    NSString *dobString = [RCTAppleHealthKit buildISO8601StringFromDate:dob];

    NSDate *now = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:dob toDate:now options:NSCalendarWrapComponents];
    NSUInteger ageInYears = ageComponents.year;

    NSDictionary *response = @{
            @"value" : dobString,
            @"age" : @(ageInYears),
    };

    callback(@[[NSNull null], response]);
}

@end
