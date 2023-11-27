import HealthKit

/// Manages interactions with Apple's HealthKit framework.
public class HealthKitCore {
    /// The HealthKit store used to interact with health data.
    let healthStore: HKHealthStore

    /// Initializes a HealthKitCore instance.
    ///
    /// - Parameters:
    ///   - healthStore: The `HKHealthStore` instance to use for HealthKit interactions.
    ///                  If not provided, a new instance is created.
    ///   - read: An array of health data types that the app intends to read from HealthKit.
    ///   - write: An array of health data types that the app intends to write to HealthKit.
    /// - Throws: An error if there is an issue with requesting authorization.
    public init(healthStore: HKHealthStore = .init(), read: [any HealthKitType], write: [any HealthKitType]) async throws {
        self.healthStore = healthStore

        if #available(iOS 15.0, *) {
            try await healthStore.requestAuthorization(
                toShare: Set(write.map{ $0.type }),
                read: Set(read.map{ $0.type })
            )
        } else {
            _ = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Bool, Swift.Error>) in
                healthStore.requestAuthorization(
                    toShare: Set(write.map{ $0.type }),
                    read: Set(read.map{ $0.type }))
                {
                    switchAndContinue(continuation: continuation, value: $0, error: $1)
                }
            }
        }
    }
}
