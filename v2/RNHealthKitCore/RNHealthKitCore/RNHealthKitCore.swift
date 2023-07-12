import HealthKit

public class RNHealthKitCore {
    let healthStore: HKHealthStore

    public init(read: [any HealthKitType], write: [any HealthKitType]) async throws {
        healthStore = HKHealthStore()
        try await healthStore.requestAuthorization(
            toShare: Set(write.map{ $0.type }),
            read: Set(read.map{ $0.type })
        )
    }
}
