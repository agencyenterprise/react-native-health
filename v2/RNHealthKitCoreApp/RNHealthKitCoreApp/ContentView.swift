import SwiftUI
import RNHealthKitCore

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
            let core = try! await RNHealthKitCore(read: [CumulativeQuantityType.ActiveEnergyBurned], write: [])
            
            
            print(
                try! await core.getCumulativeQuantitySamples(
                    .ActiveEnergyBurned,
                    CumulativeQuantityQuery(
                        startDate: Calendar(identifier: .gregorian).date(byAdding: .month, value: -1, to: .now)!,
                        endDate: .now,
                        interval: .init(day: 1),
                        unit: .kilocalorie()
                    )
                )
            )
            
            //print(try! await core.getQuantitySamples(CumulativeQuantityType.ActiveEnergyBurned, .init(startDate: Calendar(identifier: .gregorian).date(byAdding: .day, value: -1, to: .now)!, endDate: nil, unit: .kilocalorie())))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
