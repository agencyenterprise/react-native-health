import Foundation
import HealthKit

public class WorkoutQueryParameters: QueryParameters {
    let activityTypes: [UInt]?
    
    override var predicate: NSPredicate {
        var predicates = [super.predicate]
        if let predicateActivityType = predicateActivityTypes {
            predicates.append(predicateActivityType)
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates:predicates)
    }
    
    public init(startDate: Date?, endDate: Date?, activityTypes: [UInt]?, ids: [String]?, isUserEntered: Bool?, limit: Int = HKObjectQueryNoLimit) {
        self.activityTypes = activityTypes
        super.init(startDate: startDate, endDate: endDate, isUserEntered: isUserEntered, limit: limit, ids: ids)
    }

    private var predicateActivityTypes: NSPredicate? {
        guard let activityTypes = activityTypes else { return nil }
        let predicates: [NSPredicate] = activityTypes.compactMap {
            guard let type = HKWorkoutActivityType(rawValue: $0) else { return nil }
            return HKQuery.predicateForWorkouts(with: type)
        }
        return NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
}
