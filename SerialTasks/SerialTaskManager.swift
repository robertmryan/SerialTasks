//
//  SerialTaskManager.swift
//  SerialTasks
//
//  Created by Robert Ryan on 10/22/22.
//

import Foundation

actor SerialTaskManager {
    private var previousTask: Task<(), Error>?

    func add(block: @Sendable @escaping () async throws -> Void) async {
        previousTask = Task { [previousTask] in
            let _ = await previousTask?.result

            return try await block()
        }

        try? await previousTask?.value
    }
}
