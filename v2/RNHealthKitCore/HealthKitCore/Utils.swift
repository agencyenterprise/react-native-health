import Foundation
import HealthKit

func switchAndContinue<Value, Return>(
    continuation: CheckedContinuation<Return, Error>,
    value: Value?,
    error: Error?,
    valueBlock: (_ value: Value) throws -> Return
) rethrows {
    switch (value, error) {
    case (nil, nil): fatalError()
    case let (nil, error?): continuation.resume(throwing: error)
    case let (value?, _): continuation.resume(returning: try valueBlock(value))
    }
}

extension Date {
    func toIsoString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.string(from: self)
    }
}

extension String {
    func fromIsoStringToDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.date(from: self)!
    }

    var hkUnit: HKUnit {
        HKUnit(from: self)
    }
}
