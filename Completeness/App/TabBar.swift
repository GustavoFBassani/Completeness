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
//                    HabitView() // comentei para nao dar conflito tmjjj
                    HabitTest(context: context)
                }
            }
            Tab("Stats", systemImage: "circle.hexagongrid"){
                NavigationStack{
                    StatsView()
                }
            }
            Tab("Settings", systemImage: "gear"){
                NavigationStack{
                    ConfigView()
                }
            }
            
            Tab("viewModelTests", systemImage: "circle.fill") {
                NavigationStack {
                    HabitsPOCView(viewModel: .init(habitCompletionService: HabitCompletionRepository(context: context),
                                                             habitService: HabitRepository(context: context))
                    )
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
