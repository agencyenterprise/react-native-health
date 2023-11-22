import Foundation
import HealthKit

/// Represents a health-related quantity sample with associated metadata.
public struct QuantitySample: Encodable {
    /// A unique identifier for the quantity sample.
    public let id: String?

    /// The numerical value of the health-related quantity.
    public let value: Double

    /// The start date and time of the quantity measurement.
    public let startDate: String

    /// The end date and time of the quantity measurement.
    public let endDate: String

    /// The name of the source that provided the quantity sample.
    public let sourceName: String?

    /// An identifier for the data source that recorded the quantity sample.
    public let sourceId: String?

    /// Additional metadata associated with the quantity sample.
    public let metadata: [String: String]?

    /// Initializes a `QuantitySample` instance based on an `HKQuantitySample` and unit.
    ///
    /// - Parameters:
    ///   - sample: An `HKQuantitySample` containing the health-related quantity data.
    ///   - unit: The unit of measurement for the quantity data.
    init(_ sample: HKQuantitySample, _ unit: HKUnit) {
        self.id = sample.uuid.uuidString
        self.value = sample.quantity.doubleValue(for: unit)
        self.startDate = sample.startDate.toIsoString() ?? ""
        self.endDate = sample.endDate.toIsoString() ?? ""
        self.sourceName = sample.sourceRevision.source.name
        self.sourceId = sample.sourceRevision.source.bundleIdentifier
        self.metadata = sample.metadata?.mapValues(String.init(describing:)) ?? [:]
    }

    /// Initializes a `QuantitySample` instance based on quantity, unit, start date, and end date.
    ///
    /// - Parameters:
    ///   - quantity: The numerical value of the health-related quantity.
    ///   - unit: The unit of measurement for the quantity data.
    ///   - startDate: The start date and time of the quantity measurement.
    ///   - endDate: The end date and time of the quantity measurement.
    init(_ quantity: HKQuantity, _ unit: HKUnit, _ startDate: Date, _ endDate: Date) {
        self.value = quantity.doubleValue(for: unit)
        self.startDate = startDate.toIsoString() ?? ""
        self.endDate = endDate.toIsoString() ?? ""
        self.id = nil
        self.sourceName = nil
        self.sourceId = nil
        self.metadata = nil
    }
}
