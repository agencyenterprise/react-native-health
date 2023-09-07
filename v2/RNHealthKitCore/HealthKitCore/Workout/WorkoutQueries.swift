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
}

