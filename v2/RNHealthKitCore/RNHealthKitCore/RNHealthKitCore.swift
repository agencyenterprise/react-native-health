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

    public func getCumulativeQuantitySamples(
        _ type: CumulativeQuantityType,
        _ queryParameters: CumulativeQuantityQuery
    ) async throws -> [QuantitySample] {
        return try await withCheckedThrowingContinuation { continuation in
            let sampleType = type.type as! HKQuantityType
            let query = HKStatisticsCollectionQuery(
                quantityType: sampleType,
                quantitySamplePredicate: queryParameters.predicate,
                options: .mostRecent,
                anchorDate: queryParameters.anchorDate,
                intervalComponents: queryParameters.interval
            )
            query.initialResultsHandler = { _, results, error in
                switchAndContinue(continuation: continuation, value: results, error: error) { collection in
                    return Self.enumerateStatistics(collection: collection, queryParameters.startDate, queryParameters.endDate, queryParameters.unit)
                }
            }
            healthStore.execute(query)
        }
    }
    
    static func enumerateStatistics(collection: HKStatisticsCollection, _ startDate: Date, _ endDate: Date, _ unit: HKUnit) -> [QuantitySample] {
        var samples: [QuantitySample] = []
        collection.enumerateStatistics(from: startDate, to: endDate) { statistics, stop in
            statistics.sumQuantity().map {
                samples.append(.init($0, unit, statistics.startDate, statistics.endDate))
            }
        }
        return samples
    }
    
    public func getQuantitySamples(_ type: QuantityType, _ queryParameters: QuantityQuery) async throws -> [QuantitySample] {
        return try await withCheckedThrowingContinuation { continuation in
            let sampleType = type.type as! HKQuantityType
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: queryParameters.predicate,
                limit: queryParameters.limit,
                sortDescriptors: [sortDescriptor])
            { (_, samples, error) in
                guard error == nil else {
                    continuation.resume(throwing: error!)
                    return
                }
                let quantitySamples = (samples as! [HKQuantitySample]).map {
                    QuantitySample($0, queryParameters.unit)
                }
                continuation.resume(returning: quantitySamples)
            }
            healthStore.execute(query)
        }
    }
}

public struct QuantitySample {
    let id: String?
    let value: Double
    let startDate: Date
    let endDate: Date
    let sourceName: String?
    let sourceId: String?
    
    init(_ sample: HKQuantitySample, _ unit: HKUnit) {
        self.id = sample.uuid.uuidString
        self.value = sample.quantity.doubleValue(for: unit)
        self.startDate = sample.startDate
        self.endDate = sample.endDate
        self.sourceName = sample.sourceRevision.source.name
        self.sourceId = sample.sourceRevision.source.bundleIdentifier
    }

    init(_ quantity: HKQuantity, _ unit: HKUnit, _ startDate: Date, _ endDate: Date) {
        self.value = quantity.doubleValue(for: unit)
        self.startDate = startDate
        self.endDate = startDate
        self.id = nil
        self.sourceName = nil
        self.sourceId = nil
    }
}
