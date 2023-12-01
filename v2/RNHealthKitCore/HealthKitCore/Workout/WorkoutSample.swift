import Foundation
import HealthKit

/// Represents a workout sample, including details such as ID, start and end times, duration, and activity type.
public struct WorkoutSample: Encodable {
    /// The unique identifier for the workout sample.
    public let id: String

    /// The ISO string representation of the start date and time of the workout.
    public let startDate: String

    /// The ISO string representation of the end date and time of the workout.
    public let endDate: String

    /// The duration of the workout in seconds.
    public let duration: Double

    /// The activity type of the workout as a raw unsigned integer value.
    public let activityType: UInt
    
    // Represents additional activities that are part of the workout.
    public let workoutActivities: [WorkoutActivity]?

    /// Additional metadata associated with the workout sample.
    public let metadata: [String: String]?

    /// Represents statistical data associated with the workout.
    public let statistics: [QuantityType : Statistics]?

    /// Initializes a `WorkoutSample` object based on an `HKWorkout` instance.
    ///
    /// - Parameter workout: The `HKWorkout` object from which to extract data.
    init(_ workout: HKWorkout) {
        self.id = workout.uuid.uuidString
        self.startDate = workout.startDate.toIsoString() ?? ""
        self.endDate = workout.endDate.toIsoString() ?? ""
        self.duration = workout.duration
        self.activityType = workout.workoutActivityType.rawValue

        if #available(iOS 16.0, *) {
            self.workoutActivities = workout.workoutActivities.compactMap({ WorkoutActivity(activity: $0) })
            self.statistics = workout.allStatistics.compactMap { key, value -> (QuantityType, Statistics)? in
                guard let quantityType = QuantityType.from(key),
                      let statistics = Statistics(from: value) else {
                    return nil
                }

                return (quantityType, statistics)
            }.reduce(into: [QuantityType: Statistics]()) { dict, tuple in
                dict[tuple.0] = tuple.1
            }
        } else {
            self.workoutActivities = nil
            self.statistics = nil
        }
        self.metadata = workout.metadata?.mapValues(String.init(describing:)) ?? [:]
    }
}
