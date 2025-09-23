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
            Tab("Habit", systemImage: "circle.hexagongrid"){
                NavigationStack{
                    HabitView(viewModel: HabitsViewModel(habitCompletionService: HabitCompletionRepository(context: context), habitService: HabitRepository(context: context)))
                }
            }
            Tab("Stats", systemImage: "checkmark.arrow.trianglehead.counterclockwise"){
                NavigationStack{
                    StatsView()
                }
            }
            Tab("Settings", systemImage: "gearshape"){
                NavigationStack{
                    ConfigView()
                }
            }
            // MARK: - Tabfake
//            Tab("Notif Timer", systemImage: "circle"){
//                NavigationStack{
//                    notificationTest()
//                }
//            }
//            Tab("Notif Agendada", systemImage: "circle"){
//                NavigationStack{
//                    Notification2Tests()
//                }
//            }
//            Tab("viewModelTests", systemImage: "circle.fill") {
//                NavigationStack {
//                    HabitsPOCView(viewModel: .init(habitCompletionService: HabitCompletionRepository(context: context),
//                                                             habitService: HabitRepository(context: context))
//                    )
//                }
//            }
        }
        .tint(.indigoCustom)
    }
}

#Preview {
    TabBar()
}
