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
<<<<<<< HEAD
                    HabitView(context: context)
=======
//                    HabitView() // comentei para nao dar conflito tmjjj
                    HabitTest(context: context)
>>>>>>> 356d32b2015bfd0f8da8b78d18f5df1bfe1cf17f
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
