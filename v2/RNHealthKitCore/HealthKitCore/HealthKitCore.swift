import HealthKit

public class HealthKitCore {
    let healthStore: HKHealthStore

    public init(read: [any HealthKitType], write: [any HealthKitType]) async throws {
        healthStore = HKHealthStore()
        if #available(iOS 15.0, *) {
            try await healthStore.requestAuthorization(
                toShare: Set(write.map{ $0.type }),
                read: Set(read.map{ $0.type })
            )
        } else {
            // Fallback on earlier versions
        }
    }
}
