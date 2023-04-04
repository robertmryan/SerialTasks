//
//  ContentView.swift
//  SerialTasks
//
//  Created by Robert Ryan on 10/22/22.
//

import SwiftUI
import os.log

let log = OSLog(subsystem: "SerialTasks", category: .pointsOfInterest)

struct ContentView: View {
    @State var elapsed: TimeInterval = 0

    var body: some View {
        VStack {
            Text("\(elapsed, specifier: "%0.1f")")
            Button("Run tasks") {
                Task { await experiment() }
            }
        }
        .padding()
    }

    @MainActor
    func experiment() async {
        let taskManager = SerialTaskManager()

        let start = CACurrentMediaTime()
        let task = Task {
            while true {
                elapsed = CACurrentMediaTime() - start
                try await Task.sleep(for: .seconds(0.1))
            }
        }

        await taskManager.add { await updateA() }
        await taskManager.add { await updateA() }
        await taskManager.add { await updateB() }
        await taskManager.add { await updateC() }
        await taskManager.add { await updateA() }

        task.cancel()

        print("Finished experiment")
    }

    func updateA() async {
        let id = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: #function, signpostID: id)
        print("updateA started")
        try? await Task.sleep(for: .seconds(1))
        print("updateA ended")
        os_signpost(.end, log: log, name: #function, signpostID: id)
    }

    func updateB() async {
        let id = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: #function, signpostID: id)
        print("updateB started")
        try? await Task.sleep(for: .seconds(1))
        print("updateB ended")
        os_signpost(.end, log: log, name: #function, signpostID: id)
    }

    func updateC() async {
        let id = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: #function, signpostID: id)
        print("updateC started")
        try? await Task.sleep(for: .seconds(1))
        print("updateC ended")
        os_signpost(.end, log: log, name: #function, signpostID: id)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
