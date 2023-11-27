import SwiftUI
import HealthKitCore
import HealthKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                let core = try! await HealthKitCore(
                    read: [
                        WorkoutType.workout,
                    ],
                    write: [WorkoutType.workout]
                )

                //print(
                //    try! await core.getQuantitySamples(.HeartRate, .init(startDate: Calendar(identifier: .gregorian).date(byAdding: .year, value: -2, to: .now)!, endDate: Date(), unit: .count().unitDivided(by: .minute())))
                //)

                /*
                 print(
                 try! await core.getCompletedWorkouts(
                 queryParameters: .init(
                 startDate: Calendar(identifier: .gregorian).date(byAdding: .year, value: -2, to: .now)!,
                 endDate: nil,
                 activityTypes: [37],
                 ids: nil,
                 isUserEntered: nil
                 )
                 ))
                 */

    //            print(try! await core.saveCompletedWorkout(
    //                activityType: .americanFootball,
    //                startDate: Calendar(identifier: .gregorian).date(byAdding: .minute, value: -2, to: .now)!,
    //                endDate: Date(),
    //                totalEnergyBurned: 120,
    //                totalDistance: 2000,
    //                metadata: ["HKMetadataKeyIndoorWorkout": true]
    //            ))


    //            await saveWorkoutWithMetadata(core: core)

                print(try! await core.getCompletedWorkouts(queryParameters: .init()))

    //            print(try! await core.getCompletedWorkouts(queryParameters: .init()))


                //         print(
                //            try! await core.getQuantitySamplesStatistics(
                //                .ActiveEnergyBurned,
                //                StatisticsQuantityQuery(
                //                    startDate: Calendar(identifier: .gregorian).date(byAdding: .year, value: -2, to: .now)!,
                //                    endDate: .now,
                //                    interval: .init(month: 1),
                //                    anchorDate: Calendar(identifier: .gregorian).date(byAdding: .month, value: -12, to: .now)!,
                //                    unit: .kilocalorie(),
                //                    statisticsOption: .cumulativeSum,
                //                    isUserEntered: nil
                //                )
                //            )
                //         )


                /*
                 try! await core.saveQuantitySample(
                 .init(
                 type: .HeartRate,
                 value: 69,
                 unit: "count/min",
                 startDate: Calendar(identifier: .gregorian).date(byAdding: .minute, value: -1, to: .now)!,
                 endDate: Calendar(identifier: .gregorian).date(byAdding: .minute, value: -1, to: .now)!,
                 metadata: ["HKMetadataKeyHeartRateMotionContext": 1]
                 )
                 )
                 */
            }
        }
    }

    func saveWorkoutWithMetadata(core: HealthKitCore) async {
        let unit = HKUnit(from: "min")
        let quantity = HKQuantity(unit: unit, doubleValue: 30)
        print("HEY THERE: \(quantity)")
        let rawMetadata: [String: Any] = [
            "HKIndoorWorkout": true,
            "HKFitnessMachineDuration": ["unit": "min", "doubleValue": 30.0],
            "HKWaterSalinity": 0 // Assuming 0 represents freshWater
            // Add other metadata fields as needed
        ]

        let processedMetadata = try? WorkoutHelper.processWorkoutMetadata(rawMetadata)
        
        print("ProcessedMetadata: \(processedMetadata)")

        print(try! await core.saveCompletedWorkout(
            activityType: .americanFootball,
            startDate: Calendar(identifier: .gregorian).date(byAdding: .minute, value: -2, to: .now)!,
            endDate: Date(),
            totalEnergyBurned: 120,
            totalDistance: 2000,
            metadata: processedMetadata
        ))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
