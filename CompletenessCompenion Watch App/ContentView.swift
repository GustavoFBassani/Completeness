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
        VStack {
        }
        .onAppear(perform: {
            habits.forEach({ habit in
                print(habit.habitName)})
        })
        .padding()
    }
}

#Preview {
    ContentView()
}
