//
//  RCTAppleHealthKit+Methods_Characteristic.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
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
        callback(@[RCTJSErrorFromNSError(error)]);
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
        callback(@[RCTJSErrorFromNSError(error)]);
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

- (void)characteristic_getBloodType:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    NSError *error;
    HKBloodTypeObject *bioBlood = [self.healthStore bloodTypeWithError:&error];
    NSString *value;

    switch (bioBlood.bloodType) {
        case HKBloodTypeNotSet:
            value = @"unknown";
            break;
        case HKBloodTypeAPositive:
            value = @"A+";
            break;
        case HKBloodTypeANegative:
            value = @"A-";
            break;
        case HKBloodTypeBPositive:
            value = @"B+";
            break;
        case HKBloodTypeBNegative:
            value = @"B-";
            break;
        case HKBloodTypeABPositive:
            value = @"AB+";
            break;
        case HKBloodTypeABNegative:
            value = @"AB-";
            break;
        case HKBloodTypeOPositive:
            value = @"O+";
            break;
        case HKBloodTypeONegative:
            value = @"O-";
            break;
    }

    if(value == nil){
        callback(@[RCTJSErrorFromNSError(error)]);
        return;
    }

    NSDictionary *response = @{
            @"value" : value,
    };

    callback(@[[NSNull null], response]);
}

@end
