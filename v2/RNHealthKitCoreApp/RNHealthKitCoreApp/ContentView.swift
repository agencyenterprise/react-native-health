import SwiftUI
import HealthKitCore
import HealthKit

struct ContentView: View {
    @State private var workoutDetails: String = ""

    var body: some View {
        ScrollView {
            Text(workoutDetails)
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
//                        try await saveWorkoutWithMetadata(core: core)
                        workoutDetails = (try await core.getCompletedWorkouts(queryParameters: .init(startDate: Calendar.current.date(byAdding: .day, value: -15, to: .now)!, endDate: .now))).debugDescription
                    }
                } catch {
                    print("Error occurred: \(error)")
                }

            }
        }
    }

    private func saveWorkoutWithMetadata(core: HealthKitCore) async throws {
        let startDate = Calendar(identifier: .gregorian).date(byAdding: .minute, value: -15, to: .now)!
        let activityStartTime = Calendar(identifier: .gregorian).date(byAdding: .minute, value: -14, to: .now)!

        let conf1 = WorkoutConfiguration(
            workoutActivityType: .swimming,
            workoutLocationType: .outdoor,
            workoutSwimmingLocationType: .openWater
        )
        let conf2 = WorkoutConfiguration(
            workoutActivityType: .running,
            workoutLocationType: .outdoor,
            workoutSwimmingLocationType: .unknown
        )

        let activity1 = WorkoutActivity(
            workoutConfiguration: conf1,
            startDate: activityStartTime.toIsoString()!,
            endDate: Calendar(identifier: .gregorian).date(byAdding: .minute, value: -10, to: .now)!.toIsoString(),
            metadata: nil
        )
        let activity2 = WorkoutActivity(
            workoutConfiguration: conf2,
            startDate: Calendar(identifier: .gregorian).date(byAdding: .minute, value: -5, to: .now)!.toIsoString()!,
            endDate: Calendar(identifier: .gregorian).date(byAdding: .minute, value: -1, to: .now)!.toIsoString(),
            metadata: nil
        )

        if #available(iOS 16.0, *) {
            print(try await core.saveCompletedWorkout(
                activityType: .swimBikeRun,
                startDate: startDate, endDate: Date(),
                totalEnergyBurned: 120,
                totalDistance: 2000,
                activities: [activity1, activity2],
                metadata: [
                    "Testing": "1235"
                ]
            ))
        } else {
            print(try await core.saveCompletedWorkout(
                activityType: .running,
                startDate: startDate, endDate: Date(),
                totalEnergyBurned: 120,
                totalDistance: 2000,
                metadata: nil
            ))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private extension Date {
    func toIsoString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.string(from: self)
    }
}
