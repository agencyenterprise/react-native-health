import Foundation
import HealthKit


public class QuantityQuery: QueryParameters {
    let unit: HKUnit
    
    public init(startDate: Date?, endDate: Date?, ids: [String]?, isUserEntered: Bool? = nil, limit: Int = HKObjectQueryNoLimit, unit: HKUnit) {
        self.unit = unit
        super.init(startDate: startDate, endDate: endDate, isUserEntered: isUserEntered, limit: limit, ids: ids)
    }
}

public class StatisticsQuantityQuery: QueryParameters {
    let interval: DateComponents
    let anchorDate: Date
    let unit: HKUnit
    let statisticsOption: StatisticsOptions
    
    public init(
        startDate: Date,
        endDate: Date = Date(),
        interval: DateComponents = .init(day: 1),
        anchorDate: Date = Calendar(identifier: .gregorian).startOfDay(for: Date()),
        unit: HKUnit,
        statisticsOption: StatisticsOptions,
        isUserEntered: Bool? = nil
    ) {
        self.interval = interval
        self.anchorDate = anchorDate
        self.unit = unit
        self.statisticsOption = statisticsOption
        super.init(startDate: startDate, endDate: endDate, isUserEntered: isUserEntered, limit: HKObjectQueryNoLimit, ids: nil)
    }
}

public struct QuantitySampleInsert {
    let type: QuantityType
    let value: Double
    let unit: HKUnit
    let startDate: Date
    let endDate: Date
    let metadata: [String: Any]?
    
    public init(type: QuantityType, value: Double, unit: HKUnit, startDate: Date, endDate: Date, metadata: [String: Any]? = nil) {
        self.type = type
        self.value = value
        self.unit = unit
        self.startDate = startDate
        self.endDate = endDate
        self.metadata = metadata
    }
}

public enum StatisticsOptions: String {
    case discreteAverage
    case discreteMin
    case discreteMax
    case cumulativeSum
    case mostRecent
    case duration
    
    var enumeration: (HKStatistics) -> (HKQuantity?) {
        switch self {
        case .discreteAverage:
            return { statistics in return statistics.averageQuantity()}
        case .discreteMin:
            return { statistics in return statistics.minimumQuantity()}
        case .discreteMax:
            return { statistics in return statistics.maximumQuantity()}
        case .cumulativeSum:
            return { statistics in return statistics.sumQuantity()}
        case .mostRecent:
            return { statistics in return statistics.mostRecentQuantity()}
        case .duration:
            return { statistics in return statistics.duration()}
        }
    }

    var toHKType: HKStatisticsOptions {
        switch self {
        case .discreteAverage:
            return .discreteAverage
        case .discreteMin:
            return .discreteMin
        case .discreteMax:
            return .discreteMax
        case .cumulativeSum:
            return .cumulativeSum
        case .mostRecent:
            return .mostRecent
        case .duration:
            return .duration
        }
    }
}

public enum StatisticsInterval: String {
    case hour
    case day
    case week
    case month
    case year
    
    var dateComponents: DateComponents {
        switch self {
        case .hour:
            return DateComponents(hour: 1)
        case .day:
            return DateComponents(day: 1)
        case .week:
            return DateComponents(day: 7)
        case .month:
            return DateComponents(month: 1)
        case .year:
            return DateComponents(year: 1)
        }
    }
}
