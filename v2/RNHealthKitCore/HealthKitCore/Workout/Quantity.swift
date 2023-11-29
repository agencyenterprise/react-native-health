import Foundation
import HealthKit

public struct WorkoutQuantity: Codable {
    public let unit: HKUnit
    public let doubleValue: Double

    private enum CodingKeys: String, CodingKey {
        case unit
        case doubleValue
    }

    public init(unit: HKUnit, doubleValue: Double) {
        self.unit = unit
        self.doubleValue = doubleValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let unitString = try container.decode(String.self, forKey: .unit)
        let doubleValue = try container.decode(Double.self, forKey: .doubleValue)
        self.unit = HKUnit(from: unitString)
        self.doubleValue = doubleValue
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unit.unitString, forKey: .unit)
        try container.encode(doubleValue, forKey: .doubleValue)
    }
}

extension HKQuantity {
    public convenience init(quantity: WorkoutQuantity) {
        self.init(unit: quantity.unit, doubleValue: quantity.doubleValue)
    }
}
