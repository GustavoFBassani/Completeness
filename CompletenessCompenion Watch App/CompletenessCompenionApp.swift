//
//  CompletenessCompenionApp.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Ferreira bassani on 10/09/25.
//

import SwiftUI
import SwiftData

@main
struct CompletenessCompenion_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Habit.self, HabitLog.self])
    }
}
