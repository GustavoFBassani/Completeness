//
//  CompletenessApp.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 09/09/25.
//

import SwiftUI
import SwiftData

@main
struct CompletenessApp: App {
    @Environment(\.modelContext) var context
    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(for: Habit.self)
    }
}
