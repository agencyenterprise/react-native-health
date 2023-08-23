import Foundation
import HealthKit

public struct QuantitySample: Encodable {
    public let id: String?
    public let value: Double
    public let startDate: String
    public let endDate: String
    public let sourceName: String?
    public let sourceId: String?
    public let metadata: [String: String]?
    
    init(_ sample: HKQuantitySample, _ unit: HKUnit) {
        self.id = sample.uuid.uuidString
        self.value = sample.quantity.doubleValue(for: unit)
        self.startDate = sample.startDate.toIsoString() ?? ""
        self.endDate = sample.endDate.toIsoString() ?? ""
        self.sourceName = sample.sourceRevision.source.name
        self.sourceId = sample.sourceRevision.source.bundleIdentifier
        self.metadata = sample.metadata?.mapValues(String.init(describing:)) ?? [:]
    }

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
