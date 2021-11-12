//
//  RCTAppleHealthKit+Methods_Vitals.m
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.


#import "RCTAppleHealthKit+Methods_Vitals.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Vitals)


- (void)vitals_getHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:heartRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting heart rate samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting heart rate samples:", error, nil)]);
                                  return;
                              }
                          }];
}


- (void)vitals_getRestingHeartRate:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *restingHeartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:restingHeartRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting heart rate samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting heart rate samples:", error, nil)]);
                                  return;
                              }
                          }];
}

- (void)vitals_getWalkingHeartRateAverage:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *restingHeartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingHeartRateAverage];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:restingHeartRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting heart rate samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting heart rate samples:", error, nil)]);
                                  return;
                              }
                          }];
}

- (void)vitals_getHeartRateVariabilitySamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *hrvType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateVariabilitySDNN];

    HKUnit *unit = [HKUnit secondUnit];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:hrvType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting heart rate variability samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting heart rate variability samples:", error, nil)]);
                                  return;
                              }
                          }];
}

- (void)vitals_getHeartbeatSeriesSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    if (@available(iOS 13.0, *)) {
        HKSeriesType *heartbeatSeriesType = [HKSeriesType seriesTypeForIdentifier:HKDataTypeIdentifierHeartbeatSeries];
        
        NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
        BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
        if(startDate == nil){
            callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
            return;
        }
        NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
        NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:ascending];
        
        
        // Define the results handler for the SampleQuery.
        void (^resultsHandler)(HKSampleQuery *query, NSArray *results, NSError *error);
        resultsHandler = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
            if (error != nil) {
                callback(@[RCTJSErrorFromNSError(error)]);
                return;
            }
            
            // explicity send back an empty array for no results
            if (results.count == 0) {
                callback(@[[NSNull null], @[]]);
                return;
            }
            
            __block NSUInteger samplesProcessed = 0;
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];
            
            // create a function that check the progress of processing the samples
            // and executes the callback with the data whan done
            void (^maybeFinish)(void);
            maybeFinish =  ^() {
                // check to see if we've processed all of the returned samples, and return if so
                if (samplesProcessed == results.count) {
                    callback(@[[NSNull null], data]);
                }
            };
            
            for (HKHeartbeatSeriesSample *sample in results) {
                NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];
                
                NSDictionary *elem = @{
                     @"id" : [[sample UUID] UUIDString],
                     @"sourceName" : [[[sample sourceRevision] source] name],
                     @"sourceId" : [[[sample sourceRevision] source] bundleIdentifier],
                     @"startDate" : startDateString,
                     @"endDate" : endDateString,
                     @"heartbeatSeries": @[]
                 };
                NSMutableDictionary *mutableElem = [elem mutableCopy];
                [data addObject:mutableElem];
                
                // create an array to hold the series data which will be fetched asynchronously from healthkit
                NSMutableArray *seriesData = [NSMutableArray arrayWithCapacity:sample.count];
                
                // now define the data handler for the HeartbeatSeriesQuery
                void (^dataHandler)(HKHeartbeatSeriesQuery *hrSeriesQuery, NSTimeInterval timeSinceSeriesStart, BOOL precededByGap, BOOL done, NSError *error);
                dataHandler = ^(HKHeartbeatSeriesQuery *hrSeriesQuery, NSTimeInterval timeSinceSeriesStart, BOOL precededByGap, BOOL done, NSError *error) {
                    if (error == nil) {
                        // If no error exists for this data point, add the value to the heartbeatSeries array.
                        // I'm not sure if this technique of error handling is what we want. It could lead
                        // to holes in the data. The alternative is to not write any of the series data to
                        // the elem dictionary if an error occurs. I think holes are *probably* better?
                        NSDictionary *el = @{
                            @"timeSinceSeriesStart": @(timeSinceSeriesStart),
                            @"precededByGap": @(precededByGap)
                        };
                        [seriesData addObject:el];
                    }
                    
                    if (done) {
                        [mutableElem setObject:seriesData forKey:@"heartbeatSeries"];
                        samplesProcessed += 1;
                        maybeFinish();
                    }
                };
                // Query the heartbeat series for this sample.
                HKHeartbeatSeriesQuery *hrSeriesQuery = [[HKHeartbeatSeriesQuery alloc] initWithHeartbeatSeries:sample
                                                                                                    dataHandler:dataHandler];
                [self.healthStore executeQuery:hrSeriesQuery];
            }
        };
        
        // Define and execute the HKSampleQuery
        HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:heartbeatSeriesType
                                                               predicate:predicate
                                                                   limit:limit
                                                         sortDescriptors:@[timeSortDescriptor]
                                                          resultsHandler:resultsHandler];
        [self.healthStore executeQuery:query];
    } else {
        callback(@[RCTMakeError(@"HeartbeatSeries is not available for this iOS version", nil, nil)]);
    }
}

- (void)vitals_getRestingHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *restingHeartRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:restingHeartRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  callback(@[RCTJSErrorFromNSError(error)]);
                                  return;
                              }
                          }];
}

- (void)vitals_getBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bodyTemperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit degreeCelsiusUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bodyTemperatureType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting body temperature samples: %@", error);
            callback(@[RCTMakeError(@"error getting body temperature samples:", error, nil)]);
            return;
        }
    }];
}


- (void)vitals_getBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKCorrelationType *bloodPressureCorrelationType = [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];


    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit millimeterOfMercuryUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchCorrelationSamplesOfType:bloodPressureCorrelationType
                                   unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            for (NSDictionary *sample in results) {
                HKCorrelation *bloodPressureValues = [sample valueForKey:@"correlation"];

                HKQuantitySample *bloodPressureSystolicValue = [bloodPressureValues objectsForType:systolicType].anyObject;
                HKQuantitySample *bloodPressureDiastolicValue = [bloodPressureValues objectsForType:diastolicType].anyObject;

                NSDictionary *elem = @{
                                       @"bloodPressureSystolicValue" : @([bloodPressureSystolicValue.quantity doubleValueForUnit:unit]),
                                       @"bloodPressureDiastolicValue" : @([bloodPressureDiastolicValue.quantity doubleValueForUnit:unit]),
                                       @"startDate" : [sample valueForKey:@"startDate"],
                                       @"endDate" : [sample valueForKey:@"endDate"],
                                      };

                [data addObject:elem];
            }

            callback(@[[NSNull null], data]);
            return;
        } else {
            NSLog(@"error getting blood pressure samples: %@", error);
            callback(@[RCTMakeError(@"error getting blood pressure samples:", error, nil)]);
            return;
        }
    }];
}


- (void)vitals_getRespiratoryRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *respiratoryRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:respiratoryRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting respiratory rate samples: %@", error);
            callback(@[RCTMakeError(@"error getting respiratory rate samples:", error, nil)]);
            return;
        }
    }];
}

- (void)vitals_getVo2MaxSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    HKQuantityType *vo2MaxType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];

    HKUnit *ml = [HKUnit literUnitWithMetricPrefix:HKMetricPrefixMilli];
    HKUnit *kg = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
    HKUnit *min = [HKUnit minuteUnit];
    HKUnit *u = [ml unitDividedByUnit:[kg unitMultipliedByUnit:min]]; // ml/(kg*min)

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:u];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    [self fetchQuantitySamplesOfType:vo2MaxType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if (results) {
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSString *errStr = [NSString stringWithFormat:@"error getting Vo2Max samples: %@", error];
            NSLog(errStr);

            callback(@[RCTMakeError(errStr, nil, nil)]);

            return;
        }
    }];
}

- (void)vitals_getOxygenSaturationSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *oxygenSaturationType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];

    HKUnit *unit = [HKUnit percentUnit];

    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:oxygenSaturationType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting oxygen saturation: %@", error);
            callback(@[RCTMakeError(@"error getting oxygen saturation:", error, nil)]);
            return;
        }
    }];
}

- (void)vitals_getElectrocardiogramSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
 {
     if (@available(iOS 14.0, *)) {
         NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
         BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
         NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
         NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
         if(startDate == nil){
             callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
             return;
         }
         NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
         NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate ascending:ascending];

         // Define the results handler for the SampleQuery.
         void (^resultsHandler)(HKSampleQuery *query, NSArray *results, NSError *error);
         resultsHandler = ^(HKSampleQuery *query, NSArray *results, NSError *error) {
             if (error != nil) {
                 callback(@[RCTJSErrorFromNSError(error)]);
                 return;
             }

             // explicity send back an empty array for no results
             if (results.count == 0) {
                 callback(@[[NSNull null], @[]]);
                 return;
             }

             __block NSUInteger samplesProcessed = 0;
             NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

             // create a function that check the progress of processing the samples
             // and executes the callback with the data whan done
             void (^maybeFinish)(void);
             maybeFinish =  ^() {
                 // check to see if we've processed all of the returned samples, and return if so
                 if (samplesProcessed == results.count) {
                     callback(@[[NSNull null], data]);
                 }
             };

             for (HKElectrocardiogram *sample in results) {
                 NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
                 NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];
                 
                 NSString *classification;
                 switch(sample.classification) {
                     case(HKElectrocardiogramClassificationNotSet):
                         classification = @"NotSet";
                         break;
                     case(HKElectrocardiogramClassificationSinusRhythm):
                         classification = @"SinusRhythm";
                         break;
                     case(HKElectrocardiogramClassificationAtrialFibrillation):
                         classification = @"AtrialFibrillation";
                         break;
                     case(HKElectrocardiogramClassificationInconclusiveLowHeartRate):
                         classification = @"InconclusiveLowHeartRate";
                         break;
                     case(HKElectrocardiogramClassificationInconclusiveHighHeartRate):
                         classification = @"InconclusiveHighHeartRate";
                         break;
                     case(HKElectrocardiogramClassificationInconclusivePoorReading):
                         classification = @"InconclusivePoorReading";
                         break;
                     case(HKElectrocardiogramClassificationInconclusiveOther):
                         classification = @"InconclusiveOther";
                         break;
                     default:
                         classification = @"Unrecognized";
                 }
                 
                 HKUnit *count = [HKUnit countUnit];
                 HKUnit *minute = [HKUnit minuteUnit];
                 HKUnit *bpmUnit = [count unitDividedByUnit:minute];
                 double averageHeartRate = [sample.averageHeartRate doubleValueForUnit:bpmUnit];
                 
                 NSDictionary *elem = @{
                      @"id" : [[sample UUID] UUIDString],
                      @"sourceName" : [[[sample sourceRevision] source] name],
                      @"sourceId" : [[[sample sourceRevision] source] bundleIdentifier],
                      @"startDate" : startDateString,
                      @"endDate" : endDateString,
                      @"classification": classification,
                      @"averageHeartRate": @(averageHeartRate),
                      @"samplingFrequency": @([sample.samplingFrequency doubleValueForUnit:HKUnit.hertzUnit]),
                      @"device": [[sample sourceRevision] productType],
                      @"algorithmVersion": @([[sample metadata][HKMetadataKeyAppleECGAlgorithmVersion] intValue]),
                      @"voltageMeasurements": @[]
                  };
                 NSMutableDictionary *mutableElem = [elem mutableCopy];
                 [data addObject:mutableElem];

                 // create an array to hold the ecg voltage data which will be fetched asynchronously from healthkit
                 NSMutableArray *voltageMeasurements = [NSMutableArray arrayWithCapacity:sample.numberOfVoltageMeasurements];

                 // now define the data handler for the HKElectrocardiogramQuery
                 void (^dataHandler)(HKElectrocardiogramQuery *voltageQuery, HKElectrocardiogramVoltageMeasurement *voltageMeasurement, BOOL done, NSError *error);

                 dataHandler = ^(HKElectrocardiogramQuery *voltageQuery, HKElectrocardiogramVoltageMeasurement *voltageMeasurement, BOOL done, NSError *error) {
                     if (error == nil) {
                         // If no error exists for this data point, add the voltage measurement to the array.
                         // I'm not sure if this technique of error handling is what we want. It could lead
                         // to holes in the data. The alternative is to not write any of the voltage data to
                         // the elem dictionary if an error occurs. I think holes are *probably* better?
                         HKQuantity *voltageQuantity = [voltageMeasurement quantityForLead:HKElectrocardiogramLeadAppleWatchSimilarToLeadI];
                         NSArray *measurement = @[
                             @(voltageMeasurement.timeSinceSampleStart),
                             @([voltageQuantity doubleValueForUnit:HKUnit.voltUnit])
                         ];
                         [voltageMeasurements addObject:measurement];
                     }

                     if (done) {
                         [mutableElem setObject:voltageMeasurements forKey:@"voltageMeasurements"];
                         samplesProcessed += 1;
                         maybeFinish();
                     }
                 };
                 // query the voltages for this ecg
                 HKElectrocardiogramQuery *voltageQuery = [[HKElectrocardiogramQuery alloc] initWithElectrocardiogram:sample
                                                                                                        dataHandler:dataHandler];
                 [self.healthStore executeQuery:voltageQuery];
             }
         };

         // Define and execute the HKSampleQuery
         HKSampleQuery *ecgQuery = [[HKSampleQuery alloc] initWithSampleType:HKObjectType.electrocardiogramType
                                                                   predicate:predicate
                                                                       limit:limit
                                                             sortDescriptors:@[timeSortDescriptor]
                                                              resultsHandler:resultsHandler];
         [self.healthStore executeQuery:ecgQuery];
     } else {
         callback(@[RCTMakeError(@"Electrocardiogram is not available for this iOS version", nil, nil)]);
     }
 }

@end
