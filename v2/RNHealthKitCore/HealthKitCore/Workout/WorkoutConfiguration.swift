import Foundation
import HealthKit

public struct WorkoutConfiguration: Codable {
    public let workoutActivityType: HKWorkoutActivityType?
    public let workoutLocationType: HKWorkoutSessionLocationType?
    public let workoutSwimmingLocationType: HKWorkoutSwimmingLocationType?
    public let workoutLapLength: WorkoutQuantity?

    private enum CodingKeys: String, CodingKey {
        case workoutActivityType
        case workoutLocationType
        case workoutSwimmingLocationType
        case workoutLapLength
    }

    public init(
        workoutActivityType: HKWorkoutActivityType? = .other,
        workoutLocationType: HKWorkoutSessionLocationType = .unknown,
        workoutSwimmingLocationType: HKWorkoutSwimmingLocationType? = nil,
        workoutLapLength: WorkoutQuantity? = nil
    ) {
        self.workoutActivityType = workoutActivityType
        self.workoutLocationType = workoutLocationType
        self.workoutSwimmingLocationType = workoutSwimmingLocationType
        self.workoutLapLength = workoutLapLength
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(workoutActivityType?.rawValue, forKey: .workoutActivityType)
        try container.encodeIfPresent(workoutLocationType?.rawValue, forKey: .workoutLocationType)
        try container.encodeIfPresent(workoutSwimmingLocationType?.rawValue, forKey: .workoutSwimmingLocationType)
        try container.encodeIfPresent(workoutLapLength, forKey: .workoutLapLength)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let workoutActivityTypeRawValue = try container.decodeIfPresent(Int.self, forKey: .workoutActivityType)
        let locationTypeRawValue = try container.decodeIfPresent(Int.self, forKey: .workoutLocationType)
        let swimmingLocationTypeRawValue = try container.decodeIfPresent(Int.self, forKey: .workoutSwimmingLocationType)
        let lapLength = try container.decodeIfPresent(WorkoutQuantity.self, forKey: .workoutLapLength)

        if let rawActivityRawValue = workoutActivityTypeRawValue {
            self.workoutActivityType = HKWorkoutActivityType(rawValue: UInt(rawActivityRawValue))
        } else {
            self.workoutActivityType = nil
        }

        if let rawLocationTypeValue = locationTypeRawValue {
            self.workoutLocationType = HKWorkoutSessionLocationType(rawValue: rawLocationTypeValue)
        } else {
            self.workoutLocationType = .unknown
        }

        if let rawSwimmingLocationTypeValue = swimmingLocationTypeRawValue {
            self.workoutSwimmingLocationType = HKWorkoutSwimmingLocationType(rawValue: rawSwimmingLocationTypeValue)
        } else {
            self.workoutSwimmingLocationType = nil
        }

        self.workoutLapLength = lapLength
    }
}
