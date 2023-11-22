import Foundation
import HealthKit

/// Queries quantity-based health data using HealthKit.
public class QuantityQuery: QueryParameters {
    /// The unit of measurement for the queried health data.
    let unit: HKUnit

    /// Initializes a QuantityQuery instance for querying quantity-based health data.
    ///
    /// - Parameters:
    ///   - startDate: The start date of the data range to query.
    ///   - endDate: The end date of the data range to query.
    ///   - ids: An array of UUIDs to filter data by specific IDs.
    ///   - isUserEntered: Specifies whether to include/exclude manually entered data.
    ///   - limit: The maximum number of results to retrieve in a query (default is HKObjectQueryNoLimit).
    ///   - unit: The unit of measurement for the queried health data.
    public init(startDate: Date?, endDate: Date?, ids: [String]?, isUserEntered: Bool? = nil, limit: Int = HKObjectQueryNoLimit, unit: HKUnit) {
        self.unit = unit
        super.init(startDate: startDate, endDate: endDate, isUserEntered: isUserEntered, limit: limit, ids: ids)
    }
}

/// A class for querying statistics of quantity-based health data using HealthKit.
public class StatisticsQuantityQuery: QueryParameters {
    /// The time interval for statistics calculations.
    let interval: DateComponents
    /// The anchor date for statistics calculations.
    let anchorDate: Date
    /// The unit of measurement for the queried health data.
    let unit: HKUnit
    /// The statistical option to apply to the queried data.
    let statisticsOption: StatisticsOptions

    /// Initializes a StatisticsQuantityQuery instance for querying statistics of quantity-based health data.
    ///
    /// - Parameters:
    ///   - startDate: The start date of the data range to query.
    ///   - endDate: The end date of the data range to query.
    ///   - interval: The time interval for statistics calculations (default is 1 day).
    ///   - anchorDate: The anchor date for statistics calculations (default is the start of the day).
    ///   - unit: The unit of measurement for the queried health data.
    ///   - statisticsOption: The statistical option to apply to the queried data.
    ///   - isUserEntered: Specifies whether to include/exclude manually entered data.
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

/// A struct representing data to insert as a quantity-based health data sample into HealthKit.
public struct QuantitySampleInsert {
    /// The type of quantity data to insert.
    let type: QuantityType
    /// The measurement value to insert.
    let value: Double
    /// The unit of measurement for the inserted data.
    let unit: HKUnit
    /// The start date and time of the data sample.
    let startDate: Date
    /// The end date and time of the data sample.
    let endDate: Date
    /// Additional metadata associated with the data sample.
    let metadata: [String: Any]?

    /// Initializes a QuantitySampleInsert instance for inserting quantity-based health data into HealthKit.
    ///
    /// - Parameters:
    ///   - type: The type of quantity data to insert.
    ///   - value: The measurement value to insert.
    ///   - unit: The unit of measurement for the inserted data.
    ///   - startDate: The start date and time of the data sample.
    ///   - endDate: The end date and time of the data sample.
    ///   - metadata: Additional metadata associated with the data sample.
    public init(type: QuantityType, value: Double, unit: HKUnit, startDate: Date, endDate: Date, metadata: [String: Any]? = nil) {
        self.type = type
        self.value = value
        self.unit = unit
        self.startDate = startDate
        self.endDate = endDate
        self.metadata = metadata
    }
}

/// Represents various statistical options for quantity-based health data.
public enum StatisticsOptions: String {
    /// Calculate the discrete average of the data.
    case discreteAverage
    /// Calculate the discrete minimum value of the data.
    case discreteMin
    /// Calculate the discrete maximum value of the data.
    case discreteMax
    /// Calculate the cumulative sum of the data.
    case cumulativeSum
    /// Get the most recent data value.
    case mostRecent
    /// Calculate the duration of data collection.
    case duration

    var enumeration: (HKStatistics) -> (HKQuantity?) {
        switch self {
        case .discreteAverage:
            return { statistics in return statistics.averageQuantity() }
        case .discreteMin:
            return { statistics in return statistics.minimumQuantity() }
        case .discreteMax:
            return { statistics in return statistics.maximumQuantity() }
        case .cumulativeSum:
            return { statistics in return statistics.sumQuantity() }
        case .mostRecent:
            return { statistics in return statistics.mostRecentQuantity() }
        case .duration:
            return { statistics in return statistics.duration() }
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

/// Represents different time intervals for statistics calculations.
public enum StatisticsInterval: String {
    case hour
    case day
    case week
    case month
    case year

    /// Get the corresponding `DateComponents` for the interval.
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
