//
//  RNAppleHealthKit+Utils.swift
//  RNAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

import Foundation

public extension RNAppleHealthKit {
    func parseISO8601Date(from date: String) -> Date? {
        let dateFormatter = createPosixDateFormatter()
        return dateFormatter.date(from: date)
    }
    
    @objc func buildISO8601String(from date: Date) -> String {
        let dateFormatter = createPosixDateFormatter()
        return dateFormatter.string(from: date)
    }
    
    func createPosixDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return dateFormatter
    }
    
    @objc func predicateForSamplesOnDay(_ date: Date) -> NSPredicate {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        return HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    }

    @objc func predicateForSamplesBetween(startDate: NSDate, endDate: NSDate) -> NSPredicate {
        return HKQuery.predicateForSamples(withStart: startDate as Date, end: endDate as Date, options: .strictStartDate)
    }

    @objc func predicateForAnchoredQueries(startDate: NSDate?, endDate: NSDate) -> NSPredicate? {
        guard let startDate = startDate else {
            return nil
        }
        return HKQuery.predicateForSamples(withStart: startDate as Date, end: endDate as Date, options: .strictStartDate)
    }

    @objc func date(from options: NSDictionary, key: NSString = "date", defaultDate: NSDate? = nil) -> NSDate? {
        guard let dateString = options[key] as? String else {
            return defaultDate
        }
        return self.parseISO8601Date(from: dateString) as NSDate?
    }
    
    @objc func hkAnchor(from options: NSDictionary) -> HKQueryAnchor? {
        guard let anchorString = options["anchor"] as? String, anchorString.count > 0 else {
            return nil
        }
        guard let anchorData = Data(base64Encoded: anchorString) else {
            return nil
        }
        let anchor = NSKeyedUnarchiver.unarchiveObject(with: anchorData) as? HKQueryAnchor
        return anchor
    }
    
    @objc func hkQuantity(from options: NSDictionary, valueKey: NSString, unitKey: NSString) -> HKQuantity? {
        guard let unit = self.hkUnit(from: options, with: unitKey),
              let value: Double = (options[valueKey] as? NSNumber)?.doubleValue
        else {
            return nil
        }
        return HKQuantity(unit: unit, doubleValue: value)
    }
    
    @objc func stringForHKWorkoutActivityType(_ type: HKWorkoutActivityType) -> NSString {
        let workoutTypes = self.getHKWorkoutDictionary()
        let typeName = workoutTypes[firstKeyFor: type] ?? "Other"
        
        return typeName as NSString
    }
    
    @objc func hkWorkoutActivityType(from options: NSDictionary, key: NSString, defaultValue: HKWorkoutActivityType) -> HKWorkoutActivityType {
        let workoutTypes = self.getHKWorkoutDictionary()

        guard let option = options[key] as? String else {
            return defaultValue
        }
        return workoutTypes[option] ?? defaultValue
    }
}

extension Dictionary where Value: Equatable {
    subscript(firstKeyFor value: Value) -> Key?  { first { $0.value == value }?.key }
}

