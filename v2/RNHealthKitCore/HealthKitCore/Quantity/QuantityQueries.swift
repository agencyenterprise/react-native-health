import Foundation
import HealthKit

/// Provides methods for working with HealthKit quantity samples and statistics.
public extension HealthKitCore {

    /// Asynchronously retrieves quantity samples statistics for a specified `QuantityType` and query parameters.
    ///
    /// - Parameters:
    ///   - type: The `QuantityType` to retrieve statistics for.
    ///   - queryParameters: The query parameters specifying the time range, statistics options, and other criteria.
    /// - Returns: An array of `QuantitySample` objects representing the statistics data.
    /// - Throws: An error if the retrieval or processing of statistics data fails.
    func getQuantitySamplesStatistics(
        _ type: QuantityType,
        _ queryParameters: StatisticsQuantityQuery
    ) async throws -> [QuantitySample] {
        return try await withCheckedThrowingContinuation { continuation in
            let sampleType = type.type as! HKQuantityType
            let query = HKStatisticsCollectionQuery(
                quantityType: sampleType,
                quantitySamplePredicate: queryParameters.predicate,
                options: queryParameters.statisticsOption.toHKType,
                anchorDate: queryParameters.anchorDate,
                intervalComponents: queryParameters.interval
            )

            query.initialResultsHandler = { _, results, error in
                switchAndContinue(continuation: continuation, value: results, error: error) { collection in
                    return Self.enumerateStatistics(
                        collection: collection,
                        queryParameters
                    )
                }
            }
            healthStore.execute(query)
        }
    }
    
    /// Enumerates statistics data from an `HKStatisticsCollection` and returns an array of `QuantitySample` objects.
    ///
    /// - Parameters:
    ///   - collection: The `HKStatisticsCollection` containing the statistics data.
    ///   - queryParameters: The query parameters specifying statistics options and time range.
    /// - Returns: An array of `QuantitySample` objects representing the enumerated statistics data.
    static func enumerateStatistics(
        collection: HKStatisticsCollection,
        _ queryParameters: StatisticsQuantityQuery
    ) -> [QuantitySample] {
        var samples: [QuantitySample] = []
        let enumerationFunction = queryParameters.statisticsOption.enumeration
        collection.enumerateStatistics(from: queryParameters.startDate!, to: queryParameters.endDate!) { statistics, stop in
            enumerationFunction(statistics).map {
                samples.append(.init($0, queryParameters.unit, statistics.startDate, statistics.endDate))
            }
        }
        return samples
    }
    
    /// Asynchronously retrieves quantity samples for a specified `QuantityType` and query parameters.
    ///
    /// - Parameters:
    ///   - type: The `QuantityType` to retrieve quantity samples for.
    ///   - queryParameters: The query parameters specifying the time range, sorting, and other criteria.
    /// - Returns: An array of `QuantitySample` objects representing the retrieved quantity samples.
    /// - Throws: An error if the retrieval or processing of quantity samples fails.
    func getQuantitySamples(_ type: QuantityType, _ queryParameters: QuantityQuery) async throws -> [QuantitySample] {
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
    
    /// Asynchronously saves a quantity sample using the specified `QuantitySampleInsert` object.
    ///
    /// - Parameter sample: The `QuantitySampleInsert` object containing data for the quantity sample.
    /// - Throws: An error if the saving of the quantity sample fails.
    func saveQuantitySample(_ sample: QuantitySampleInsert) async throws {
        let type = sample.type.type as! HKQuantityType
        let unit = sample.unit
        let quantity = HKQuantity(unit: unit, doubleValue: sample.value)
        try await self.healthStore.save(
            HKQuantitySample(type: type, quantity: quantity, start: sample.startDate, end: sample.endDate, metadata: sample.metadata)
        )
    }
}
