import Foundation
import HealthKit

public protocol HealthKitType {
    var type: HKSampleType { get }
}

let hkQuantityTypePrefix = "HKQuantityTypeIdentifier"

public enum QuantityType: String, HealthKitType {
    public var type: HKSampleType {
        return HKQuantityType.init(.init(rawValue: hkQuantityTypePrefix + self.rawValue))
    }

    case BasalBodyTemperature
    case BloodAlcoholContent
    case BloodGlucose
    case BloodPressureDiastolic
    case BloodPressureSystolic
    case BodyFatPercentage
    case BodyMass
    case BodyMassIndex
    case BodyTemperature
    case ElectrodermalActivity
    case ForcedExpiratoryVolume1
    case ForcedVitalCapacity
    case HeartRate
    case HeartRateVariabilitySDNN
    case Height
    case LeanBodyMass
    case OxygenSaturation
    case PeakExpiratoryFlowRate
    case PeripheralPerfusionIndex
    case RestingHeartRate
    case RespiratoryRate
    case UVExposure // Scalar(Count)
    case VO2Max
    case WaistCircumference
    case WalkingHeartRateAverage
    
    @available(iOS 14.0, *) case SixMinuteWalkTestDistance
    @available(iOS 14.0, *) case StairAscentSpeed
    @available(iOS 14.0, *) case StairDescentSpeed
    @available(iOS 14.0, *) case WalkingSpeed
    @available(iOS 14.0, *) case WalkingDoubleSupportPercentage
    @available(iOS 14.0, *) case WalkingAsymmetryPercentage
    @available(iOS 14.0, *) case WalkingStepLength
    
    @available(iOS 15.0, *) case AppleWalkingSteadiness

    @available(iOS 16.0, *) case AppleSleepingWristTemperature
    @available(iOS 16.0, *) case AtrialFibrillationBurden // Scalar(Percent, 0.0 - 1.0)
    @available(iOS 16.0, *) case HeartRateRecoveryOneMinute
    @available(iOS 16.0, *) case RunningGroundContactTime
    @available(iOS 16.0, *) case RunningPower
    @available(iOS 16.0, *) case RunningSpeed
    @available(iOS 16.0, *) case RunningStrideLength
    @available(iOS 16.0, *) case RunningVerticalOscillation
    @available(iOS 16.0, *) case UnderwaterDepth // Length
    @available(iOS 16.0, *) case WaterTemperature // Temperature
    
    // Cumulative
    case ActiveEnergyBurned
    case AppleExerciseTime
    case BasalEnergyBurned
    case DietaryBiotin  // Mass
    case DietaryCalcium  // Mass
    case DietaryCaffeine  // Mass
    case DietaryCarbohydrates  // Mass
    case DietaryChloride  // Mass
    case DietaryCholesterol  // Mass
    case DietaryChromium  // Mass
    case DietaryCopper  // Mass
    case DietaryEnergyConsumed  // Energy
    case DietaryFiber  // Mass
    case DietaryFatMonounsaturated  // Mass
    case DietaryFatPolyunsaturated  // Mass
    case DietaryFatSaturated  // Mass
    case DietaryFatTotal  // Mass
    case DietaryFolate  // Mass
    case DietaryIron  // Mass
    case DietaryIodine  // Mass
    case DietaryMagnesium  // Mass
    case DietaryManganese  // Mass
    case DietaryMolybdenum  // Mass
    case DietaryNiacin  // Mass
    case DietaryPantothenicAcid  // Mass
    case DietaryPhosphorus  // Mass
    case DietaryPotassium  // Mass
    case DietaryProtein  // Mass
    case DietaryRiboflavin  // Mass
    case DietarySelenium  // Mass
    case DietarySodium  // Mass
    case DietarySugar  // Mass
    case DietaryThiamin  // Mass
    case DietaryVitaminA  // Mass
    case DietaryVitaminB12  // Mass
    case DietaryVitaminB6  // Mass
    case DietaryVitaminC  // Mass
    case DietaryVitaminD  // Mass
    case DietaryVitaminE  // Mass
    case DietaryVitaminK  // Mass
    case DietaryWater  // Volume
    case DietaryZinc  //  Mass
    case DistanceCycling
    case DistanceDownhillSnowSports
    case DistanceSwimming
    case DistanceWalkingRunning
    case DistanceWheelchair
    case FlightsClimbed
    case InhalerUsage
    case InsulinDelivery
    case NikeFuel
    case NumberOfTimesFallen
    case PushCount
    case StepCount
    case SwimmingStrokeCount
    
    @available(iOS 14.0, *) case AppleStandTime
    
    @available(iOS 14.5, *)case AppleMoveTime
    
    @available(iOS 15.0, *)case NumberOfAlcoholicBeverages
}

/**
 @available(iOS 13.0, *)
environmentalAudioExposure: HKQuantityTypeIdentifier // Pressure,                    DiscreteEquivalentContinuousLevel

 @available(iOS 13.0, *)
headphoneAudioExposure: HKQuantityTypeIdentifier // Pressure,                    DiscreteEquivalentContinuousLevel
 */
