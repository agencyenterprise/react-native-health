import Foundation
import HealthKit

@objc(RNHealthKitWrapper)
class RNHealthKitWrapper: NSObject {
    var core: HealthKitCore?

    @objc
    func initHealthKit(_ read: Array<String>, write: Array<String>, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
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

    @objc
    func getQuantitySamples(_ type: String, query: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                guard
                    let unit = (query["unit"] as? String)?.hkUnit,
                    let sampleType: QuantityType = .init(rawValue: type)
                else {
                        reject("getQuantitySamples", "Invalid parameters, check the unit and type.", nil)
                        return
                }
                let parameters = QuantityQuery(
                    startDate: (query["startDate"] as? String)?.fromIsoStringToDate(),
                    endDate: (query["endDate"] as? String)?.fromIsoStringToDate(),
                    isUserEntered: query["isUserEntered"] as? Bool,
                    limit: query["limit"] as? Int ?? HKObjectQueryNoLimit,
                    unit: unit
                )
                let result = try await core?.getQuantitySamples(sampleType, parameters)
                let json = try JSONEncoder().encode(result)
                resolve(String(data: json, encoding: .utf8))
            } catch {
                reject("getQuantitySamples", error.localizedDescription, error)
            }
        }
    }
    
    @objc
    func getQuantitySamplesAggregation(_ type: String, query: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                guard
                    let unit = (query["unit"] as? String)?.hkUnit,
                    let sampleType: QuantityType = .init(rawValue: type),
                    let startDate = (query["startDate"] as? String)?.fromIsoStringToDate(),
                    let endDate = (query["endDate"] as? String)?.fromIsoStringToDate(),
                    let optionStr = (query["option"] as? String),
                    let option: AggregationOptions = .init(rawValue: optionStr)
                else {
                        reject("getQuantitySamplesAggregation", "Invalid parameters, check the unit and type.", nil)
                        return
                }
                let parameters = AggregationQuantityQuery(
                    startDate: startDate,
                    endDate: endDate,
                    unit: unit,
                    aggregationOption: option,
                    isUserEntered: query["isUserEntered"] as? Bool
                )
                let result = try await core?.getQuantitySamplesAggregation(sampleType, parameters)
                let json = try JSONEncoder().encode(result)
                resolve(String(data: json, encoding: .utf8))
            } catch {
                reject("getQuantitySamplesAggregation", error.localizedDescription, error)
                return
            }
        }
    }
}
