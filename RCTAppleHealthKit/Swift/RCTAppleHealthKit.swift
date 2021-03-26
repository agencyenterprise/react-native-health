//
//  RCTAppleHealthKit.swift
//  RCTAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

import Foundation

@objc public class RNAppleHealthKit: NSObject {
    @objc static public func isHealthKitAvailable(_ callback: RCTResponseSenderBlock) {
        let isAvailable = HKHealthStore.isHealthDataAvailable()
        callback([0, isAvailable])
    }
}
