//
//  ConfigView.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
//

import SwiftUI
import SwiftData

struct DeleteAllData: View {
    @Environment(\.modelContext) var context
    @Query private var habits: [Habit]
    var body: some View {
        Button {
            habits.forEach { habit in
                context.delete(habit)
                try? context.save()
            }
        } label: {
            Text("Apagar dados")
        }
    }
}

#Preview {
    ConfigView()
}
