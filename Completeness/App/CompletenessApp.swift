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
    @AppStorage("selectedLanguage") private var selectedLanguage = "pt"
    @Environment(\.modelContext) var context
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    @State private var appViewModel = AppViewModel()


    var body: some Scene {
        WindowGroup {
            CompletenessAppContentView()
                .environment(appViewModel)
                .environment(\.locale, Locale(identifier: selectedLanguage))
        }
        .modelContainer(for: [Habit.self, HabitLog.self])
    }
}

struct CompletenessAppContentView: View {
    @Environment(AppViewModel.self) private var appViewModel
    @AppStorage("selectedTheme") private var selectedTheme = "system"
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false

    var body: some View {
        if !hasSeenOnboarding {
            NavigationStack {
                Onboarding1()
            }
        } else if appViewModel.isAuthenticated {
            TabBar()
                .preferredColorScheme(getColorScheme())
        } else {
            VStack {
                Text("FaceID")
                ProgressView()
            }
            .task {
                await appViewModel.autenticateIfNeeded()
            }
        }
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
