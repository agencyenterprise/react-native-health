import Foundation
import HealthKit

public class QueryParameters {
    let startDate: Date?
    let endDate: Date?
    let isUserEntered: Bool?
    let limit: Int
    let ids: [String]?
    
    var predicate: NSPredicate {
        let datePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate])
        var predicates: [NSPredicate] = [datePredicate]

        if let predicateAvoidManuallyLoggedData = predicateAvoidManuallyLoggedData {
            predicates.append(predicateAvoidManuallyLoggedData)
        }

        if let predicateIds = predicateIds {
            predicates.append(predicateIds)
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates:predicates)
    }
    
    init(startDate: Date?, endDate: Date?, isUserEntered: Bool?, limit: Int, ids: [String]?) {
        self.startDate = startDate
        self.endDate = endDate
        self.isUserEntered = isUserEntered
        self.limit = limit
        self.ids = ids
    }
    
    private var predicateAvoidManuallyLoggedData: NSPredicate? {
        guard let isUserEntered = isUserEntered else { return nil }
        let operatorType: NSComparisonPredicate.Operator = isUserEntered ? .equalTo : .notEqualTo
        return HKQuery.predicateForObjects(withMetadataKey: HKMetadataKeyWasUserEntered, operatorType: operatorType, value: true)
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
