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
        try await handleSaveCompletedWorkout(
            activityType: activityType,
            startDate: startDate,
            endDate: endDate,
            totalEnergyBurned: totalEnergyBurned,
            totalDistance: totalDistance,
            metadata: metadata,
            completion: nil
        )
    }

    /// Saves a completed workout to HealthKit with specified parameters and additional activities.
    /// - Parameters:
    ///   - activityType: The type of physical activity for the workout.
    ///   - startDate: The start date and time of the workout.
    ///   - endDate: The end date and time of the workout.
    ///   - totalEnergyBurned: The total energy burned during the workout (in kilocalories).
    ///   - totalDistance: The total distance covered during the workout (in kilometers).
    ///   - activities: Optional array of `WorkoutActivity` to include in the workout.
    ///   - metadata: Optional metadata for the workout.
    /// - Throws: An error if the workout data cannot be saved to HealthKit.
    @available(iOS 16.0, *)
    func saveCompletedWorkout(
        activityType: HKWorkoutActivityType,
        startDate: Date,
        endDate: Date,
        totalEnergyBurned: Double?,
        totalDistance: Double?,
        activities: [WorkoutActivity]?,
        metadata: [String: Any]?
    ) async throws -> HKWorkout? {
        let handleActivities: ((HKWorkoutConfiguration, HKWorkoutBuilder) async throws -> Void)? = activities != nil ? { configuration, builder in
            if let activities {
                for activity in activities {
                    let workoutConfiguration = activity.workoutConfiguration
                    if let activityType = workoutConfiguration.workoutActivityType {
                        configuration.activityType = activityType
                    }

                    if let locationType = workoutConfiguration.workoutLocationType {
                        configuration.locationType = locationType
                    }

                    if let swimmingLocationType = workoutConfiguration.workoutSwimmingLocationType {
                        configuration.swimmingLocationType = swimmingLocationType
                    }

                    if let lapLength = workoutConfiguration.workoutLapLength {
                        configuration.lapLength = HKQuantity(quantity: lapLength)
                    }
                    try await builder.addWorkoutActivity(
                        HKWorkoutActivity(
                            workoutConfiguration: configuration,
                            start: activity.startDate.fromIsoStringToDate(),
                            end: activity.endDate?.fromIsoStringToDate(),
                            metadata: activity.metadata
                        )
                    )
                }
            }
        } : nil

        return try await handleSaveCompletedWorkout(
            activityType: activityType,
            startDate: startDate,
            endDate: endDate,
            totalEnergyBurned: totalEnergyBurned,
            totalDistance: totalDistance,
            metadata: metadata,
            completion: handleActivities
        )
    }

    private func handleSaveCompletedWorkout(
        activityType: HKWorkoutActivityType,
        startDate: Date,
        endDate: Date,
        totalEnergyBurned: Double?,
        totalDistance: Double?,
        metadata: [String: Any]?,
        completion: ((HKWorkoutConfiguration, HKWorkoutBuilder) async throws -> Void)?
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

        try await completion?(configuration, workoutBuilder)

        if let metadata {
            try await workoutBuilder.addMetadata(metadata)
        }

        try await workoutBuilder.endCollection(at: endDate)

        return try await workoutBuilder.finishWorkout()
    }
}
