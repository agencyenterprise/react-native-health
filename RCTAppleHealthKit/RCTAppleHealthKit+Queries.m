//
//  RCTAppleHealthKit+Queries.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Queries)

- (void)fetchWorkoutById:(HKSampleType *)type
                      unit:(HKUnit *)unit
                 predicate:(NSPredicate *)predicate
                 ascending:(BOOL)asc
                     limit:(NSUInteger)lim
                completion:(void (^)(NSArray *, NSError *))completion {
    
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate
                                                                       ascending:asc];

    void (^handlerBlock)(HKSampleQuery *query, NSArray *results, NSError *error);
    handlerBlock = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        if (completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if (type == [HKObjectType workoutType]) {
                    for (HKWorkout *sample in results) {
                        @try {
                            [data addObject:sample];
                        } @catch (NSException *exception) {
                            NSLog(@"RNHealth: An error occured while trying to add sample from: %@ ", [[[sample sourceRevision] source] bundleIdentifier]);
                        }
                    }
                } else {
                    NSLog(@"RNHealth: Must be workout type ");
                }
                
                completion(data, error);
            });
        }
    };
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:type
                                                           predicate:predicate
                                                               limit:lim
                                                     sortDescriptors:@[timeSortDescriptor]
                                                      resultsHandler:handlerBlock];
    
    [self.healthStore executeQuery:query];
}

- (void)fetchWorkoutRoute:(HKSampleType *)type
                predicate:(NSPredicate *)predicate
                   anchor:(HKQueryAnchor *)anchor
                    limit:(NSUInteger)lim
               completion:(void (^)(NSDictionary *, NSError *))completion {

    void (^handlerBlock)(HKAnchoredObjectQuery *query, NSArray<__kindof HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error);
    handlerBlock = ^(HKAnchoredObjectQuery *query, NSArray<__kindof HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error) {
        
        if (!sampleObjects || sampleObjects == nil || [sampleObjects count] == 0) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        if (completion) {
            
            //init store for locations
            NSMutableArray *locations = [NSMutableArray arrayWithCapacity:1];
            
            //only one route should return in the samples
            for(HKWorkoutRoute*routeSample in sampleObjects){
                
            //create and assign the block to fetch locations
            void(^locationsHandlerBlock)(HKWorkoutRouteQuery* query, NSArray<CLLocation*>* routeData, BOOL done, NSError* error);
            
            locationsHandlerBlock = ^(HKWorkoutRouteQuery* query, NSArray<CLLocation*>* routeData, BOOL done, NSError* error)
            {
                
                if(!routeData){
                    //no data associated with route
                    if(done){
                        //error occured
                        completion(nil, error);
                    }
                    return;
                }
                
                //process each batch and store
                for (CLLocation *sample in routeData) {
                    @try {
                        double lat = sample.coordinate.latitude;
                        double lng = sample.coordinate.longitude;
                        double alt = sample.altitude;
                        NSString*timestamp = [RCTAppleHealthKit buildISO8601StringFromDate:sample.timestamp];
                        
                        NSDictionary *elem = @{
                            @"latitude" :@(lat),
                            @"longitude": @(lng),
                            @"altitude": @(alt),
                            @"timestamp": timestamp,
                            @"speed": @(sample.speed),
                            @"speedAccuracy": @(sample.speedAccuracy)
                        };
                        
                        [locations addObject:elem];
                    } @catch (NSException *exception) {
                        NSLog(@"RNHealth: An error occured while trying to add route sample from: %@ ", [[[routeSample sourceRevision] source] bundleIdentifier]);
                    }
                }
                
                if(done) {
                    //all batches successfully completed
                    NSString *anchorString = @"";
                    if (newAnchor != nil) {
                        NSError *archiveError = nil;
                        NSData *anchorData = [NSKeyedArchiver archivedDataWithRootObject:newAnchor requiringSecureCoding:YES error:&archiveError];
                        if (archiveError) {
                            NSLog(@"RNHealth: Failed to archive route anchor: %@", archiveError);
                            return;
                        }
                        anchorString = [anchorData base64EncodedStringWithOptions:0];
                    }
                    NSString *start = [RCTAppleHealthKit buildISO8601StringFromDate:routeSample.startDate];
                    NSString *end = [RCTAppleHealthKit buildISO8601StringFromDate:routeSample.endDate];
                    
                    HKDevice *dev = routeSample.device;
                    NSDictionary *deviceDict = @{
                        @"name":            dev.model                                  ?: [NSNull null],
                        @"model":           [[routeSample sourceRevision] productType] ?: [NSNull null],
                        @"hardwareVersion": dev.hardwareVersion                        ?: [NSNull null],
                        @"softwareVersion": dev.softwareVersion                        ?: [NSNull null],
                    };


                    NSObject*metaData = [routeSample metadata] ? [routeSample metadata] : @{};

                    NSDictionary *routeElem = @{
                        @"id" : [[routeSample UUID] UUIDString],
                        @"sourceId": [[[routeSample sourceRevision] source] bundleIdentifier],
                        @"sourceName" : [[[routeSample sourceRevision] source] name],
                        @"metadata" : metaData,
                        @"device": deviceDict,
                        @"start": start,
                        @"end":end,
                        @"locations": locations
                    };
                    
                    
                    completion(@{
                            @"anchor": anchorString,
                            @"data": routeElem,
                        }, error);
                }
            
            };
                
                HKWorkoutRouteQuery* routeQuery = [[HKWorkoutRouteQuery alloc] initWithRoute:routeSample
                                                                                 dataHandler:locationsHandlerBlock];
                [self.healthStore executeQuery:routeQuery];
            
            }
            
        }
    };
    
    HKAnchoredObjectQuery *query = [[HKAnchoredObjectQuery alloc] initWithType:type
                                                                     predicate:predicate
                                                                        anchor:anchor
                                                                         limit:HKObjectQueryNoLimit
                                                                resultsHandler:handlerBlock
    ];
    
    [self.healthStore executeQuery:query];
}

- (void)fetchMostRecentQuantitySampleOfType:(HKQuantityType *)quantityType
                                  predicate:(NSPredicate *)predicate
                                 completion:(void (^)(HKQuantity *, NSDate *, NSDate *, NSError *))completion {

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc]
            initWithKey:HKSampleSortIdentifierEndDate
              ascending:NO
    ];

    HKSampleQuery *query = [[HKSampleQuery alloc]
            initWithSampleType:quantityType
                     predicate:predicate
                         limit:1
               sortDescriptors:@[timeSortDescriptor]
                resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {

                      if (!results) {
                          if (completion) {
                              completion(nil, nil, nil, error);
                          }
                          return;
                      }

                      if (completion) {
                          HKQuantitySample *quantitySample = results.firstObject;
                          HKQuantity *quantity = quantitySample.quantity;
                          NSDate *startDate = quantitySample.startDate;
                          NSDate *endDate = quantitySample.endDate;
                          completion(quantity, startDate, endDate, error);
                      }
                }
    ];
    [self.healthStore executeQuery:query];
}

- (void)fetchQuantitySamplesOfType:(HKQuantityType *)quantityType
                              unit:(HKUnit *)unit
                         predicate:(NSPredicate *)predicate
                         ascending:(BOOL)asc
                             limit:(NSUInteger)lim
                  includeManuallyAdded:(BOOL)includeManuallyAdded
                        completion:(void (^)(NSArray *, NSError *))completion {

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate
                                                                       ascending:asc];

    void (^handlerBlock)(HKSampleQuery *query, NSArray *results, NSError *error);
    handlerBlock = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }

        if (completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                for (HKQuantitySample *sample in results) {
                    if (!includeManuallyAdded && sample.metadata && [sample.metadata[HKMetadataKeyWasUserEntered] boolValue]) {
                        continue;
                    }
                    HKQuantity *quantity = sample.quantity;
                    double value = [quantity doubleValueForUnit:unit];
                    NSString *unitString = [RCTAppleHealthKit normalizeUnitString:[unit unitString]];

                    NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                    NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

                    NSMutableDictionary *elem = [NSMutableDictionary dictionaryWithDictionary:@{
                            @"value" : @(value),
                            @"unit" : unitString ?: [NSNull null],
                            @"id" : [[sample UUID] UUIDString] ?: [NSNull null],
                            @"sourceName" : [[[sample sourceRevision] source] name] ?: [NSNull null],
                            @"sourceId" : [[[sample sourceRevision] source] bundleIdentifier] ?: [NSNull null],
                            @"startDate" : startDateString,
                            @"endDate" : endDateString,
                    }];

                    HKDevice *dev = sample.device;
                    NSDictionary *deviceDict = @{
                        @"name":            dev.model                               ?: [NSNull null],
                        @"model":           [[sample sourceRevision] productType]   ?: [NSNull null],
                        @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                        @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                    };
                    elem[@"device"] = deviceDict;

                    NSDictionary *metadata = [sample metadata];
                    if (metadata) {
                        [elem setValue:metadata forKey:kMetadataKey];
                    }

                    [data addObject:elem];
                }

                completion(data, error);
            });
        }
    };

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType
                                                           predicate:predicate
                                                               limit:lim
                                                     sortDescriptors:@[timeSortDescriptor]
                                                      resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

- (void)fetchSamplesOfType:(HKSampleType *)type
                      unit:(HKUnit *)unit
                 predicate:(NSPredicate *)predicate
                 ascending:(BOOL)asc
                     limit:(NSUInteger)lim
                completion:(void (^)(NSArray *, NSError *))completion {

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate
                                                                       ascending:asc];

    // declare the block
    void (^handlerBlock)(HKSampleQuery *query, NSArray *results, NSError *error);

    // create and assign the block
    handlerBlock = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }

        if (completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if (type == [HKObjectType workoutType]) {
                    for (HKWorkout *sample in results) {
                        @try {
                            double energy =  [[sample totalEnergyBurned] doubleValueForUnit:[HKUnit kilocalorieUnit]];
                            double distance = [[sample totalDistance] doubleValueForUnit:[HKUnit mileUnit]];
                            NSString *type = [RCTAppleHealthKit stringForHKWorkoutActivityType:[sample workoutActivityType]];

                            NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                            NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

                            bool isTracked = true;
                            if ([[sample metadata][HKMetadataKeyWasUserEntered] intValue] == 1) {
                                isTracked = false;
                            }

                            HKDevice *dev = sample.device;
                            NSDictionary *deviceDict = @{
                                @"name":            dev.model                               ?: [NSNull null],
                                @"model":           [[sample sourceRevision] productType]   ?: [NSNull null],
                                @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                                @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                            };

                            NSDictionary *elem = @{
                                                   @"activityId" : [NSNumber numberWithInt:[sample workoutActivityType]],
                                                   @"id" : [[sample UUID] UUIDString],
                                                   @"activityName" : type,
                                                   @"calories" : @(energy),
                                                   @"tracked" : @(isTracked),
                                                   @"metadata" : [sample metadata] ? [sample metadata] : [NSNull null],
                                                   @"sourceName" : [[[sample sourceRevision] source] name],
                                                   @"sourceId" : [[[sample sourceRevision] source] bundleIdentifier],
                                                   @"device": deviceDict,
                                                   @"distance" : @(distance),
                                                   @"start" : startDateString,
                                                   @"end" : endDateString
                                                   };

                            [data addObject:elem];
                        } @catch (NSException *exception) {
                            NSLog(@"RNHealth: An error occured while trying to add sample from: %@ ", [[[sample sourceRevision] source] bundleIdentifier]);
                        }
                    }
                } else {
                    for (HKQuantitySample *sample in results) {
                        @try {
                            HKQuantity *quantity = sample.quantity;
                            double value = [quantity doubleValueForUnit:unit];

                            NSString * valueType = @"quantity";
                            if (unit == [HKUnit mileUnit]) {
                                valueType = @"distance";
                            }

                            NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                            NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

                            bool isTracked = true;
                            if ([[sample metadata][HKMetadataKeyWasUserEntered] intValue] == 1) {
                                isTracked = false;
                            }

                            HKDevice *dev = sample.device;
                            NSDictionary *deviceDict = @{
                                @"name":            dev.model                               ?: [NSNull null],
                                @"model":           [[sample sourceRevision] productType]   ?: [NSNull null],
                                @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                                @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                            };

                            NSDictionary *elem = @{
                                                   valueType : @(value),
                                                   @"tracked" : @(isTracked),
                                                   @"sourceName" : [[[sample sourceRevision] source] name],
                                                   @"sourceId" : [[[sample sourceRevision] source] bundleIdentifier],
                                                   @"device": deviceDict,
                                                   @"start" : startDateString,
                                                   @"end" : endDateString
                                                   };

                            [data addObject:elem];
                        } @catch (NSException *exception) {
                            NSLog(@"RNHealth: An error occured while trying to add sample from: %@ ", [[[sample sourceRevision] source] bundleIdentifier]);
                        }
                    }
                }

                completion(data, error);
            });
        }
    };

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:type
                                                           predicate:predicate
                                                               limit:lim
                                                     sortDescriptors:@[timeSortDescriptor]
                                                      resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

- (void)fetchClinicalRecordsOfType:(HKClinicalType *)type
                         predicate:(NSPredicate *)predicate
                         ascending:(BOOL)asc
                             limit:(NSUInteger)lim
                        completion:(void (^)(NSArray *, NSError *))completion {
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:asc];

    void (^handlerBlock)(HKSampleQuery *query, NSArray *results, NSError *error);

    handlerBlock = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        if (completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (HKClinicalRecord *record in results) {
                    NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:record.startDate];
                    NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:record.endDate];

                    NSError *jsonE = nil;
                    NSArray *fhirData = [NSJSONSerialization JSONObjectWithData:record.FHIRResource.data options: NSJSONReadingMutableContainers error: &jsonE];

                    if (!fhirData) {
                      completion(nil, jsonE);
                    }

                    NSString *fhirRelease;
                    NSString *fhirVersion;
                    if (@available(iOS 14.0, *)) {
                        HKFHIRVersion *fhirResourceVersion = record.FHIRResource.FHIRVersion;
                        fhirRelease = fhirResourceVersion.FHIRRelease;
                        fhirVersion = fhirResourceVersion.stringRepresentation;
                    } else {
                        // iOS < 14 uses DSTU2
                        fhirRelease = @"DSTU2";
                        fhirVersion = @"1.0.2";
                    }

                    NSDictionary *elem = @{
                        @"id" : [[record UUID] UUIDString],
                        @"sourceName" : [[[record sourceRevision] source] name],
                        @"sourceId" : [[[record sourceRevision] source] bundleIdentifier],
                        @"startDate" : startDateString,
                        @"endDate" : endDateString,
                        @"displayName" : record.displayName,
                        @"fhirData": fhirData,
                        @"fhirRelease": fhirRelease,
                        @"fhirVersion": fhirVersion,
                    };
                    [data addObject:elem];
                }
                completion(data, error);
            });
        }
    };

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:type predicate:predicate limit:lim sortDescriptors:@[timeSortDescriptor] resultsHandler:handlerBlock];
    [self.healthStore executeQuery:query];
}

- (void)fetchAnchoredWorkouts:(HKSampleType *)type
                    predicate:(NSPredicate *)predicate
                       anchor:(HKQueryAnchor *)anchor
                        limit:(NSUInteger)lim
                   completion:(void (^)(NSDictionary *, NSError *))completion {

    // declare the block
    void (^handlerBlock)(HKAnchoredObjectQuery *query, NSArray<__kindof HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error);

    // create and assign the block
    handlerBlock = ^(HKAnchoredObjectQuery *query, NSArray<__kindof HKSample *> *sampleObjects, NSArray<HKDeletedObject *> *deletedObjects, HKQueryAnchor *newAnchor, NSError *error) {

        if (!sampleObjects) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }

        if (completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (HKWorkout *sample in sampleObjects) {
                    @try {
                        double energy =  [[sample totalEnergyBurned] doubleValueForUnit:[HKUnit kilocalorieUnit]];
                        double distance = [[sample totalDistance] doubleValueForUnit:[HKUnit mileUnit]];
                        NSString *type = [RCTAppleHealthKit stringForHKWorkoutActivityType:[sample workoutActivityType]];
                        NSArray *workoutEvents = [RCTAppleHealthKit formatWorkoutEvents:[sample workoutEvents]];
                        NSTimeInterval duration = [sample duration];

                        NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                        NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

                        bool isTracked = true;
                        if ([[sample metadata][HKMetadataKeyWasUserEntered] intValue] == 1) {
                            isTracked = false;
                        }

                        HKDevice *dev = sample.device;
                        NSDictionary *deviceDict = @{
                            @"name":            dev.model                               ?: [NSNull null],
                            @"model":           [[sample sourceRevision] productType]   ?: [NSNull null],
                            @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                            @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                        };

                        NSDictionary *elem = @{
                                               @"activityId" : [NSNumber numberWithInt:[sample workoutActivityType]],
                                               @"id" : [[sample UUID] UUIDString],
                                               @"activityName" : type,
                                               @"calories" : @(energy),
                                               @"tracked" : @(isTracked),
                                               @"metadata" : [sample metadata],
                                               @"sourceName" : [[[sample sourceRevision] source] name],
                                               @"sourceId" : [[[sample sourceRevision] source] bundleIdentifier],
                                               @"device": deviceDict,
                                               @"distance" : @(distance),
                                               @"start" : startDateString,
                                               @"end" : endDateString,
                                               @"duration": @(duration),
                                               @"workoutEvents": workoutEvents
                                               };

                        [data addObject:elem];
                    } @catch (NSException *exception) {
                        NSLog(@"RNHealth: An error occured while trying to add workout sample from: %@ ", [[[sample sourceRevision] source] bundleIdentifier]);
                    }
                }

                NSString *anchorString = @"";
                if (newAnchor != nil) {
                    NSError *archiveError = nil;
                    NSData *anchorData = [NSKeyedArchiver archivedDataWithRootObject:newAnchor requiringSecureCoding:YES error:&archiveError];
                    if (archiveError) {
                        NSLog(@"RNHealth: Failed to archive anchor: %@", archiveError);
                        completion(nil, archiveError);
                        return;
                    }
                    anchorString = [anchorData base64EncodedStringWithOptions:0];
                }
                completion(@{
                            @"anchor": anchorString,
                            @"data": data,
                        }, error);
            });
        }
    };

    HKAnchoredObjectQuery *query = [[HKAnchoredObjectQuery alloc] initWithType:type
                                                                     predicate:predicate
                                                                        anchor:anchor
                                                                         limit:lim
                                                                resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

- (void)fetchAnchoredSamplesOfType:(HKQuantityType *)quantityType
                              unit:(HKUnit *)unit
                         predicate:(NSPredicate *)predicate
                            anchor:(HKQueryAnchor *)anchor
                             limit:(NSUInteger)lim
                includeManuallyAdded:(BOOL)includeManuallyAdded
                        completion:(void (^)(NSDictionary *, NSError *))completion {

    void (^handlerBlock)(HKAnchoredObjectQuery *query,
                         NSArray<__kindof HKSample *> *sampleObjects,
                         NSArray<HKDeletedObject *> *deletedObjects,
                         HKQueryAnchor *newAnchor,
                         NSError *error);

    handlerBlock = ^(HKAnchoredObjectQuery *query,
                     NSArray<__kindof HKSample *> *sampleObjects,
                     NSArray<HKDeletedObject *> *deletedObjects,
                     HKQueryAnchor *newAnchor,
                     NSError *error) {

        if (error) {
            if (completion) { completion(nil, error); }
            return;
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *added   = [NSMutableArray arrayWithCapacity:sampleObjects.count];
            NSMutableArray *deleted = [NSMutableArray arrayWithCapacity:deletedObjects.count];
            NSUInteger serializationErrors = 0;

            for (HKQuantitySample *sample in sampleObjects) {
                // Skip user-entered samples if includeManuallyAdded is false
                if (!includeManuallyAdded && sample.metadata && [sample.metadata[HKMetadataKeyWasUserEntered] boolValue]) {
                    continue;
                }
                @try {
                    double value        = [sample.quantity doubleValueForUnit:unit];
                    NSString *startDate = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                    NSString *endDate   = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];
                    NSString *unitString = [RCTAppleHealthKit normalizeUnitString:[unit unitString]];
                    HKDevice *dev = sample.device;
                    NSDictionary *deviceDict = @{
                        @"name":            dev.model                               ?: [NSNull null],
                        @"model":           [[sample sourceRevision] productType]   ?: [NSNull null],
                        @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                        @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                    };
                    [added addObject:@{
                        @"id":         [[sample UUID] UUIDString],
                        @"value":      @(value),
                        @"unit":       unitString,
                        @"startDate":  startDate,
                        @"endDate":    endDate,
                        @"sourceName": [[[sample sourceRevision] source] name] ?: @"",
                        @"sourceId":   [[[sample sourceRevision] source] bundleIdentifier] ?: @"",
                        @"device":     deviceDict,
                        @"metadata":   sample.metadata ?: @{},
                    }];
                } @catch (NSException *e) {
                    NSLog(@"RNHealth: fetchAnchoredSamplesOfType: skipping sample %@ (%@: %@)",
                          [[sample UUID] UUIDString], e.name, e.reason);
                    serializationErrors++;
                }
            }

            for (HKDeletedObject *obj in deletedObjects) {
                [deleted addObject:@{ @"id": [[obj UUID] UUIDString] }];
            }

            NSString *anchorString = @"";
            if (newAnchor != nil) {
                NSError *archiveError = nil;
                NSData *anchorData = [NSKeyedArchiver archivedDataWithRootObject:newAnchor requiringSecureCoding:YES error:&archiveError];
                if (archiveError) {
                    NSLog(@"RNHealth: Failed to archive anchor: %@", archiveError);
                    if (completion) {
                        completion(nil, archiveError);
                    }
                    return;
                }
                anchorString = [anchorData base64EncodedStringWithOptions:0];
            }

            NSMutableDictionary *result = [@{
                @"anchor":  anchorString,
                @"added":   added,
                @"deleted": deleted,
            } mutableCopy];

            // Signal partial failure: if samples failed serialization, include error count
            // so JS side knows the batch was incomplete
            if (serializationErrors > 0) {
                result[@"serializationErrors"] = @(serializationErrors);
            }

            if (completion) {
                completion(result, nil);
            }
        });
    };

    HKAnchoredObjectQuery *query = [[HKAnchoredObjectQuery alloc]
        initWithType:quantityType
           predicate:predicate
              anchor:anchor
               limit:lim
      resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

// ─── Anchored category samples (Sleep) ───────────────────────────────────────

- (void)fetchAnchoredCategorySamplesOfType:(HKCategoryType *)categoryType
                                  predicate:(NSPredicate *)predicate
                                     anchor:(HKQueryAnchor *)anchor
                                      limit:(NSUInteger)lim
                                 completion:(void (^)(NSDictionary *, NSError *))completion {

    void (^handlerBlock)(HKAnchoredObjectQuery *,
                         NSArray<__kindof HKSample *> *,
                         NSArray<HKDeletedObject *> *,
                         HKQueryAnchor *,
                         NSError *);

    handlerBlock = ^(HKAnchoredObjectQuery *query,
                     NSArray<__kindof HKSample *> *sampleObjects,
                     NSArray<HKDeletedObject *> *deletedObjects,
                     HKQueryAnchor *newAnchor,
                     NSError *error) {
        if (error) {
            if (completion) { completion(nil, error); }
            return;
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *added   = [NSMutableArray arrayWithCapacity:sampleObjects.count];
            NSMutableArray *deleted = [NSMutableArray arrayWithCapacity:deletedObjects.count];
            NSUInteger serializationErrors = 0;

            for (HKCategorySample *sample in sampleObjects) {
                @try {
                    NSString *valueString;
                    switch (sample.value) {
                        case HKCategoryValueSleepAnalysisInBed:      valueString = @"INBED";   break;
                        case HKCategoryValueSleepAnalysisAsleep:     valueString = @"ASLEEP";  break;
                        case HKCategoryValueSleepAnalysisAsleepCore: valueString = @"CORE";    break;
                        case HKCategoryValueSleepAnalysisAsleepDeep: valueString = @"DEEP";    break;
                        case HKCategoryValueSleepAnalysisAsleepREM:  valueString = @"REM";     break;
                        case HKCategoryValueSleepAnalysisAwake:      valueString = @"AWAKE";   break;
                        default:                                      valueString = @"UNKNOWN"; break;
                    }
                    HKDevice *dev = sample.device;
                    NSDictionary *deviceDict = @{
                        @"name":            dev.model                               ?: [NSNull null],
                        @"model":           [[sample sourceRevision] productType]   ?: [NSNull null],
                        @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                        @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                    };
                    [added addObject:@{
                        @"id":         [[sample UUID] UUIDString],
                        @"value":      valueString,
                        @"startDate":  [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate],
                        @"endDate":    [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate],
                        @"sourceName": [[[sample sourceRevision] source] name] ?: @"",
                        @"sourceId":   [[[sample sourceRevision] source] bundleIdentifier] ?: @"",
                        @"device":     deviceDict,
                        @"metadata":   sample.metadata ?: @{},
                    }];
                } @catch (NSException *e) {
                    NSLog(@"RNHealth: fetchAnchoredCategorySamplesOfType: skipping sample %@ (%@: %@)",
                          [[sample UUID] UUIDString], e.name, e.reason);
                    serializationErrors++;
                }
            }

            for (HKDeletedObject *obj in deletedObjects) {
                [deleted addObject:@{ @"id": [[obj UUID] UUIDString] }];
            }

            NSString *anchorString = @"";
            if (newAnchor != nil) {
                NSError *archiveError = nil;
                NSData *anchorData = [NSKeyedArchiver archivedDataWithRootObject:newAnchor
                                                            requiringSecureCoding:YES
                                                                            error:&archiveError];
                if (archiveError) {
                    NSLog(@"RNHealth: Failed to archive anchor: %@", archiveError);
                    if (completion) { completion(nil, archiveError); }
                    return;
                }
                anchorString = [anchorData base64EncodedStringWithOptions:0];
            }

            NSMutableDictionary *result = [@{
                @"anchor":  anchorString,
                @"added":   added,
                @"deleted": deleted,
            } mutableCopy];
            if (serializationErrors > 0) {
                result[@"serializationErrors"] = @(serializationErrors);
            }
            if (completion) {
                completion(result, nil);
            }
        });
    };

    HKAnchoredObjectQuery *query = [[HKAnchoredObjectQuery alloc]
        initWithType:categoryType
           predicate:predicate
              anchor:anchor
               limit:lim
      resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

// ─── Anchored correlation samples (BloodPressure) ────────────────────────────

- (void)fetchAnchoredCorrelationSamplesOfType:(HKCorrelationType *)correlationType
                                     predicate:(NSPredicate *)predicate
                                        anchor:(HKQueryAnchor *)anchor
                                         limit:(NSUInteger)lim
                                    completion:(void (^)(NSDictionary *, NSError *))completion {

    HKQuantityType *systolicType  = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    HKUnit *mmHg = [HKUnit millimeterOfMercuryUnit];

    void (^handlerBlock)(HKAnchoredObjectQuery *,
                         NSArray<__kindof HKSample *> *,
                         NSArray<HKDeletedObject *> *,
                         HKQueryAnchor *,
                         NSError *);

    handlerBlock = ^(HKAnchoredObjectQuery *query,
                     NSArray<__kindof HKSample *> *sampleObjects,
                     NSArray<HKDeletedObject *> *deletedObjects,
                     HKQueryAnchor *newAnchor,
                     NSError *error) {
        if (error) {
            if (completion) { completion(nil, error); }
            return;
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *added   = [NSMutableArray arrayWithCapacity:sampleObjects.count];
            NSMutableArray *deleted = [NSMutableArray arrayWithCapacity:deletedObjects.count];
            NSUInteger serializationErrors = 0;

            for (HKCorrelation *sample in sampleObjects) {
                @try {
                    HKQuantitySample *sys = [sample objectsForType:systolicType].anyObject;
                    HKQuantitySample *dia = [sample objectsForType:diastolicType].anyObject;
                    if (!sys || !dia) {
                        NSLog(@"RNHealth: fetchAnchoredCorrelationSamplesOfType: incomplete BP correlation (missing sys or dia), skipping id=%@", [[sample UUID] UUIDString]);
                        serializationErrors++;
                        continue;
                    }

                    HKDevice *dev = sample.device;
                    NSDictionary *deviceDict = @{
                        @"name":            dev.model                               ?: [NSNull null],
                        @"model":           [[sample sourceRevision] productType]   ?: [NSNull null],
                        @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                        @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                    };
                    [added addObject:@{
                        @"id":                         [[sample UUID] UUIDString],
                        @"bloodPressureSystolicValue":  @([sys.quantity doubleValueForUnit:mmHg]),
                        @"bloodPressureDiastolicValue": @([dia.quantity doubleValueForUnit:mmHg]),
                        @"startDate":  [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate],
                        @"endDate":    [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate],
                        @"sourceName": [[[sample sourceRevision] source] name] ?: @"",
                        @"sourceId":   [[[sample sourceRevision] source] bundleIdentifier] ?: @"",
                        @"device":     deviceDict,
                        @"metadata":   sample.metadata ?: @{},
                    }];
                } @catch (NSException *e) {
                    NSLog(@"RNHealth: fetchAnchoredCorrelationSamplesOfType: skipping sample %@ (%@: %@)",
                          [[sample UUID] UUIDString], e.name, e.reason);
                    serializationErrors++;
                }
            }

            for (HKDeletedObject *obj in deletedObjects) {
                [deleted addObject:@{ @"id": [[obj UUID] UUIDString] }];
            }

            NSString *anchorString = @"";
            if (newAnchor != nil) {
                NSError *archiveError = nil;
                NSData *anchorData = [NSKeyedArchiver archivedDataWithRootObject:newAnchor
                                                            requiringSecureCoding:YES
                                                                            error:&archiveError];
                if (archiveError) {
                    NSLog(@"RNHealth: Failed to archive anchor: %@", archiveError);
                    if (completion) { completion(nil, archiveError); }
                    return;
                }
                anchorString = [anchorData base64EncodedStringWithOptions:0];
            }

            NSMutableDictionary *result = [@{
                @"anchor":  anchorString,
                @"added":   added,
                @"deleted": deleted,
            } mutableCopy];
            if (serializationErrors > 0) {
                result[@"serializationErrors"] = @(serializationErrors);
            }
            if (completion) {
                completion(result, nil);
            }
        });
    };

    HKAnchoredObjectQuery *query = [[HKAnchoredObjectQuery alloc]
        initWithType:correlationType
           predicate:predicate
              anchor:anchor
               limit:lim
      resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

// ─── Anchored clinical samples (FHIR / Cholesterol) ──────────────────────────

- (void)fetchAnchoredClinicalSamplesOfType:(HKClinicalType *)clinicalType
                                  predicate:(NSPredicate *)predicate
                                     anchor:(HKQueryAnchor *)anchor
                                      limit:(NSUInteger)lim
                                 completion:(void (^)(NSDictionary *, NSError *))completion
    API_AVAILABLE(ios(12.0)) {

    void (^handlerBlock)(HKAnchoredObjectQuery *,
                         NSArray<__kindof HKSample *> *,
                         NSArray<HKDeletedObject *> *,
                         HKQueryAnchor *,
                         NSError *);

    handlerBlock = ^(HKAnchoredObjectQuery *query,
                     NSArray<__kindof HKSample *> *sampleObjects,
                     NSArray<HKDeletedObject *> *deletedObjects,
                     HKQueryAnchor *newAnchor,
                     NSError *error) {
        if (error) {
            if (completion) { completion(nil, error); }
            return;
        }

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *added   = [NSMutableArray arrayWithCapacity:sampleObjects.count];
            NSMutableArray *deleted = [NSMutableArray arrayWithCapacity:deletedObjects.count];
            NSUInteger serializationErrors = 0;

            for (HKClinicalRecord *record in sampleObjects) {
                @try {
                    if (!record.FHIRResource) {
                        NSLog(@"RNHealth: fetchAnchoredClinicalSamplesOfType: record has no FHIR resource, skipping");
                        serializationErrors++;
                        continue;
                    }
                    NSError *jsonE = nil;
                    id fhirData = [NSJSONSerialization JSONObjectWithData:record.FHIRResource.data
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:&jsonE];
                    if (!fhirData) {
                        NSLog(@"RNHealth: fetchAnchoredClinicalSamplesOfType FHIR parse error: %@", jsonE);
                        serializationErrors++;
                        continue;
                    }

                    NSString *fhirRelease = @"DSTU2";
                    NSString *fhirVersion = @"1.0.2";
                    if (@available(iOS 14.0, *)) {
                        HKFHIRVersion *v = record.FHIRResource.FHIRVersion;
                        fhirRelease = v.FHIRRelease ?: fhirRelease;
                        fhirVersion = v.stringRepresentation ?: fhirVersion;
                    }

                    HKDevice *dev = record.device;
                    NSDictionary *deviceDict = @{
                        @"name":            dev.model                               ?: [NSNull null],
                        @"model":           [[record sourceRevision] productType]   ?: [NSNull null],
                        @"hardwareVersion": dev.hardwareVersion                     ?: [NSNull null],
                        @"softwareVersion": dev.softwareVersion                     ?: [NSNull null],
                    };

                    [added addObject:@{
                        @"id":          [[record UUID] UUIDString],
                        @"displayName": record.displayName ?: @"",
                        @"fhirData":    fhirData,
                        @"fhirRelease": fhirRelease,
                        @"fhirVersion": fhirVersion,
                        @"startDate":   [RCTAppleHealthKit buildISO8601StringFromDate:record.startDate],
                        @"endDate":     [RCTAppleHealthKit buildISO8601StringFromDate:record.endDate],
                        @"sourceName":  [[[record sourceRevision] source] name] ?: @"",
                        @"sourceId":    [[[record sourceRevision] source] bundleIdentifier] ?: @"",
                        @"device":      deviceDict,
                    }];
                } @catch (NSException *e) {
                    NSLog(@"RNHealth: fetchAnchoredClinicalSamplesOfType: skipping record %@ (%@: %@)",
                          [[record UUID] UUIDString], e.name, e.reason);
                    serializationErrors++;
                }
            }

            for (HKDeletedObject *obj in deletedObjects) {
                [deleted addObject:@{ @"id": [[obj UUID] UUIDString] }];
            }

            NSString *anchorString = @"";
            if (newAnchor != nil) {
                NSError *archiveError = nil;
                NSData *anchorData = [NSKeyedArchiver archivedDataWithRootObject:newAnchor
                                                            requiringSecureCoding:YES
                                                                            error:&archiveError];
                if (archiveError) {
                    NSLog(@"RNHealth: Failed to archive anchor: %@", archiveError);
                    if (completion) { completion(nil, archiveError); }
                    return;
                }
                anchorString = [anchorData base64EncodedStringWithOptions:0];
            }

            NSMutableDictionary *result = [@{
                @"anchor":  anchorString,
                @"added":   added,
                @"deleted": deleted,
            } mutableCopy];
            if (serializationErrors > 0) {
                result[@"serializationErrors"] = @(serializationErrors);
            }
            if (completion) {
                completion(result, nil);
            }
        });
    };

    HKAnchoredObjectQuery *query = [[HKAnchoredObjectQuery alloc]
        initWithType:clinicalType
           predicate:predicate
              anchor:anchor
               limit:lim
      resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

// ─── Sleep (category) ─────────────────────────────────────────────────────────

- (void)fetchSleepCategorySamplesForPredicate:(NSPredicate *)predicate
                                        limit:(NSUInteger)lim
                                    ascending:(BOOL)asc
                                   completion:(void (^)(NSArray *, NSError *))completion {

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate
                                                                       ascending:asc];


    void (^handlerBlock)(HKSampleQuery *query, NSArray *results, NSError *error);
    handlerBlock = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }

        if (completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                for (HKCategorySample *sample in results) {
                    NSInteger val = sample.value;

                    NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                    NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

                    NSString *valueString;

                    switch (val) {
                      case HKCategoryValueSleepAnalysisInBed:
                        valueString = @"INBED";
                      break;
                      case HKCategoryValueSleepAnalysisAsleep:
                        valueString = @"ASLEEP";
                      break;

                      // watchOS 9 and iOS 16 introduce Core, Deep, REM, and Awake phases of sleep.
                      case HKCategoryValueSleepAnalysisAsleepCore:
                        valueString = @"CORE";
                      break;
                      case HKCategoryValueSleepAnalysisAsleepDeep:
                        valueString = @"DEEP";
                      break;
                      case HKCategoryValueSleepAnalysisAsleepREM:
                        valueString = @"REM";
                      break;
                      case HKCategoryValueSleepAnalysisAwake:
                        valueString = @"AWAKE";
                      break;

                     default:
                        valueString = @"UNKNOWN";
                     break;
                  }

                    NSDictionary *elem = @{
                            @"id" : [[sample UUID] UUIDString],
                            @"value" : valueString,
                            @"startDate" : startDateString,
                            @"endDate" : endDateString,
                            @"sourceName" : [[[sample sourceRevision] source] name],
                            @"sourceId" : [[[sample sourceRevision] source] bundleIdentifier],
                    };

                    [data addObject:elem];
                }

                completion(data, error);
            });
        }
    };

    HKCategoryType *categoryType =
    [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:categoryType
                                                          predicate:predicate
                                                              limit:lim
                                                    sortDescriptors:@[timeSortDescriptor]
                                                     resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

- (void)fetchCorrelationSamplesOfType:(HKQuantityType *)quantityType
                                 unit:(HKUnit *)unit
                            predicate:(NSPredicate *)predicate
                            ascending:(BOOL)asc
                                limit:(NSUInteger)lim
                           completion:(void (^)(NSArray *, NSError *))completion {

    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate
                                                                       ascending:asc];

    void (^handlerBlock)(HKSampleQuery *query, NSArray *results, NSError *error);
    handlerBlock = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (!results) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }

        if (completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                for (HKCorrelation *sample in results) {
                    NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                    NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];

                    NSDictionary *elem = @{
                      @"correlation" : sample,
                      @"startDate" : startDateString,
                      @"endDate" : endDateString,
                    };
                    [data addObject:elem];
                }

                completion(data, error);
            });
        }
    };

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:quantityType
                                                           predicate:predicate
                                                               limit:lim
                                                     sortDescriptors:@[timeSortDescriptor]
                                                      resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

- (void)fetchSumOfSamplesTodayForType:(HKQuantityType *)quantityType
                                 unit:(HKUnit *)unit
                           completion:(void (^)(double, NSError *))completionHandler {

    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesToday];
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType
                                                          quantitySamplePredicate:predicate
                                                          options:HKStatisticsOptionCumulativeSum
                                                          completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
                                                                HKQuantity *sum = [result sumQuantity];
                                                                if (completionHandler) {
                                                                    double value = [sum doubleValueForUnit:unit];
                                                                    completionHandler(value, error);
                                                                }
                                                          }];

    [self.healthStore executeQuery:query];
}

- (void)fetchSumOfSamplesOnDayForType:(HKQuantityType *)quantityType
                                 unit:(HKUnit *)unit
                                 includeManuallyAdded:(BOOL)includeManuallyAdded
                                  day:(NSDate *)day
                           completion:(void (^)(double, NSDate *, NSDate *, NSError *))completionHandler {
    NSPredicate *dayPredicate = [RCTAppleHealthKit predicateForSamplesOnDay:day];
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[dayPredicate]];
    if (includeManuallyAdded == false) {
        NSPredicate *manualDataPredicate = [NSPredicate predicateWithFormat:@"metadata.%K != YES", HKMetadataKeyWasUserEntered];
        predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[dayPredicate, manualDataPredicate]];
    }
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType
                                                          quantitySamplePredicate:predicate
                                                          options:HKStatisticsOptionCumulativeSum
                                                          completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
                                                              if ([error.localizedDescription isEqualToString:@"No data available for the specified predicate."] && completionHandler) {
                                                                  completionHandler(0, day, day, nil);
                                                                } else if (completionHandler) {
                                                                    HKQuantity *sum = [result sumQuantity];
                                                                    NSDate *startDate = result.startDate;
                                                                    NSDate *endDate = result.endDate;
                                                                    double value = [sum doubleValueForUnit:unit];
                                                                    if (startDate == nil || endDate == nil) {
                                                                        error = [[NSError alloc] initWithDomain:@"AppleHealthKit"
                                                                                                           code:0
                                                                                                           userInfo:@{@"Error reason": @"Could not fetch statistics: Not authorized"}
                                                                        ];
                                                                    }
                                                                    completionHandler(value, startDate, endDate, error);
                                                              }
                                                          }];

    [self.healthStore executeQuery:query];
}

- (void)fetchCumulativeSumStatisticsCollection:(HKQuantityType *)quantityType
                                          unit:(HKUnit *)unit
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                    completion:(void (^)(NSArray *, NSError *))completionHandler {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;

    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                     fromDate:[NSDate date]];
    anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"metadata.%K != YES AND %K >= %@ AND %K <= %@",
                              HKMetadataKeyWasUserEntered,
                              HKPredicateKeyPathEndDate, startDate,
                              HKPredicateKeyPathStartDate, endDate];
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
                                                                           quantitySamplePredicate:predicate
                                                                                           options:HKStatisticsOptionCumulativeSum
                                                                                        anchorDate:anchorDate
                                                                                intervalComponents:interval];

    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
        if (error) {
            // Perform proper error handling here
            NSLog(@"*** An error occurred while calculating the statistics: %@ ***",error.localizedDescription);
        }

        NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];
        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *result, BOOL *stop) {

                                       HKQuantity *quantity = result.sumQuantity;
                                       if (quantity) {
                                           NSDate *date = result.startDate;
                                           double value = [quantity doubleValueForUnit:[HKUnit countUnit]];
                                           NSLog(@"%@: %f", date, value);

                                           NSString *dateString = [RCTAppleHealthKit buildISO8601StringFromDate:date];
                                           NSArray *elem = @[dateString, @(value)];
                                           [data addObject:elem];
                                       }
                                   }];
        NSError *err;
        completionHandler(data, err);
    };

    [self.healthStore executeQuery:query];
}

- (void)fetchCumulativeSumStatisticsCollection:(HKQuantityType *)quantityType
                                          unit:(HKUnit *)unit
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                     ascending:(BOOL)asc
                                         limit:(NSUInteger)lim
                                    completion:(void (^)(NSArray *, NSError *))completionHandler {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.day = 1;

    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                     fromDate:[NSDate date]];
    anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"metadata.%K != YES AND %K >= %@ AND %K <= %@",
                              HKMetadataKeyWasUserEntered,
                              HKPredicateKeyPathEndDate, startDate,
                              HKPredicateKeyPathStartDate, endDate];
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
                                                                           quantitySamplePredicate:predicate
                                                                                           options:HKStatisticsOptionCumulativeSum
                                                                                        anchorDate:anchorDate
                                                                                intervalComponents:interval];

    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
        if (error) {
            // Perform proper error handling here
            NSLog(@"*** An error occurred while calculating the statistics: %@ ***", error.localizedDescription);
        }

        NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *result, BOOL *stop) {

                                       HKQuantity *quantity = result.sumQuantity;
                                       if (quantity) {
                                           NSDate *startDate = result.startDate;
                                           NSDate *endDate = result.endDate;
                                           double value = [quantity doubleValueForUnit:unit];

                                           NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:startDate];
                                           NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:endDate];

                                           NSDictionary *elem = @{
                                                   @"value" : @(value),
                                                   @"startDate" : startDateString,
                                                   @"endDate" : endDateString,
                                           };
                                           [data addObject:elem];
                                       }
                                   }];
        // is ascending by default
        if(asc == false) {
            [RCTAppleHealthKit reverseNSMutableArray:data];
        }

        if((lim > 0) && ([data count] > lim)) {
            NSArray* slicedArray = [data subarrayWithRange:NSMakeRange(0, lim)];
            NSError *err;
            completionHandler(slicedArray, err);
        } else {
            NSError *err;
            completionHandler(data, err);
        }
    };

    [self.healthStore executeQuery:query];
}

- (void)fetchCumulativeSumStatisticsCollection:(HKQuantityType *)quantityType
                                          unit:(HKUnit *)unit
                                        period:(NSUInteger)period
                                     startDate:(NSDate *)startDate
                                       endDate:(NSDate *)endDate
                                     ascending:(BOOL)asc
                                         limit:(NSUInteger)lim
                          includeManuallyAdded:(BOOL)includeManuallyAdded
                                    completion:(void (^)(NSArray *, NSError *))completionHandler {

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *interval = [[NSDateComponents alloc] init];
    interval.minute = period;

    NSDateComponents *anchorComponents = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                     fromDate:startDate];
    //anchorComponents.hour = 0;
    NSDate *anchorDate = [calendar dateFromComponents:anchorComponents];
    NSPredicate *predicate = nil;
    if (includeManuallyAdded == false) {
        predicate = [NSPredicate predicateWithFormat:@"metadata.%K != YES AND %K >= %@ AND %K <= %@",
                                  HKMetadataKeyWasUserEntered,
                                  HKPredicateKeyPathEndDate, startDate,
                                  HKPredicateKeyPathStartDate, endDate];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"%K >= %@ AND %K <= %@",
                                  HKPredicateKeyPathEndDate, startDate,
                                  HKPredicateKeyPathStartDate, endDate];
    }
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:quantityType
                                                                           quantitySamplePredicate:predicate
                                                                                           options:HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource
                                                                                        anchorDate:anchorDate
                                                                                intervalComponents:interval];

    query.initialResultsHandler = ^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *results, NSError *error) {
        if (error) {
            // Perform proper error handling here
            NSLog(@"*** An error occurred while calculating the statistics: %@ ***", error.localizedDescription);
        }

        NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

        [results enumerateStatisticsFromDate:startDate
                                      toDate:endDate
                                   withBlock:^(HKStatistics *result, BOOL *stop) {

                                       HKQuantity *quantity = result.sumQuantity;
                                       if (quantity) {
                                           NSDate *startDate = result.startDate;
                                           NSDate *endDate = result.endDate;
                                           double value = [quantity doubleValueForUnit:unit];

                                           NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:startDate];
                                           NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:endDate];

                                           NSMutableArray *metadata = [NSMutableArray arrayWithCapacity:1];

                                           for (HKSource *source in result.sources) {

                                                NSString *bundleIdentifier = source.bundleIdentifier;
                                                NSString *name = source.name;
                                                HKQuantity *sourceQuantity = [result sumQuantityForSource:source];
                                                double quantity = [sourceQuantity doubleValueForUnit:unit];


                                                if (quantity != 0) {
                                                    NSDictionary *sourceItem = @{
                                                                                @"sourceId" : bundleIdentifier,
                                                                                @"sourceName" : name,
                                                                                @"quantity" : @(quantity), 
                                                                                };

                                                    [metadata addObject:sourceItem];
                                                }
                                            }
                                

                                           NSDictionary *elem = @{
                                                   @"value" : @(value),
                                                   @"startDate" : startDateString,
                                                   @"endDate" : endDateString,
                                                   @"metadata" : metadata,
                                           };
                                           [data addObject:elem];
                                       }
                                   }];
        // is ascending by default
        if(asc == false) {
            [RCTAppleHealthKit reverseNSMutableArray:data];
        }

        if((lim > 0) && ([data count] > lim)) {
            NSArray* slicedArray = [data subarrayWithRange:NSMakeRange(0, lim)];
            NSError *err;
            completionHandler(slicedArray, err);
        } else {
            NSError *err;
            completionHandler(data, err);
        }
    };

    [self.healthStore executeQuery:query];
}

 - (void)fetchWorkoutForPredicate:(NSPredicate *)predicate
                        ascending:(BOOL)ascending
                            limit:(NSUInteger)limit
                       completion:(void (^)(NSArray *, NSError *))completion {

    void (^handlerBlock)(HKSampleQuery *query, NSArray *results, NSError *error);
    NSSortDescriptor *endDateSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:ascending];
    handlerBlock = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if(!results) {
            if(completion) {
                completion(nil, error);
            }
            return;
        }

        if(completion) {
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];
            NSDictionary *numberToWorkoutNameDictionary = [RCTAppleHealthKit getNumberToWorkoutNameDictionary];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                for (HKWorkout * sample in results) {
                    double energy = [[sample totalEnergyBurned] doubleValueForUnit:[HKUnit kilocalorieUnit]];
                    double distance = [[sample totalDistance] doubleValueForUnit:[HKUnit mileUnit]];
                    NSNumber *activityNumber =  [NSNumber numberWithInt: [sample workoutActivityType]];

                    NSString *activityName = [numberToWorkoutNameDictionary objectForKey: activityNumber];

                    if (activityName) {
                        NSDictionary *elem = @{
                            @"activityName" : activityName,
                            @"calories" : @(energy),
                            @"distance" : @(distance),
                            @"startDate" : [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate],
                            @"endDate" : [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate]
                        };
                        [data addObject:elem];
                    }
                }
                completion(data, error);
            });

        }
    };

    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:[HKObjectType workoutType] predicate:predicate limit:limit sortDescriptors:@[endDateSortDescriptor] resultsHandler:handlerBlock];

    [self.healthStore executeQuery:query];
}

/*!
    Set background observer for the given HealthKit sample type. This method should only be called by
    the native code and not injected by any Javascript code, as that might imply in unstable behavior

    @deprecated The setObserver() method has been deprecated in favor of initializeBackgroundObservers()

    @param sampleType The type of samples to add a listener for
    @param type A human readable description for the sample type
 */
- (void)setObserverForType:(HKSampleType *)sampleType
                      type:(NSString *)type __deprecated
{
    HKObserverQuery* query = [
        [HKObserverQuery alloc] initWithSampleType:sampleType
                                         predicate:nil
                                     updateHandler:^(HKObserverQuery* query,
                                                     HKObserverQueryCompletionHandler completionHandler,
                                                     NSError * _Nullable error) {
        NSLog(@"[HealthKit] New sample received from Apple HealthKit - %@", type);

        NSString *successEvent = [NSString stringWithFormat:@"healthKit:%@:sample", type];

        if (error) {
            completionHandler();

            NSLog(@"[HealthKit] An error happened when receiving a new sample - %@", error.localizedDescription);

            return;
        }

        NSLog(@"Emitting event: %@", successEvent);
        [self emitEventWithName:successEvent andPayload:@{}];

        completionHandler();

        NSLog(@"[HealthKit] New sample from Apple HealthKit processed (dep) - %@ %@", type, successEvent);
    }];


    [self.healthStore enableBackgroundDeliveryForType:sampleType
                                            frequency:HKUpdateFrequencyImmediate
                                       withCompletion:^(BOOL success, NSError * _Nullable error) {
        NSString *successEvent = [NSString stringWithFormat:@"healthKit:%@:enabled", type];

        if (error) {
            NSLog(@"[HealthKit] An error happened when setting up background observer - %@", error.localizedDescription);

            return;
        }

        [self.healthStore executeQuery:query];

        [self emitEventWithName:successEvent andPayload:@{}];
    }];
}

/*!
    Set background observer for the given HealthKit sample type. This method should only be called by
    the native code and not injected by any Javascript code, as that might imply in unstable behavior

    @param sampleType The type of samples to add a listener for
    @param type A human readable description for the sample type
    @param bridge React Native bridge instance
 */
- (void)setObserverForType:(HKSampleType *)sampleType
                      type:(NSString *)type
                    bridge:(RCTBridge *)bridge
{
    NSString *deltaEvent        = [NSString stringWithFormat:@"healthKit:%@:delta",         type];
    NSString *newEvent          = [NSString stringWithFormat:@"healthKit:%@:new",           type];
    NSString *failureEvent      = [NSString stringWithFormat:@"healthKit:%@:failure",       type];
    NSString *anchorKey         = [NSString stringWithFormat:@"RNHealth_DeltaAnchor_%@",    type];
    NSString *setupSuccessEvent = [NSString stringWithFormat:@"healthKit:%@:setup:success", type];
    NSString *setupFailureEvent = [NSString stringWithFormat:@"healthKit:%@:setup:failure", type];

    // --- Observer registration block (async continuation) ---
    // Defined as a block so it can be called from either the seed completion block
    // or directly — avoids blocking dispatch_group_wait on the calling thread.
    void (^registerObserver)(void) = ^{
        HKObserverQuery *query = [[HKObserverQuery alloc]
            initWithSampleType:sampleType
                     predicate:nil
                 updateHandler:^(HKObserverQuery *query,
                                 HKObserverQueryCompletionHandler completionHandler,
                                 NSError * _Nullable error) {

            NSLog(@"[HealthKit] Observer fired for %@", type);

            if (error) {
                completionHandler();
                if (self.hasListeners) {
                    [self emitEventWithName:failureEvent andPayload:@{}];
                }
                return;
            }

            // Background sync disabled — app must call configureBackgroundSync({ enabled: true }).
            // Defaults to disabled if the key was never written (opt-in behaviour).
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([defaults objectForKey:@"RNHealth_SyncEnabled"] == nil ||
                ![defaults boolForKey:@"RNHealth_SyncEnabled"]) {
                completionHandler();
                return;
            }

            // Workout: bare :new only (full delta via getDeltaSamples)
            if ([type isEqualToString:@"Workout"]) {
                if (self.hasListeners) {
                    [self emitEventWithName:newEvent andPayload:@{}];
                }
                completionHandler();
                return;
            }

            // MindfulSession: no delta fetcher available, emit :new only
            if ([type isEqualToString:@"MindfulSession"]) {
                if (self.hasListeners) {
                    [self emitEventWithName:newEvent andPayload:@{}];
                }
                completionHandler();
                return;
            }

            // SleepAnalysis: full delta fetch via fetchAnchoredCategorySamplesOfType
            if ([type isEqualToString:@"SleepAnalysis"]) {
                NSTimeInterval syncInterval = [[NSUserDefaults standardUserDefaults]
                    doubleForKey:@"RNHealth_SyncInterval"];
                if (syncInterval <= 0) syncInterval = 86400.0;

                NSString *lastFetchKey = [NSString stringWithFormat:@"RNHealth_LastFetch_%@", type];
                NSDate   *lastFetch    = [[NSUserDefaults standardUserDefaults] objectForKey:lastFetchKey];
                NSTimeInterval elapsed = lastFetch ? [[NSDate date] timeIntervalSinceDate:lastFetch] : DBL_MAX;

                if (elapsed < syncInterval) {
                    NSLog(@"[HealthKit] Skipping delta fetch for %@ (%.0fs < %.0fs interval)", type, elapsed, syncInterval);
                    completionHandler();
                    return;
                }

                HKQueryAnchor *storedAnchor = nil;
                NSString *stored = [[NSUserDefaults standardUserDefaults] stringForKey:anchorKey];
                if (stored.length) {
                    NSData *anchorData = [[NSData alloc] initWithBase64EncodedString:stored options:0];
                    NSError *unarchiveError = nil;
                    storedAnchor = [NSKeyedUnarchiver unarchivedObjectOfClass:[HKQueryAnchor class]
                                                                    fromData:anchorData
                                                                       error:&unarchiveError];
                    if (unarchiveError) {
                        NSLog(@"RNHealth: Failed to unarchive sleep anchor: %@", unarchiveError);
                    }
                }

                HKCategoryType *sleepType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
                [self fetchAnchoredCategorySamplesOfType:sleepType
                                               predicate:nil
                                                  anchor:storedAnchor
                                                   limit:HKObjectQueryNoLimit
                                              completion:^(NSDictionary *results, NSError *fetchError) {
                    completionHandler();

                    if (fetchError || !results) {
                        NSLog(@"[HealthKit] Sleep delta fetch error: %@", fetchError.localizedDescription);
                        if (self.hasListeners) {
                            [self emitEventWithName:failureEvent andPayload:@{}];
                        }
                        return;
                    }

                    NSString *newAnchorString = results[@"anchor"];
                    if (newAnchorString.length > 0) {
                        [[NSUserDefaults standardUserDefaults] setObject:newAnchorString forKey:anchorKey];
                    }
                    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:lastFetchKey];

                    if (self.hasListeners) {
                        [self emitEventWithName:deltaEvent andPayload:results];
                        [self emitEventWithName:newEvent andPayload:@{}];
                    }
                }];
                return;
            }

            HKQuantityType *quantityType = (HKQuantityType *)[RCTAppleHealthKit quantityTypeFromName:type];
            if (!quantityType) {
                if (self.hasListeners) {
                    [self emitEventWithName:newEvent andPayload:@{}];
                }
                completionHandler();
                return;
            }

            // Time gate: skip fetch if less than the configured sync interval has elapsed.
            // Default 86400s (24h) if configureBackgroundSync was never called.
            NSTimeInterval syncInterval = [[NSUserDefaults standardUserDefaults]
                doubleForKey:@"RNHealth_SyncInterval"];
            if (syncInterval <= 0) syncInterval = 86400.0;

            NSString *lastFetchKey = [NSString stringWithFormat:@"RNHealth_LastFetch_%@", type];
            NSDate   *lastFetch    = [[NSUserDefaults standardUserDefaults] objectForKey:lastFetchKey];
            NSTimeInterval elapsed = lastFetch ? [[NSDate date] timeIntervalSinceDate:lastFetch]
                                               : DBL_MAX;

            if (elapsed < syncInterval) {
                NSLog(@"[HealthKit] Skipping delta fetch for %@ (%.0fs < %.0fs interval)",
                      type, elapsed, syncInterval);
                completionHandler(); // must always be called
                return;
            }

            // Read stored anchor
            HKQueryAnchor *storedAnchor = nil;
            NSString *stored = [[NSUserDefaults standardUserDefaults] stringForKey:anchorKey];
            if (stored.length) {
                NSData *anchorData = [[NSData alloc] initWithBase64EncodedString:stored options:0];
                NSError *unarchiveError = nil;
                storedAnchor = [NSKeyedUnarchiver unarchivedObjectOfClass:[HKQueryAnchor class] fromData:anchorData error:&unarchiveError];
                if (unarchiveError) {
                    NSLog(@"RNHealth: Failed to unarchive anchor: %@", unarchiveError);
                }
            }

            HKUnit *unit = [RCTAppleHealthKit defaultHKUnitForType:type];

            [self fetchAnchoredSamplesOfType:quantityType
                                        unit:unit
                                   predicate:nil
                                      anchor:storedAnchor
                                       limit:HKObjectQueryNoLimit
                          includeManuallyAdded:YES
                                  completion:^(NSDictionary *results, NSError *fetchError) {

                // Always call completionHandler — HealthKit stops background delivery if omitted
                completionHandler();

                if (fetchError || !results) {
                    NSLog(@"[HealthKit] Delta fetch error for %@: %@", type, fetchError.localizedDescription);
                    if (self.hasListeners) {
                        [self emitEventWithName:failureEvent andPayload:@{}];
                    }
                    return;
                }

                // Persist new anchor BEFORE emitting — next delivery starts correctly
                NSString *newAnchorString = results[@"anchor"];
                if (newAnchorString.length > 0) {
                    [[NSUserDefaults standardUserDefaults] setObject:newAnchorString forKey:anchorKey];
                }

                // Stamp last-fetch time so the time gate works on the next observer fire
                [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:lastFetchKey];

                if (self.hasListeners) {
                    [self emitEventWithName:deltaEvent andPayload:results];
                    // Keep :new for backwards compatibility
                    [self emitEventWithName:newEvent andPayload:@{}];
                }
            }];
        }];

        [self.healthStore enableBackgroundDeliveryForType:sampleType
                                                frequency:HKUpdateFrequencyImmediate
                                           withCompletion:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                NSLog(@"[HealthKit] Background delivery setup error for %@: %@", type, error.localizedDescription);
                if (self.hasListeners) {
                    [self emitEventWithName:setupFailureEvent andPayload:@{}];
                }
                return;
            }
            NSLog(@"[HealthKit] Background delivery enabled for %@", type);
            [self.healthStore executeQuery:query];
            if (self.hasListeners) {
                [self emitEventWithName:setupSuccessEvent andPayload:@{}];
            }
        }];
    };

    // --- Anchor seeding (async, non-blocking) ---
    // Empty-string check (.length > 0) prevents treating a previously stored empty
    // anchor as valid — empty string passes != nil but is not a real anchor.
    BOOL hasStoredAnchor = ([[NSUserDefaults standardUserDefaults] stringForKey:anchorKey].length > 0);
    if (!hasStoredAnchor && ![type isEqualToString:@"Workout"]) {
        if ([type isEqualToString:@"SleepAnalysis"]) {
            HKCategoryType *sleepType = [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
            [self fetchAnchoredCategorySamplesOfType:sleepType
                                           predicate:nil
                                              anchor:nil
                                               limit:0
                                          completion:^(NSDictionary *results, NSError *error) {
                if (error) {
                    NSLog(@"[HealthKit] Anchor seed fetch failed for SleepAnalysis: %@", error.localizedDescription);
                } else {
                    NSString *seedAnchor = results[@"anchor"];
                    if (seedAnchor.length > 0) {
                        [[NSUserDefaults standardUserDefaults] setObject:seedAnchor forKey:anchorKey];
                        NSLog(@"[HealthKit] Anchor seeded for SleepAnalysis");
                    }
                }
                registerObserver();
            }];
            return;
        }
        HKQuantityType *qt = (HKQuantityType *)[RCTAppleHealthKit quantityTypeFromName:type];
        if (qt && ![qt isEqual:[HKObjectType workoutType]]) {
            HKUnit *unit = [RCTAppleHealthKit defaultHKUnitForType:type];
            [self fetchAnchoredSamplesOfType:qt
                                        unit:unit
                                   predicate:nil
                                      anchor:nil
                                       limit:0
                          includeManuallyAdded:YES
                                  completion:^(NSDictionary *results, NSError *error) {
                if (error) {
                    NSLog(@"[HealthKit] Anchor seed fetch failed for %@: %@", type, error.localizedDescription);
                } else {
                    NSString *seedAnchor = results[@"anchor"];
                    if (seedAnchor.length > 0) {
                        [[NSUserDefaults standardUserDefaults] setObject:seedAnchor forKey:anchorKey];
                        NSLog(@"[HealthKit] Anchor seeded for %@", type);
                    }
                }
                registerObserver();
            }];
            return; // Observer registered from completion block above
        }
    }
    registerObserver();
}

- (void)fetchActivitySummary:(NSDate *)startDate
                     endDate:(NSDate *)endDate
                  completion:(void (^)(NSArray *, NSError *))completionHandler
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *startComponent = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra
                                                     fromDate:startDate];
    startComponent.calendar = calendar;
    NSDateComponents *endComponent = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra
                                                     fromDate:endDate];
    endComponent.calendar = calendar;
    NSPredicate *predicate = [HKQuery predicateForActivitySummariesBetweenStartDateComponents:startComponent endDateComponents:endComponent];

    HKActivitySummaryQuery *query = [[HKActivitySummaryQuery alloc] initWithPredicate:predicate
                                        resultsHandler:^(HKActivitySummaryQuery *query, NSArray *results, NSError *error) {

        if (error) {
            // Perform proper error handling here
            NSLog(@"*** An error occurred while fetching the summary: %@ ***",error.localizedDescription);
            completionHandler(nil, error);
            return;
        }

        NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (HKActivitySummary *summary in results) {
                int aebVal = [summary.activeEnergyBurned doubleValueForUnit:[HKUnit kilocalorieUnit]];
                int aebgVal = [summary.activeEnergyBurnedGoal doubleValueForUnit:[HKUnit kilocalorieUnit]];
                int aetVal = [summary.appleExerciseTime doubleValueForUnit:[HKUnit minuteUnit]];
                int aetgVal = [summary.appleExerciseTimeGoal doubleValueForUnit:[HKUnit minuteUnit]];
                int ashVal = [summary.appleStandHours doubleValueForUnit:[HKUnit countUnit]];
                int ashgVal = [summary.appleStandHoursGoal doubleValueForUnit:[HKUnit countUnit]];

                NSDictionary *elem = @{
                        @"activeEnergyBurned" : @(aebVal),
                        @"activeEnergyBurnedGoal" : @(aebgVal),
                        @"appleExerciseTime" : @(aetVal),
                        @"appleExerciseTimeGoal" : @(aetgVal),
                        @"appleStandHours" : @(ashVal),
                        @"appleStandHoursGoal" : @(ashgVal),
                };

                [data addObject:elem];
            }

            completionHandler(data, error);
        });
    }];

    [self.healthStore executeQuery:query];

}

@end

