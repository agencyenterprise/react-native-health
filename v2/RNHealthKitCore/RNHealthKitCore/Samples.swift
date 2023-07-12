import Foundation
import HealthKit

public struct QuantitySample: Encodable {
    let id: String?
    let value: Double
    let startDate: Date
    let endDate: Date
    let sourceName: String?
    let sourceId: String?
    let metadata: [String: String]?
    
    init(_ sample: HKQuantitySample, _ unit: HKUnit) {
        self.id = sample.uuid.uuidString
        self.value = sample.quantity.doubleValue(for: unit)
        self.startDate = sample.startDate
        self.endDate = sample.endDate
        self.sourceName = sample.sourceRevision.source.name
        self.sourceId = sample.sourceRevision.source.bundleIdentifier
        self.metadata = sample.metadata?.mapValues(String.init(describing:)) ?? [:]
    }

    init(_ quantity: HKQuantity, _ unit: HKUnit, _ startDate: Date, _ endDate: Date) {
        self.value = quantity.doubleValue(for: unit)
        self.startDate = startDate
        self.endDate = startDate
        self.id = nil
        self.sourceName = nil
        self.sourceId = nil
        self.metadata = nil
    }
}
