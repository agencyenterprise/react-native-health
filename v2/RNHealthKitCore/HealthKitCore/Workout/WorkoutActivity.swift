import Foundation
import HealthKit

public struct WorkoutActivity: Codable {
    public let workoutConfiguration: WorkoutConfiguration
    public let startDate: String
    public let endDate: String?
    public let metadata: [String: Any]?

    private enum CodingKeys: String, CodingKey {
        case workoutConfiguration
        case startDate
        case endDate
        case metadata
    }

    public init(
        workoutConfiguration: WorkoutConfiguration,
        startDate: String,
        endDate: String?,
        metadata: [String: Any]? = nil
    ) {
        self.workoutConfiguration = workoutConfiguration
        self.startDate = startDate
        self.endDate = endDate
        self.metadata = metadata
    }

    @available(iOS 16.0, *)
    public init(activity: HKWorkoutActivity) {
        let configuration = activity.workoutConfiguration
        self.init(
            workoutConfiguration: .init(
                workoutActivityType: configuration.activityType,
                workoutLocationType: configuration.locationType,
                workoutSwimmingLocationType: configuration.swimmingLocationType
            ),
            startDate: activity.startDate.toIsoString()!,
            endDate: activity.endDate?.toIsoString(),
            metadata: activity.metadata
        )
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(workoutConfiguration, forKey: .workoutConfiguration)
        try container.encode(startDate, forKey: .startDate)
        try container.encodeIfPresent(endDate, forKey: .endDate)

        if let metadata {
            let jsonData = try JSONSerialization.data(withJSONObject: metadata, options: [])
            try container.encode(jsonData, forKey: .metadata)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        workoutConfiguration = try container.decode(WorkoutConfiguration.self, forKey: .workoutConfiguration)
        startDate = try container.decode(String.self, forKey: .startDate)
        endDate = try container.decodeIfPresent(String.self, forKey: .endDate)

        if let metadataData = try container.decodeIfPresent(Data.self, forKey: .metadata) {
            metadata = try JSONSerialization.jsonObject(with: metadataData, options: []) as? [String: Any]
        } else {
            metadata = nil
        }
    }
}
