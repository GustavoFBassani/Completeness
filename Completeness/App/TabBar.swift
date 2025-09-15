//
//  TabBar.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI

struct TabBar: View {
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
                    ConfigView()
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
