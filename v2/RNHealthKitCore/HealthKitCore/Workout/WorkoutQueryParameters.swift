import Foundation
import HealthKit

public struct WorkoutQueryParameters {
    let startDate: Date?
    let endDate: Date?
    let activityTypes: [UInt]?
    let ids: [String]?
    let isUserEntered: Bool?
    let limit: Int
    
    var predicate: NSPredicate {
        let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate])
        var predicates: [NSPredicate] = [datePredicate]
        if let predicateAvoidManuallyLoggedData = predicateAvoidManuallyLoggedData {
            predicates.append(predicateAvoidManuallyLoggedData)
        }
        if let predicateActivityType = predicateActivityTypes {
            predicates.append(predicateActivityType)
        }
        if let predicateIds = predicateIds {
            predicates.append(predicateIds)
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates:predicates)
    }
    
    public init(startDate: Date?, endDate: Date?, activityTypes: [UInt]?, ids: [String]?, isUserEntered: Bool?, limit: Int = HKObjectQueryNoLimit) {
        self.startDate = startDate
        self.endDate = endDate
        self.isUserEntered = isUserEntered
        self.limit = limit
        self.activityTypes = activityTypes
        self.ids = ids
    }

    private var predicateAvoidManuallyLoggedData: NSPredicate? {
        guard let isUserEntered = isUserEntered else { return nil }
        let operatorType: NSComparisonPredicate.Operator = isUserEntered ? .equalTo : .notEqualTo
        return HKQuery.predicateForObjects(withMetadataKey: HKMetadataKeyWasUserEntered, operatorType: operatorType, value: true)
    }

    private var predicateActivityTypes: NSPredicate? {
        guard let activityTypes = activityTypes else { return nil }
        let predicates: [NSPredicate] = activityTypes.compactMap {
            guard let type = HKWorkoutActivityType(rawValue: $0) else { return nil }
            return HKQuery.predicateForWorkouts(with: type)
        }
        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }

    private var predicateIds: NSPredicate? {
        guard let ids = ids else { return nil }
        let predicates: [NSPredicate] = ids.compactMap {
            guard let id = UUID(uuidString: $0) else { return nil }
            return HKQuery.predicateForObject(with: id)
        }
        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
}
