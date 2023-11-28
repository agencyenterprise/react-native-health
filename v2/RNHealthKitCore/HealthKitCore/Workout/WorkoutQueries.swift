import Foundation
import HealthKit

public extension HealthKitCore {
    /// Fetches completed workout samples from HealthKit based on the provided query parameters.
    ///
    /// - Parameters:
    ///   - queryParameters: A `WorkoutQueryParameters` object specifying the criteria for the workout query.
    /// - Returns: An array of `WorkoutSample` objects representing completed workouts that match the query criteria.
    /// - Throws: An error if the query or data retrieval encounters any issues.
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

    /// Saves a completed workout to HealthKit with the specified parameters.
    ///
    /// - Parameters:
    ///   - activityType: The type of physical activity for the workout.
    ///   - startDate: The start date and time of the workout.
    ///   - endDate: The end date and time of the workout.
    ///   - totalEnergyBurned: The total energy burned during the workout (in kilocalories).
    ///   - totalDistance: The total distance covered during the workout (in kilometers).
    ///   - metadata: Optional metadata for the workout.
    /// - Throws: An error if the workout data cannot be saved to HealthKit.
    func saveCompletedWorkout(
        activityType: HKWorkoutActivityType,
        startDate: Date,
        endDate: Date,
        totalEnergyBurned: Double?,
        totalDistance: Double?,
        metadata: [String: Any]?
    ) async throws -> HKWorkout? {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = activityType
        let workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: configuration, device: .local())

        try await workoutBuilder.beginCollection(at: startDate)

        var samples: [HKSample] = []
        if let energyBurned = totalEnergyBurned {
            let energyQuantity = HKQuantity(unit: .kilocalorie(), doubleValue: energyBurned)
            let energySample = HKQuantitySample(
                type: HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
                quantity: energyQuantity,
                start: startDate,
                end: endDate
            )
            samples.append(energySample)
        }

        if let distance = totalDistance {
            let distanceQuantity = HKQuantity(unit: .meterUnit(with: .kilo), doubleValue: distance)
            let distanceSample = HKQuantitySample(
                type: HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                quantity: distanceQuantity,
                start: startDate,
                end: endDate
            )
            samples.append(distanceSample)
        }

        if let metadata {
            try await workoutBuilder.addMetadata(metadata)
        }

        try await workoutBuilder.endCollection(at: endDate)

        return try await workoutBuilder.finishWorkout()
    }
}
