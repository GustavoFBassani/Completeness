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
            Tab("Notif Timer", systemImage: "circle.hexagongrid"){
                NavigationStack{
                    notificationTest()
                }
            }
            Tab("Notif Agendada", systemImage: "gear"){
                NavigationStack{
                    Notification2Tests()
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
