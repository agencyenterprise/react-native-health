import Foundation
import HealthKit

/// Defines query parameters used for fetching health data from HealthKit.
public class QueryParameters {
    // MARK: - Properties

    /// The start date of the data range to query.
    let startDate: Date?

    /// The end date of the data range to query.
    let endDate: Date?

    /// Specifies whether to include/exclude manually entered data.
    let isUserEntered: Bool?

    /// The maximum number of results to retrieve in a query.
    let limit: Int

    /// An array of UUIDs to filter data by specific IDs.
    let ids: [String]?

    // MARK: - Computed Properties

    /// Generates an NSPredicate based on the specified query parameters.
    var predicate: NSPredicate {
        let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate])
        var predicates: [NSPredicate] = [datePredicate]

        if let predicateAvoidManuallyLoggedData {
            predicates.append(predicateAvoidManuallyLoggedData)
        }

        if let predicateIds {
            predicates.append(predicateIds)
        }

        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }

    // MARK: - Initializer

    /// Initializes a QueryParameters object with the specified query criteria.
    ///
    /// - Parameters:
    ///   - startDate: The start date of the data range to query.
    ///   - endDate: The end date of the data range to query.
    ///   - isUserEntered: Specifies whether to include/exclude manually entered data.
    ///   - limit: The maximum number of results to retrieve in a query.
    ///   - ids: An array of UUIDs to filter data by specific IDs.
    init(startDate: Date?, endDate: Date?, isUserEntered: Bool?, limit: Int, ids: [String]?) {
        self.startDate = startDate
        self.endDate = endDate
        self.isUserEntered = isUserEntered
        self.limit = limit
        self.ids = ids
    }

    // MARK: - Private Methods

    /// Generates an NSPredicate to filter out manually logged data if specified.
    private var predicateAvoidManuallyLoggedData: NSPredicate? {
        guard let isUserEntered else { return nil }
        let operatorType: NSComparisonPredicate.Operator = isUserEntered ? .equalTo : .notEqualTo
        return HKQuery.predicateForObjects(withMetadataKey: HKMetadataKeyWasUserEntered, operatorType: operatorType, value: true)
    }

    /// Generates an NSPredicate to filter data by specific IDs if provided.
    private var predicateIds: NSPredicate? {
        guard let ids else { return nil }
        let predicates: [NSPredicate] = ids.compactMap {
            guard let id = UUID(uuidString: $0) else { return nil }
            return HKQuery.predicateForObject(with: id)
        }
        // Combine predicates using an "OR" operation
        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
}
