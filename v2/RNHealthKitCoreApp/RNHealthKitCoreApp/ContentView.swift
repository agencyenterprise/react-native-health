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
                do {
                    let core = try await HealthKitCore(
                        read: [WorkoutType.workout],
                        write: [WorkoutType.workout]
                    )
                    if HKHealthStore.isHealthDataAvailable() {
//                        await saveWorkoutWithMetadata(core: core)
                        dump(try await core.getCompletedWorkouts(queryParameters: .init()))
                    }
                } catch {
                    print("Error occurred: \(error)")
                }

            }
        }
    }

    func saveWorkoutWithMetadata(core: HealthKitCore) async {
        let unit = HKUnit(from: "min")
        let rawMetadata: [String: Any] = [
            "HKIndoorWorkout": true,
            "HKFitnessMachineDuration": ["unit": "min", "doubleValue": 30.0],
        ]

        let processedMetadata = try! WorkoutHelper.processWorkoutMetadata(rawMetadata)

        dump(try! await core.saveCompletedWorkout(
            activityType: .coreTraining,
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
