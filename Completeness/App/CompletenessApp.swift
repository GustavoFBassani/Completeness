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
    @AppStorage("selectedTheme") private var selectedTheme = "system"
    var body: some Scene {
        WindowGroup {
            TabBar()
                .preferredColorScheme(getColorScheme())
        }
        .modelContainer(for: Habit.self)
    }
    private func getColorScheme() -> ColorScheme? {
        switch selectedTheme {
            case "light":
                return .light
            case "dark":
                return .dark
            default:
                return nil
        }
    }
}
