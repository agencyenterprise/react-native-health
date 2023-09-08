import Foundation
import HealthKit

public extension HealthKitCore {
    func getCompletedWorkouts(queryParameters: WorkoutQueryParameters) async throws -> [WorkoutSample] {
        return try await withCheckedThrowingContinuation { continuation in
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
            let query = HKSampleQuery(
                sampleType: .workoutType(),
                predicate: queryParameters.predicate,
                limit: queryParameters.limit,
                sortDescriptors: [sortDescriptor])
            { (_, samples, error) in
                guard error == nil else {
                    continuation.resume(throwing: error!)
                    return
                }
                continuation.resume(returning: (samples as! [HKWorkout]).map { WorkoutSample($0) })
            }
            healthStore.execute(query)
        }
    }
    
    func saveCompletedWorkout(
        activityType: HKWorkoutActivityType,
        startDate: Date,
        endDate: Date,
        totalEnergyBurned: Double?,
        totalDistance: Double?
    ) async throws {
        let workout = HKWorkout(
            activityType: activityType,
            start: startDate,
            end: endDate,
            workoutEvents: nil, // TODO: Add events
            totalEnergyBurned: (totalEnergyBurned != nil) ? HKQuantity(unit: .kilocalorie(), doubleValue: totalEnergyBurned!) : nil,
            totalDistance: (totalDistance != nil) ? HKQuantity(unit: .meterUnit(with: .kilo), doubleValue: totalDistance!) : nil,
            device: nil, // TODO: add device info
            metadata: nil // TODO: Add metadata info
        )
        try await healthStore.save(workout)
    }
}

