//
//  RNAppleHealthKit+Types.swift
//  RNAppleHealthKit
//
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

import Foundation

public extension RNAppleHealthKit {
    @objc func hkUnit(from options: NSDictionary, with key: NSString = "unit", defaultValue: HKUnit? = nil) -> HKUnit? {
        guard let unitString = options[key] as? String else {
            return defaultValue
        }

        switch unitString {
        case "gram":
            return HKUnit.gram()
        case "kg":
            return HKUnit.gramUnit(with: HKMetricPrefix.kilo)
        case "stone":
            return HKUnit.stone()
        case "pound":
            return HKUnit.pound()
        case "meter":
            return HKUnit.meter()
        case "cm":
            return HKUnit.meterUnit(with: HKMetricPrefix.centi)
        case "inch":
            return HKUnit.inch()
        case "foot":
            return HKUnit.foot()
        case "second":
            return HKUnit.second()
        case "minute":
            return HKUnit.minute()
        case "hour":
            return HKUnit.hour()
        case "day":
            return HKUnit.day()
        case "joule":
            return HKUnit.joule()
        case "calorie":
            return HKUnit.calorie()
        case "count":
            return HKUnit.count()
        case "percent":
            return HKUnit.percent()
        case "bpm":
            let count = HKUnit.count()
            let minute = HKUnit.minute()
            return count.unitDivided(by: minute)
        case "fahrenheit":
            return HKUnit.degreeFahrenheit()
        case "celsius":
            return HKUnit.degreeCelsius()
        case "mmhg":
            return HKUnit.millimeterOfMercury()
        case "mmolPerL":
            let mole = HKUnit.moleUnit(with: HKMetricPrefix.milli, molarMass: HKUnitMolarMassBloodGlucose)
            let liter = HKUnit.liter()
            return mole.unitDivided(by: liter)
        case "mgPerdL":
            return HKUnit.init(from: "mg/dL")
        case "mlPerKgMin":
            let ml = HKUnit.literUnit(with: HKMetricPrefix.milli)
            let kg = HKUnit.gramUnit(with: HKMetricPrefix.kilo)
            let min = HKUnit.minute()
            return ml.unitDivided(by: (kg.unitMultiplied(by: min)))
        default:
            return defaultValue
        }
    }
    @objc func quantityType(from name: NSString) -> HKSampleType? {
        switch(name) {
        case "ActiveEnergyBurned":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.activeEnergyBurned)
        case "BasalEnergyBurned":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.basalEnergyBurned)
        case "Cycling":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceCycling)
        case "HeartRate":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)
        case "HeartRateVariabilitySDNN":
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRateVariabilitySDNN)
            } else {
                return nil
            }
        case "RestingHeartRate":
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.restingHeartRate)
            } else {
                return nil
            }
        case "Running":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)
        case "StairClimbing":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.flightsClimbed)
        case "StepCount":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        case "Swimming":
            if #available(iOS 10.0, *) {
                return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceSwimming)
            } else {
                return nil
            }
        case "Vo2Max":
            if #available(iOS 11.0, *) {
                return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.vo2Max)
            } else {
                return nil
            }
        case "Walking":
            return HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        case "Workout":
            return HKObjectType.workoutType()
        default:
            return HKObjectType.workoutType()
        }
    }

    private func getHKWorkoutDictionary() -> [String: HKWorkoutActivityType] {
        var dictionary: [String: HKWorkoutActivityType] = [
            "AmericanFootball": .americanFootball,
            "Archery": .archery,
            "AustralianFootball": .australianFootball,
            "Badminton": .badminton,
            "Baseball": .baseball,
            "Basketball": .basketball,
            "Bowling": .bowling,
            "Boxing": .boxing,
            "Climbing": .climbing,
            "Cricket": .cricket,
            "CrossTraining": .crossTraining,
            "Curling": .curling,
            "Cycling": .cycling,
            "Dance": .dance,
            "DanceInspiredTraining": .danceInspiredTraining,
            "Elliptical": .elliptical,
            "EquestrianSports": .equestrianSports,
            "Fencing": .fencing,
            "Fishing": .fishing,
            "FunctionalStrengthTraining": .functionalStrengthTraining,
            "Golf": .golf,
            "Gymnastics": .gymnastics,
            "Handball": .handball,
            "Hiking": .hiking,
            "Hockey": .hockey,
            "Hunting": .hunting,
            "Lacrosse": .lacrosse,
            "MartialArts": .martialArts,
            "MindAndBody": .mindAndBody,
            "MixedMetabolicCardioTraining": .mixedMetabolicCardioTraining,
            "PaddleSports": .paddleSports,
            "Play": .play,
            "PreparationAndRecovery": .preparationAndRecovery,
            "Racquetball": .racquetball,
            "Rowing": .rowing,
            "Rugby": .rugby,
            "Running": .running,
            "Sailing": .sailing,
            "SkatingSports": .skatingSports,
            "SnowSports": .snowSports,
            "Soccer": .soccer,
            "Softball": .softball,
            "Squash": .squash,
            "StairClimbing": .stairClimbing,
            "SurfingSports": .surfingSports,
            "Swimming": .swimming,
            "TableTennis": .tableTennis,
            "Tennis": .tennis,
            "TrackAndField": .trackAndField,
            "TraditionalStrengthTraining": .traditionalStrengthTraining,
            "Volleyball": .volleyball,
            "Walking": .walking,
            "WaterFitness": .waterFitness,
            "WaterPolo": .waterPolo,
            "WaterSports": .waterSports,
            "Wrestling": .wrestling,
            "Yoga": .yoga,
            "Other": .other
        ]
        
        if #available(iOS 10.0, *) {
            dictionary["Barre"] = .barre
            dictionary["CoreTraining"] = .coreTraining
            dictionary["CrossCountrySkiing"] = .crossCountrySkiing
            dictionary["DownhillSkiing"] = .downhillSkiing
            dictionary["Flexibility"] = .flexibility
            dictionary["HighIntensityIntervalTraining"] = .highIntensityIntervalTraining
            dictionary["JumpRope"] = .jumpRope
            dictionary["Kickboxing"] = .kickboxing
            dictionary["Pilates"] = .pilates
            dictionary["Snowboarding"] = .snowboarding
            dictionary["Stairs"] = .stairs
            dictionary["StepTraining"] = .stepTraining
            dictionary["WheelchairWalkPace"] = .wheelchairWalkPace
            dictionary["WheelchairRunPace"] = .wheelchairRunPace
        }
        
        if #available(iOS 11.0, *) {
            dictionary["TaiChi"] = .taiChi
            dictionary["MixedCardio"] = .mixedCardio
            dictionary["HandCycling"] = .handCycling
        }
        
        if #available(iOS 13.0, *) {
            dictionary["DiscSports"] = .discSports
            dictionary["FitnessGaming"] = .fitnessGaming
        }
        if #available(iOS 14.0, *) {
            dictionary["CardioDance"] = .cardioDance
            dictionary["SocialDance"] = .socialDance
            dictionary["Pickleball"] = .pickleball
            dictionary["Cooldown"] = .cooldown
        }
        
        return dictionary
    }
}
