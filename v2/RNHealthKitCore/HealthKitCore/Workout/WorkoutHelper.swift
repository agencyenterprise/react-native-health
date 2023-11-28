import Foundation
import HealthKit

public struct WorkoutHelper {
    public static func processWorkoutMetadata(_ metadata: [String: Any]) throws -> [String: Any] {
        var updatedMetadata = [String: Any]()

        for (key, value) in metadata {
            switch key {
            case HKMetadataKeyFitnessMachineDuration,
                 HKMetadataKeyCrossTrainerDistance,
                 HKMetadataKeyIndoorBikeDistance,
                 HKMetadataKeyAverageMETs,
                 HKMetadataKeyAlpineSlopeGrade,
                 HKMetadataKeyElevationAscended,
                 HKMetadataKeyElevationDescended,
                 HKMetadataKeyAverageSpeed,
                 HKMetadataKeyMaximumSpeed,
                 HKMetadataKeyLapLength:
                if let quantityInfo = value as? [String: Any],
                   let unit = quantityInfo["unit"] as? String,
                   let doubleValue = quantityInfo["doubleValue"] as? Double {
                    let hkQuantity = HKQuantity(unit: HKUnit(from: unit), doubleValue: doubleValue)
                    updatedMetadata[key] = hkQuantity
                }
            case "HKWaterSalinity":
                if #available(iOS 17.0, *), let salinityValue = value as? Int {
                    updatedMetadata[key] = HKWaterSalinity(rawValue: salinityValue) ?? nil
                } else {
                    throw WorkoutMetadataError.unsupportedSalinityType(
                        message: "Water salinity type is unsupported on this iOS version."
                    )
                }
            default:
                updatedMetadata[key] = value
            }
        }

        return updatedMetadata
    }
}

public enum WorkoutMetadataError: Error {
    case unsupportedSalinityType(message: String)
}

extension WorkoutMetadataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unsupportedSalinityType(let message):
            return message
        }
    }
}
