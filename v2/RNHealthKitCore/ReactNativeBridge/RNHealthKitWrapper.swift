import Foundation
import HealthKit

@objc(RNHealthKitWrapper)
class RNHealthKitWrapper: NSObject {
    var core: HealthKitCore?
    
    /**
     Initializes the HealthKitCore instance with specified read and write permissions.

     - Parameters:
       - read: An array of strings representing the read permissions to request.
       - write: An array of strings representing the write permissions to request.
       - resolve: A callback function to resolve the promise upon successful initialization.
       - reject: A callback function to reject the promise if initialization fails.

     Initializes the `HealthKitCore` instance with the requested permissions and resolves the promise with `true` upon successful initialization. If any errors occur during initialization, it rejects the promise with an error message.
     */
    @objc
    func initHealthKit(_ read: [String], write: [String], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let readTypes: [any HealthKitType] = read.compactMap { QuantityType(rawValue: $0) ?? WorkoutType(rawValue: $0) }
                let writeTypes: [any HealthKitType] = write.compactMap { QuantityType(rawValue: $0) ?? WorkoutType(rawValue: $0) }

                core = try await HealthKitCore.init(read: readTypes, write: writeTypes)
                resolve(true)
            } catch {
                reject("initHealthKit", error.localizedDescription, error)
            }
        }
    }
    
    /**
     Retrieves quantity samples from HealthKit based on specified query parameters.

     - Parameters:
       - query: A dictionary containing query parameters, including sample type, unit, date range, and optional parameters.
       - resolve: A callback function to resolve the promise with the retrieved data.
       - reject: A callback function to reject the promise with an error message if the retrieval fails.

     Retrieves quantity samples from HealthKit based on the provided query parameters. It resolves the promise with a JSON string containing the quantity samples upon successful retrieval. If any errors occur during the retrieval process, it rejects the promise with an error message.
     */
    @objc
    func getQuantitySamples(_ query: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                guard
                    let unit = (query["unit"] as? String)?.hkUnit,
                    let type = query["type"] as? String,
                    let sampleType: QuantityType = .init(rawValue: type)
                else {
                        reject("getQuantitySamples", "Invalid parameters, check the unit and type.", nil)
                        return
                }
                let parameters = QuantityQuery(
                    startDate: (query["startDate"] as? String)?.fromIsoStringToDate(),
                    endDate: (query["endDate"] as? String)?.fromIsoStringToDate(),
                    ids: query["ids"] as? [String],
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

    /**
     Retrieves statistics for quantity samples from HealthKit based on specified query parameters.

     - Parameters:
       - query: A dictionary containing query parameters, including sample type, unit, date range, statistics option, and optional parameters.
       - resolve: A callback function to resolve the promise with the retrieved data.
       - reject: A callback function to reject the promise with an error message if the retrieval fails.

     Retrieves statistics for quantity samples from HealthKit based on the provided query parameters. It resolves the promise with a JSON string containing the quantity sample statistics upon successful retrieval. If any errors occur during the retrieval process, it rejects the promise with an error message.
     */
    @objc
    func getQuantitySamplesStatistics(_ query: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                guard
                    let unit = (query["unit"] as? String)?.hkUnit,
                    let type = query["type"] as? String,
                    let sampleType: QuantityType = .init(rawValue: type),
                    let startDate = (query["startDate"] as? String)?.fromIsoStringToDate(),
                    let endDate = (query["endDate"] as? String)?.fromIsoStringToDate(),
                    let optionStr = (query["option"] as? String),
                    let option: StatisticsOptions = .init(rawValue: optionStr)
                else {
                        reject("getQuantitySamplesStatistics", "Invalid parameters.", nil)
                        return
                }

                let intervalStr = query["interval"] as? String ?? ""
                let interval = StatisticsInterval(rawValue: intervalStr) ?? .day
                let anchorDate = (query["anchorDate"] as? String)?.fromIsoStringToDate() ?? Calendar(identifier: .gregorian).startOfDay(for: Date())

                let parameters = StatisticsQuantityQuery(
                    startDate: startDate,
                    endDate: endDate,
                    interval: interval.dateComponents,
                    anchorDate: anchorDate,
                    unit: unit,
                    statisticsOption: option,
                    isUserEntered: query["isUserEntered"] as? Bool
                )
                let result = try await core?.getQuantitySamplesStatistics(sampleType, parameters)
                let json = try JSONEncoder().encode(result)
                resolve(String(data: json, encoding: .utf8))
            } catch {
                reject("getQuantitySamplesStatistics", error.localizedDescription, error)
                return
            }
        }
    }

    /**
     Saves a quantity sample to HealthKit with specified parameters.

     - Parameters:
       - type: A string representing the sample type to save.
       - sample: A dictionary containing sample parameters, including value, unit, start and end dates, and optional metadata.
       - resolve: A callback function to resolve the promise upon successful saving.
       - reject: A callback function to reject the promise with an error message if saving fails.

     Allows you to save a quantity sample to HealthKit with the specified parameters. It resolves the promise with `true` upon successful saving. If any errors occur during the saving process, it rejects the promise with an error message.
     */
    @objc
    func saveQuantitySample(_ type: String, sample: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                guard
                    let sampleType: QuantityType = .init(rawValue: type),
                    let value = sample["value"] as? Double,
                    let unit = (sample["unit"] as? String)?.hkUnit,
                    let startDate = (sample["startDate"] as? String)?.fromIsoStringToDate(),
                    let endDate = (sample["endDate"] as? String)?.fromIsoStringToDate()
                else {
                    reject("saveQuantitySample", "Invalid parameters.", nil)
                    return
                }
                try await core?.saveQuantitySample(
                    .init(
                        type: sampleType,
                        value: value,
                        unit: unit,
                        startDate: startDate,
                        endDate: endDate,
                        metadata: sample["metadata"] as? [String: Any]
                    )
                )
                resolve(true)
            } catch {
                reject("saveQuantitySample", error.localizedDescription, error)
                return
            }
        }
    }
    
    /**
     Retrieves completed workout samples from HealthKit based on specified query parameters.

     - Parameters:
       - query: A dictionary containing query parameters, including date range, activity types, and optional parameters.
       - resolve: A callback function to resolve the promise with the retrieved data.
       - reject: A callback function to reject the promise with an error message if the retrieval fails.

     Retrieves completed workout samples from HealthKit based on the provided query parameters. It resolves the promise with a JSON string containing the completed workout samples upon successful retrieval. If any errors occur during the retrieval process, it rejects the promise with an error message.
     */
    @objc
    func getWorkouts(_ query: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                let parameters = WorkoutQueryParameters(
                    startDate: (query["startDate"] as? String)?.fromIsoStringToDate(),
                    endDate: (query["endDate"] as? String)?.fromIsoStringToDate(),
                    activityTypes: query["activityTypes"] as? [UInt],
                    ids: query["ids"] as? [String],
                    isUserEntered: query["isUserEntered"] as? Bool,
                    limit: query["limit"] as? Int ?? HKObjectQueryNoLimit
                )
                let result = try await core?.getCompletedWorkouts(queryParameters: parameters)
                let json = try JSONEncoder().encode(result)
                resolve(String(data: json, encoding: .utf8))
            } catch {
                reject("getWorkoutSamples", error.localizedDescription, error)
            }
        }
    }

    /**
     Saves a completed workout to HealthKit with specified parameters.

     - Parameters:
       - workout: A dictionary containing workout parameters, including activity type, start and end dates, total energy burned, and total distance.
       - resolve: A callback function to resolve the promise upon successful saving.
       - reject: A callback function to reject the promise with an error message if saving fails.

     Allows you to save a completed workout to HealthKit with the specified parameters. It resolves the promise with `true` upon successful saving. If any errors occur during the saving process, it rejects the promise with an error message.
     */

    @objc
    func saveWorkout(_ workout: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
        Task {
            do {
                guard
                    let activityValue = workout["activityType"] as? UInt,
                    let activityType = HKWorkoutActivityType(rawValue: activityValue),
                    let startDate = (workout["startDate"] as? String)?.fromIsoStringToDate(),
                    let endDate = (workout["endDate"] as? String)?.fromIsoStringToDate()
                else {
                    reject("saveWorkout", "Invalid parameters.", nil)
                    return
                }

                var processedMetadata: [String: Any]?
                if let metadata = workout["metadata"] as? [String: Any] {
                    processedMetadata = try WorkoutHelper.processWorkoutMetadata(metadata)
                }

                try await core?.saveCompletedWorkout(
                    activityType: activityType,
                    startDate: startDate,
                    endDate: endDate,
                    totalEnergyBurned: workout["totalEnergyBurned"] as? Double,
                    totalDistance: workout["totalDistance"] as? Double,
                    metadata: processedMetadata
                )
                resolve(true)
            } catch {
                reject("saveWorkout", error.localizedDescription, error)
            }
        }
    }

}
