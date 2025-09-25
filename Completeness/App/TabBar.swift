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
    @State private var refreshView = false

    var body: some View {
        TabView{
            Tab("Hábitos", systemImage: "circle.hexagongrid"){
                NavigationStack{
                    HabitView(viewModel: HabitsViewModel(habitCompletionService: HabitCompletionRepository(context: context),
                                                         habitService: HabitRepository(context: context)), refreshView: $refreshView)
                }
            }

            Tab("Resumo", systemImage: "checkmark.arrow.trianglehead.counterclockwise"){
                NavigationStack{
                    DeleteAllData()
                }
            }
            Tab("Configurações", systemImage: "gearshape"){
                NavigationStack{
                    ConfigView()
                }
            }
            Tab("Notif", systemImage: "circle"){
                NavigationStack{
                    Notification2Tests()
                }
            }
        }
        .onAppear(perform: {
            refreshView.toggle()
        })
        .tint(.indigoCustom)
    }
}

#Preview {
    TabBar()
}
