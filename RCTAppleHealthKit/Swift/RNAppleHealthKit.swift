//
//  RNAppleHealthKit.swift
//  RNAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

import Foundation

@objcMembers public class RNAppleHealthKit: NSObject {
    public let healthStore: HKHealthStore
    
    public override init() {
        healthStore = HKHealthStore()
    }

    public static func isHealthKitAvailable(_ callback: RCTResponseSenderBlock) {
        let isAvailable = HKHealthStore.isHealthDataAvailable()
        callback([0, isAvailable])
    }
}
