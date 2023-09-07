import Foundation
import HealthKit

public struct WorkoutSample {
    public let id: String
    public let startDate: String
    public let endDate: String
    public let duration: Double
    public let activityType: UInt
    // TODO: Add activities | var workoutActivities: [HKWorkoutActivity]
    // TODO: Add workout events | var workoutEvents: [HKWorkoutEvent]?
    // TODO: Add statistics public var statistics: [QuantityType : QuantitySample]
    
    init(_ workout: HKWorkout) {
        self.id = workout.uuid.uuidString
        self.startDate = workout.startDate.toIsoString() ?? ""
        self.endDate = workout.endDate.toIsoString() ?? ""
        self.duration = workout.duration
        self.activityType = workout.workoutActivityType.rawValue
    }
}
