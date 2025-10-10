//
//  ContentView.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Ferreira bassani on 10/09/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var habits: [Habit]
    
    var body: some View {
        ScrollView(.vertical) {
            ForEach(habits) { habit in
                HabitsComponent(habit: habit)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
