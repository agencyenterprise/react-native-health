import Foundation
import HealthKit

/// Defines query parameters used for fetching workout data from HealthKit.
public class WorkoutQueryParameters: QueryParameters {
    /// An array of raw unsigned integer values representing workout activity types to filter by.
    let activityTypes: [UInt]?

    /// Combines the base predicate with activity type filtering.
    override var predicate: NSPredicate {
        var predicates = [super.predicate]
        if let predicateActivityType = predicateActivityTypes {
            predicates.append(predicateActivityType)
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }

    /// Initializes a `WorkoutQueryParameters` object with the specified query criteria.
    ///
    /// - Parameters:
    ///   - startDate: The start date of the data range to query.
    ///   - endDate: The end date of the data range to query.
    ///   - activityTypes: An array of raw unsigned integer values representing workout activity types to filter by.
    ///   - ids: An array of UUIDs to filter data by specific IDs.
    ///   - isUserEntered: Specifies whether to include/exclude manually entered data.
    ///   - limit: The maximum number of results to retrieve in a query.
    public init(startDate: Date? = nil, endDate: Date? = nil, activityTypes: [UInt]? = nil, ids: [String]? = nil, isUserEntered: Bool? = nil, limit: Int = HKObjectQueryNoLimit) {
        self.activityTypes = activityTypes
        super.init(startDate: startDate, endDate: endDate, isUserEntered: isUserEntered, limit: limit, ids: ids)
    }

    /// Generates an NSPredicate to filter workouts by the specified activity types if provided.
    private var predicateActivityTypes: NSPredicate? {
        guard let activityTypes = activityTypes else { return nil }
        let predicates: [NSPredicate] = activityTypes.compactMap {
            guard let type = HKWorkoutActivityType(rawValue: $0) else { return nil }
            return HKQuery.predicateForWorkouts(with: type)
        }
        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
}
