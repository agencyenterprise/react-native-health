import Foundation

@objc(RNHealthKitWrapper)
class RNHealthKitWrapper: NSObject {
    var core: HealthKitCore?

    @objc
    func initHealthKit(_ read: Array<String>, write: Array<String>, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock ) {
        Task {
            do {
                let readTypes: Array<QuantityType> = read.compactMap { .init(rawValue: $0) }
                let writeTypes: Array<QuantityType> = write.compactMap { .init(rawValue: $0) }
                
                core = try await HealthKitCore.init(read: readTypes, write: writeTypes)
                resolve(true)
            } catch {
                reject("initHealthKit", error.localizedDescription, error)
            }
        }
    }
}
