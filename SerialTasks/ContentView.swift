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
    var body: some View {
        VStack {
            Button("Run tasks") {
                Task { await experiment() }
            }
        }
        .padding()
    }

    func experiment() async {
        let taskManager = SerialTaskManager()
        await taskManager.add { await updateA() }
        await taskManager.add { await updateA() }
        await taskManager.add { await updateB() }
        await taskManager.add { await updateC() }
        await taskManager.add { await updateA() }
    }

    func updateA() async {
        let id = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: #function, signpostID: id)
        print("updateA started")
        try? await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
        print("updateA ended")
        os_signpost(.end, log: log, name: #function, signpostID: id)
    }

    func updateB() async {
        let id = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: #function, signpostID: id)
        print("updateB started")
        try? await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
        print("updateB ended")
        os_signpost(.end, log: log, name: #function, signpostID: id)
    }

    func updateC() async {
        let id = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: #function, signpostID: id)
        print("updateC started")
        try? await Task.sleep(nanoseconds: 1 * NSEC_PER_SEC)
        print("updateC ended")
        os_signpost(.end, log: log, name: #function, signpostID: id)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
