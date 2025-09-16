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

    @State private var appViewModel = AppViewModel()


    var body: some Scene {
        WindowGroup {
            CompletenessAppContentView().environment(appViewModel)
        }
        .modelContainer(for: Habit.self)
    }
}

struct CompletenessAppContentView: View {
    @Environment(AppViewModel.self) private var appViewModel

    var body: some View {
        if appViewModel.isAuthenticated {
            TabBar()
        } else  {
            VStack {
                Text("FaceID")
                ProgressView()
            }
            .task {
                await appViewModel.autenticateIfNeeded()
            }
        }
    }
}
