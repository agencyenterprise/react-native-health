import Foundation

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
