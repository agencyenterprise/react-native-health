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
        .task {
            let core = try! await HealthKitCore(
                read: [
                    QuantityType.ActiveEnergyBurned,
                    QuantityType.HeartRate,
                    QuantityType.HeadphoneAudioExposure
                ],
                write: [QuantityType.HeartRate])
            
            /*
            print(
                try! await core.getQuantitySamplesAggregation(
                    .ActiveEnergyBurned,
                    AggregationQuantityQuery(
                        startDate: Calendar(identifier: .gregorian).date(byAdding: .day, value: -1, to: .now)!,
                        endDate: .now,
                        interval: .init(hour: 1),
                        unit: .kilocalorie(),
                        aggregationOption: .cumulativeSum
                    )
                )
            )
            */
            
            /*
            print(
                try! await core.getQuantitySamplesAggregation(
                    .HeadphoneAudioExposure,
                    AggregationQuantityQuery(
                        startDate: Calendar(identifier: .gregorian).date(byAdding: .month, value: -6, to: .now)!,
                        endDate: .now,
                        interval: .init(month: 6),
                        unit: .second(),
                        aggregationOption: .duration,
                        isUserEntered: nil
                    )
                )
            )
             */
             
            
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
            
            let samples = try! await core.getQuantitySamples(
                .HeadphoneAudioExposure, .init(
                    startDate: Calendar(identifier: .gregorian).date(byAdding: .year, value: -1, to: .now)!,
                    endDate: .now, isUserEntered: nil, unit: .decibelAWeightedSoundPressureLevel())
                )
            var total: Double = 0
            for sample in samples {
                total += Double(sample.endDate.timeIntervalSince(sample.startDate))
            }
            print("Total: \(total)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
