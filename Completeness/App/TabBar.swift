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
                                                         habitService: HabitRepository(context: context),
                                                         notificationService: NotificationHelper(),
                                                         chartsService: ChartsService(modelContext: context),
                                                        ),
                              refreshView: $refreshView,
                              configsVMFactory: HabitsConfigVMFactory(repositoryFactory: HabitRepositoryFactory(context: context)))
                }
            }
            
//            Tab("Resumo", systemImage: "checkmark.arrow.trianglehead.counterclockwise"){
//                NavigationStack{
//                    StatsView(viewModel: ChartsViewModel(chartsService: ChartsService(modelContext: context)))
//                }
//            }
            
            Tab("Configurações", systemImage: "gearshape"){
                NavigationStack{
                    ConfigView()
                }
            }
            Tab("Notifications", systemImage: "bell.badge"){
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
