import Foundation
import HealthKit

func switchAndContinue<Value, Return>(
    continuation: CheckedContinuation<Return, Error>,
    value: Value?,
    error: Error?,
    valueBlock: (_ value: Value) throws -> Return
) rethrows {
    switch (value, error) {
    case (nil, nil): fatalError() // TODO: Handle this case -  Create an internal error and throw
    case let (nil, error?): continuation.resume(throwing: error)
    case let (value?, _): continuation.resume(returning: try valueBlock(value))
    }
}

func switchAndContinue(
    continuation: CheckedContinuation<Bool, Error>,
    value: Bool,
    error: Error?
) {
    switch (value, error) {
    case (false, nil): fatalError() // TODO: Handle this case -  Create an internal error and throw
    case let (false, error?): continuation.resume(throwing: error)
    case (true, _): continuation.resume(returning: true)
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
