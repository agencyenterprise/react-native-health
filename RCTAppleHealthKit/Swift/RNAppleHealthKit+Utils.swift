//
//  RNAppleHealthKit.swift
//  RNAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

import Foundation

@objc public extension RNAppleHealthKit {
    func parseISO8601Date(from date: String) -> Date? {
        let dateFormatter = createPosixDateFormatter()
        return dateFormatter.date(from: date)
    }
    
    func buildISO8601String(from date: Date) -> String {
        let dateFormatter = createPosixDateFormatter()
        return dateFormatter.string(from: date)
    }
    
    func createPosixDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZ"
        return dateFormatter
    }
    
    func predicateForSamplesOnDay(_ date: Date) -> NSPredicate {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
        return HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    }

    func predicateForSamplesBetween(startDate: NSDate, endDate: NSDate) -> NSPredicate {
        return HKQuery.predicateForSamples(withStart: startDate as Date, end: endDate as Date, options: .strictStartDate)
    }

    func predicateForAnchoredQueries(startDate: NSDate?, endDate: NSDate) -> NSPredicate? {
        guard let startDate = startDate else {
            return nil
        }
        return HKQuery.predicateForSamples(withStart: startDate as Date, end: endDate as Date, options: .strictStartDate)
    }

    func date(from options: NSDictionary, key: NSString = "date", defaultDate: NSDate? = nil) -> NSDate? {
        guard let dateString = options[key] as? String else {
            return defaultDate
        }
        return self.parseISO8601Date(from: dateString) as NSDate?
    }
}
