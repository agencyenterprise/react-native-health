import Foundation
import HealthKit

public struct Statistics: Codable {
    public let quantityType: QuantityType
    public let startDate: String
    public let endDate: String
    public let averageQuantity: Quantity?
    public let minimumQuantity: Quantity?
    public let maximumQuantity: Quantity?
    public let mostRecentQuantity: Quantity?
    public let sumQuantity: Quantity?
    public let duration: Double?

    public init?(from hkStatistics: HKStatistics) {
        guard let quantityType = QuantityType.from(hkStatistics.quantityType),
              let startDate = hkStatistics.startDate.toIsoString(),
              let endDate = hkStatistics.endDate.toIsoString()
        else {
            return nil
        }
        self.quantityType = quantityType

        self.startDate = startDate
        self.endDate = endDate
        self.averageQuantity = Self.parseToQuantity(quantityString: hkStatistics.averageQuantity()?.description)
        self.minimumQuantity = Self.parseToQuantity(quantityString: hkStatistics.minimumQuantity()?.description)
        self.maximumQuantity = Self.parseToQuantity(quantityString: hkStatistics.maximumQuantity()?.description)
        self.mostRecentQuantity = Self.parseToQuantity(quantityString: hkStatistics.mostRecentQuantity()?.description)
        self.sumQuantity = Self.parseToQuantity(quantityString: hkStatistics.sumQuantity()?.description)
        self.duration = hkStatistics.duration()?.doubleValue(for: .second())
    }

    private static func parseToQuantity(quantityString: String?) -> Quantity? {
        guard let quantityParts = quantityString?.description.components(separatedBy: " "),
              quantityParts.count > 2,
              let doubleValue = Double(quantityParts[0]) else {
            return nil
        }

        let unit = HKUnit(from: quantityParts[1])
        return Quantity(unit: unit, doubleValue: doubleValue)
    }
}
