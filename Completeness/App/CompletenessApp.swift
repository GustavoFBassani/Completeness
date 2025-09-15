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
    let modelContainer: ModelContainer

    init() {
        let configuration = ModelConfiguration(cloudKitDatabase: .automatic)

        do {
            self.modelContainer = try ModelContainer(
                for: Habit.self,
                configurations: configuration
            )
        } catch {
            fatalError("Não foi possível criar o ModelContainer: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(modelContainer)
    }
}
