import Foundation
import HealthKit


public struct QuantityQuery {
    let startDate: Date?
    let endDate: Date?
    let isUserEntered: Bool?
    let limit: Int
    let unit: HKUnit
    var predicate: NSPredicate {
        HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate])
    }
    
    public init(startDate: Date?, endDate: Date?, isUserEntered: Bool? = nil, limit: Int = HKObjectQueryNoLimit, unit: HKUnit) {
        self.startDate = startDate
        self.endDate = endDate
        self.isUserEntered = isUserEntered
        self.limit = limit
        self.unit = unit
    }
}

public struct CumulativeQuantityQuery {
    let startDate: Date
    let endDate: Date
    let isUserEntered: Bool?
    let interval: DateComponents
    let anchorDate: Date
    let unit: HKUnit
    var predicate: NSPredicate {
        HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [.strictStartDate])
    }
    
    public init(
        startDate: Date,
        endDate: Date = Date(),
        isUserEntered: Bool? = nil,
        interval: DateComponents = .init(day: 1),
        anchorDate: Date = Calendar(identifier: .gregorian).startOfDay(for: Date()),
        unit: HKUnit
    ) {
        self.startDate = startDate
        self.endDate = endDate
        self.isUserEntered = isUserEntered
        self.interval = interval
        self.anchorDate = anchorDate
        self.unit = unit
    }
}
