#import "RCTAppleHealthKit+TypesForMedianStatistic.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"

@implementation RCTAppleHealthKit (TypesForMedianStatistic)

- (nullable HKSampleType *)getObjectFromText:(nonnull NSString*)key {
    HKSampleType * _Nullable sample = (HKSampleType *)[self getObjectForDataType:key];
    if (sample != nil) {
        return sample;
    } else {
        HKSampleType * _Nullable workoutObject = (HKSampleType *)[self getObjectForActivityType:key];
        return workoutObject;
    }
}

- (nullable HKObjectType *)getObjectForDataType:(nonnull NSString*)key {
    UIDevice *deviceInfo = [UIDevice currentDevice];
    float systemVersion = deviceInfo.systemVersion.floatValue;

    // documented lower iOS version
    if (systemVersion < 8.0) {
        return nil;
    }

    // HKQuantityType Identifiers

    if ([@"stepCount" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if ([@"distanceWalkingRunning" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    } else if ([@"runningGroundContactTime" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningGroundContactTime];
    } else if ([@"runningPower" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningPower];
    } else if ([@"runningSpeed" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningSpeed];
    } else if ([@"runningStrideLength" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningStrideLength];
    } else if ([@"runningVerticalOscillation" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRunningVerticalOscillation];
    } else if ([@"distanceCycling" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    } else if ([@"pushCount" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPushCount];
    } else if ([@"distanceWheelchair" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWheelchair];
    } else if ([@"swimmingStrokeCount" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierSwimmingStrokeCount];
    } else if ([@"distanceSwimming" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceSwimming];
    } else if ([@"distanceDownhillSnowSports" isEqualToString: key] && systemVersion >= 11.2) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceDownhillSnowSports];
    } else if ([@"basalEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    } else if ([@"activeEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    } else if ([@"flightsClimbed" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    } else if ([@"nikeFuel" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel];
    } else if ([@"appleExerciseTime" isEqualToString: key] && systemVersion >= 9.3) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime];
    } else if ([@"appleMoveTime" isEqualToString: key] && systemVersion >= 14.5) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleMoveTime];
    } else if ([@"appleStandTime" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleStandTime];
    } else if ([@"vo2Max" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];
    } else if ([@"height" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    } else if ([@"bodyMass" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if ([@"bodyMassIndex" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    } else if ([@"leanBodyMass" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];
    } else if ([@"bodyFatPercentage" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    } else if ([@"waistCircumference" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWaistCircumference];
    } else if ([@"appleSleepingWristTemperature" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleSleepingWristTemperature];
    } else if ([@"basalBodyTemperature" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalBodyTemperature];
    } else if ([@"environmentalAudioExposure" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierEnvironmentalAudioExposure];
    } else if ([@"headphoneAudioExposure" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeadphoneAudioExposure];
    } else if ([@"heartRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    } else if ([@"restingHeartRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
    } else if ([@"walkingHeartRateAverage" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingHeartRateAverage];
    } else if ([@"heartRateVariabilitySDNN" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateVariabilitySDNN];
    } else if ([@"heartRateRecoveryOneMinute" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRateRecoveryOneMinute];
    } else if ([@"atrialFibrillationBurden" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAtrialFibrillationBurden];
    } else if ([@"oxygenSaturation" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    } else if ([@"bodyTemperature" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    } else if ([@"bloodPressureSystolic" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    } else if ([@"bloodPressureDiastolic" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    } else if ([@"respiratoryRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];
    } else if ([@"bloodGlucose" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    } else if ([@"electrodermalActivity" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierElectrodermalActivity];
    } else if ([@"forcedExpiratoryVolume1" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierForcedExpiratoryVolume1];
    } else if ([@"forcedVitalCapacity" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierForcedVitalCapacity];
    } else if ([@"inhalerUsage" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierInhalerUsage];
    } else if ([@"insulinDelivery" isEqualToString:key] && systemVersion >= 11.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierInsulinDelivery];
    } else if ([@"numberOfTimesFallen" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierNumberOfTimesFallen];
    } else if ([@"peakExpiratoryFlowRate" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPeakExpiratoryFlowRate];
    } else if ([@"peripheralPerfusionIndex" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierPeripheralPerfusionIndex];
    } else if ([@"dietaryBiotin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryBiotin];
    } else if ([@"dietaryCaffeine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCaffeine];
    } else if ([@"dietaryCalcium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCalcium];
    } else if ([@"dietaryCarbohydrates" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];
    } else if ([@"dietaryChloride" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryChloride];
    } else if ([@"dietaryCholesterol" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol];
    } else if ([@"dietaryChromium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryChromium];
    } else if ([@"dietaryCopper" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCopper];
    } else if ([@"dietaryEnergyConsumed" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    } else if ([@"dietaryFatMonounsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatMonounsaturated];
    } else if ([@"dietaryFatPolyunsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatPolyunsaturated];
    } else if ([@"dietaryFatSaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatSaturated];
    } else if ([@"dietaryFatTotal" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal];
    } else if ([@"dietaryFiber" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFiber];
    } else if ([@"dietaryFolate" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFolate];
    } else if ([@"dietaryIodine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIodine];
    } else if ([@"dietaryIron" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIron];
    } else if ([@"dietaryMagnesium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMagnesium];
    } else if ([@"dietaryManganese" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryManganese];
    } else if ([@"dietaryMolybdenum" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMolybdenum];
    } else if ([@"dietaryNiacin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryNiacin];
    } else if ([@"dietaryPantothenicAcid" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPantothenicAcid];
    } else if ([@"dietaryPhosphorus" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPhosphorus];
    } else if ([@"dietaryPotassium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPotassium];
    } else if ([@"dietaryProtein" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein];
    } else if ([@"dietaryRiboflavin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryRiboflavin];
    } else if ([@"dietarySelenium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySelenium];
    } else if ([@"dietarySodium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySodium];
    } else if ([@"dietarySugar" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySugar];
    } else if ([@"dietaryThiamin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryThiamin];
    } else if ([@"dietaryVitaminA" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminA];
    } else if ([@"dietaryVitaminB12" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB12];
    } else if ([@"dietaryVitaminB6" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB6];
    } else if ([@"dietaryVitaminC" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminC];
    } else if ([@"dietaryVitaminD" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminD];
    } else if ([@"dietaryVitaminE" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminE];
    } else if ([@"dietaryVitaminK" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminK];
    } else if ([@"dietaryZinc" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryZinc];
    } else if ([@"dietaryWater" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater];
    } else if ([@"bloodAlcoholContent" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodAlcoholContent];
    } else if ([@"numberOfAlcoholicBeverages" isEqualToString: key] && systemVersion >= 15.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierNumberOfAlcoholicBeverages];
    } else if ([@"appleWalkingSteadiness" isEqualToString: key] && systemVersion >= 15.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleWalkingSteadiness];
    } else if ([@"sixMinuteWalkTestDistance" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierSixMinuteWalkTestDistance];
    } else if ([@"walkingSpeed" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingSpeed];
    } else if ([@"walkingStepLength" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingStepLength];
    } else if ([@"walkingAsymmetryPercentage" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingAsymmetryPercentage];
    } else if ([@"walkingDoubleSupportPercentage" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWalkingDoubleSupportPercentage];
    } else if ([@"stairAscentSpeed" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStairAscentSpeed];
    } else if ([@"stairDescentSpeed" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStairDescentSpeed];
    } else if ([@"uvExposure" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierUVExposure];
    } else if ([@"underwaterDepth" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierUnderwaterDepth];
    } else if ([@"waterTemperature" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierWaterTemperature];
    }

    // HKCategoryType Identifiers

    if ([@"appleStandHour" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKCategoryTypeIdentifierAppleStandHour];
    } else if ([@"lowCardioFitnessEvent" isEqualToString: key] && systemVersion >= 14.3) {
        return [HKObjectType quantityTypeForIdentifier:HKCategoryTypeIdentifierLowCardioFitnessEvent];
    } else if ([@"menstrualFlow" isEqualToString: key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMenstrualFlow];
    } else if ([@"intermenstrualBleeding" isEqualToString: key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierIntermenstrualBleeding];
    } else if ([@"infrequentMenstrualCycles" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKCategoryTypeIdentifierInfrequentMenstrualCycles];
    } else if ([@"irregularMenstrualCycles" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKCategoryTypeIdentifierIrregularMenstrualCycles];
    } else if ([@"persistentIntermenstrualBleeding" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKCategoryTypeIdentifierPersistentIntermenstrualBleeding];
    } else if ([@"prolongedMenstrualPeriods" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType quantityTypeForIdentifier:HKCategoryTypeIdentifierProlongedMenstrualPeriods];
    } else if ([@"cervicalMucusQuality" isEqualToString: key] && systemVersion >= 9.0) {
        return [HKObjectType quantityTypeForIdentifier:HKCategoryTypeIdentifierCervicalMucusQuality];
    } else if ([@"ovulationTestResult" isEqualToString: key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierOvulationTestResult];
    } else if ([@"progesteroneTestResult" isEqualToString: key] && systemVersion >= 15.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierProgesteroneTestResult];
    } else if ([@"sexualActivity" isEqualToString: key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSexualActivity];
    } else if ([@"contraceptive" isEqualToString: key] && systemVersion >= 14.3) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierContraceptive];
    } else if ([@"pregnancy" isEqualToString: key] && systemVersion >= 14.3) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierPregnancy];
    } else if ([@"pregnancyTestResult" isEqualToString: key] && systemVersion >= 15.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierPregnancyTestResult];
    } else if ([@"lactation" isEqualToString: key] && systemVersion >= 14.3) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierLactation];
    } else if ([@"environmentalAudioExposureEvent" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierEnvironmentalAudioExposureEvent];
    } else if ([@"headphoneAudioExposureEvent" isEqualToString: key] && systemVersion >= 14.2) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierHeadphoneAudioExposureEvent];
    } else if ([@"lowHeartRateEvent" isEqualToString: key] && systemVersion >= 12.2) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierLowHeartRateEvent];
    } else if ([@"highHeartRateEvent" isEqualToString: key] && systemVersion >= 12.2) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierHighHeartRateEvent];
    } else if ([@"irregularHeartRhythmEvent" isEqualToString: key] && systemVersion >= 12.2) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierIrregularHeartRhythmEvent];
    } else if ([@"appleWalkingSteadinessEvent" isEqualToString: key] && systemVersion >= 15.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierAppleWalkingSteadinessEvent];
    } else if ([@"mindfulSession" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession];
    } else if ([@"sleepAnalysis" isEqualToString:key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    } else if ([@"toothbrushingEvent" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierToothbrushingEvent];
    } else if ([@"handwashingEvent" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierHandwashingEvent];
    }

    // Symptoms
    if ([@"abdominalCramps" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierAbdominalCramps];
    } else if ([@"bloating" isEqualToString: key] && systemVersion >= 13.6){
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierBloating];
    } else if ([@"constipation" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierConstipation];
    } else if ([@"diarrhea" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierDiarrhea];
    } else if ([@"heartburn" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierHeartburn];
    } else if ([@"nausea" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierNausea];
    } else if ([@"vomiting" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierVomiting];
    } else if ([@"appetiteChanges" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierAppetiteChanges];
    } else if ([@"chills" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierChills];
    } else if ([@"dizziness" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierDizziness];
    } else if ([@"fainting" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierFainting];
    } else if ([@"fatigue" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierFatigue];
    } else if ([@"fever" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierFever];
    } else if ([@"generalizedBodyAche" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierGeneralizedBodyAche];
    } else if ([@"hotFlashes" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierHotFlashes];
    } else if ([@"chestTightnessOrPain" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierChestTightnessOrPain];
    } else if ([@"coughing" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierCoughing];
    } else if ([@"rapidPoundingOrFlutteringHeartbeat" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierRapidPoundingOrFlutteringHeartbeat];
    } else if ([@"shortnessOfBreath" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierShortnessOfBreath];
    } else if ([@"skippedHeartbeat" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSkippedHeartbeat];
    } else if ([@"wheezing" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierWheezing];
    } else if ([@"lowerBackPain" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierLowerBackPain];
    } else if ([@"headache" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierHeadache];
    } else if ([@"memoryLapse" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMemoryLapse];
    } else if ([@"moodChanges" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMoodChanges];
    } else if ([@"lossOfSmell" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierLossOfSmell];
    } else if ([@"lossOfTaste" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierLossOfTaste];
    } else if ([@"runnyNose" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierRunnyNose];
    } else if ([@"soreThroat" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSoreThroat];
    } else if ([@"sinusCongestion" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSinusCongestion];
    } else if ([@"breastPain" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierBreastPain];
    } else if ([@"pelvicPain" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierPelvicPain];
    } else if ([@"vaginalDryness" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierVaginalDryness];
    } else if ([@"acne" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierAcne];
    } else if ([@"drySkin" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierDrySkin];
    } else if ([@"hairLoss" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierHairLoss];
    } else if ([@"nightSweats" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierNightSweats];
    } else if ([@"sleepChanges" isEqualToString: key] && systemVersion >= 13.6) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepChanges];
    } else if ([@"bladderIncontinence" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierBladderIncontinence];
    }

    return nil;
}

- (nullable HKObjectType *)getObjectForActivityType:(nonnull NSString*)key {
    UIDevice *deviceInfo = [UIDevice currentDevice];
    float systemVersion = deviceInfo.systemVersion.floatValue;

    // documented lower iOS version
    if (systemVersion < 8.0) {
        return nil;
    }

    if ([@"americanFootball" isEqualToString: key] ||
        [@"archery" isEqualToString: key] ||
        [@"australianFootball" isEqualToString: key] ||
        [@"badminton" isEqualToString: key] ||
        [@"baseball" isEqualToString: key] ||
        [@"basketball" isEqualToString: key] ||
        [@"bowling" isEqualToString: key] ||
        [@"boxing" isEqualToString: key] ||
        [@"climbing" isEqualToString: key] ||
        [@"cricket" isEqualToString: key] ||
        [@"crossTraining" isEqualToString: key] ||
        [@"curling" isEqualToString: key] ||
        [@"cycling" isEqualToString: key] ||
        [@"elliptical" isEqualToString: key] ||
        [@"equestrianSports" isEqualToString: key] ||
        [@"fencing" isEqualToString: key] ||
        [@"fishing" isEqualToString: key] ||
        [@"functionalStrengthTraining" isEqualToString: key] ||
        [@"golf" isEqualToString: key] ||
        [@"gymnastics" isEqualToString: key] ||
        [@"handball" isEqualToString: key] ||
        [@"hiking" isEqualToString: key] ||
        [@"hockey" isEqualToString: key] ||
        [@"hunting" isEqualToString: key] ||
        [@"lacrosse" isEqualToString: key] ||
        [@"martialArts" isEqualToString: key] ||
        [@"mindAndBody" isEqualToString: key] ||
        [@"paddleSports" isEqualToString: key] ||
        [@"play" isEqualToString: key] ||
        [@"preparationAndRecovery" isEqualToString: key] ||
        [@"racquetball" isEqualToString: key] ||
        [@"rowing" isEqualToString: key] ||
        [@"rugby" isEqualToString: key] ||
        [@"running" isEqualToString: key] ||
        [@"sailing" isEqualToString: key] ||
        [@"skatingSports" isEqualToString: key] ||
        [@"snowSports" isEqualToString: key] ||
        [@"soccer" isEqualToString: key] ||
        [@"softball" isEqualToString: key] ||
        [@"squash" isEqualToString: key] ||
        [@"stairClimbing" isEqualToString: key] ||
        [@"surfingSports" isEqualToString: key] ||
        [@"swimming" isEqualToString: key] ||
        [@"tableTennis" isEqualToString: key] ||
        [@"tennis" isEqualToString: key] ||
        [@"trackAndField" isEqualToString: key] ||
        [@"traditionalStrengthTraining" isEqualToString: key] ||
        [@"volleyball" isEqualToString: key] ||
        [@"walking" isEqualToString: key] ||
        [@"waterFitness" isEqualToString: key] ||
        [@"waterPolo" isEqualToString: key] ||
        [@"waterSports" isEqualToString: key] ||
        [@"workout" isEqualToString: key] ||
        [@"wrestling" isEqualToString: key] ||
        [@"yoga" isEqualToString: key]) {
        return [HKObjectType workoutType];
    }

    if ([@"barre" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"coreTraining" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"crossCountrySkiing" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"downhillSkiing" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"flexibility" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"highIntensityIntervalTraining" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"jumpRope" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"kickboxing" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"pilates" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"snowboarding" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"stairs" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"stepTraining" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"wheelchairWalkPace" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    } else if ([@"wheelchairRunPace" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType workoutType];
    }

    if ([@"taiChi" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType workoutType];
    } else if ([@"mixedCardio" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType workoutType];
    } else if ([@"handCycling" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType workoutType];
    }

    if ([@"discSports" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType workoutType];
    } else if ([@"fitnessGaming" isEqualToString: key] && systemVersion >= 13.0) {
        return [HKObjectType workoutType];
    }

    if ([@"cardioDance" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType workoutType];
    } else if ([@"cooldown" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType workoutType];
    } else if ([@"pickleball" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType workoutType];
    } else if ([@"socialDance" isEqualToString: key] && systemVersion >= 14.0) {
       return [HKObjectType workoutType];
    }

    if ([@"swimBikeRun" isEqualToString: key] && systemVersion >= 16.0) {
        return [HKObjectType workoutType];
    }

    return nil;
}

@end
