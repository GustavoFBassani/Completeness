//
//  TabBar.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    @Environment(\.modelContext) var context
    
    var body: some View {
        TabView{
            Tab("Habit", systemImage: "house"){
                NavigationStack{
                    HabitView()
                }
            }
            Tab("Stats", systemImage: "circle.hexagongrid"){
                NavigationStack{
                    StatsView()
                }
            }
            Tab("Settings", systemImage: "gear"){
                NavigationStack{
                    HabitsPOCView(habitCompletionPersistence: HabitCompletionRepository(context: context),
                                  habitRepository: HabitRepository(context: context))
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
