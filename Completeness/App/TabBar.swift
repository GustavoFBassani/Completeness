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
            Tab("Hábitos", systemImage: "circle.hexagongrid"){
                NavigationStack{
                    HabitView(viewModel: HabitsViewModel(habitCompletionService: HabitCompletionRepository(context: context), habitService: HabitRepository(context: context)))
                }
            }
            Tab("Relatórios", systemImage: "checkmark.arrow.trianglehead.counterclockwise"){
                NavigationStack{
                    DeleteAllData()
                }
            }
            Tab("Configurações", systemImage: "gearshape"){
                NavigationStack{
                    ConfigView()
                }
            }
        }
        .tint(.indigoCustom)
    }
}

#Preview {
    TabBar()
}
