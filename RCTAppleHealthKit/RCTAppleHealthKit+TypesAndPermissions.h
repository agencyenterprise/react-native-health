//
//  RCTAppleHealthKit+TypesAndPermissions.h
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  Copyright © 2016 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (TypesAndPermissions)

- (NSSet *)getReadPermsFromOptions:(NSArray *)options;
- (NSSet *)getWritePermsFromOptions:(NSArray *)options;

@end
