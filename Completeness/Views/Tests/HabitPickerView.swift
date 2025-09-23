//
//  Test.swift
//  Completeness
//
//  Created by Gustavo Melleu on 22/09/25.
//
import SwiftUI

struct HabitPickerView: View {
    @State private var selectedHabit: PredefinedHabits? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            // Picker para escolher o hábito
            Picker("Selecione um hábito", selection: $selectedHabit) {
                ForEach(PredefinedHabits.allCases) { habit in
                    Text(habit.habitName)
                        .tag(Optional(habit)) // precisa ser Optional pq selectedHabit é opcional
                }
            }
            .pickerStyle(.wheel) // pode trocar para .menu ou .segmented
            
            // Exibir detalhes quando selecionado
            if let habit = selectedHabit {
                VStack(spacing: 10) {
                    Image(systemName: habit.habitSimbol)
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    
                    Text(habit.habitName)
                        .font(.title2)
                        .bold()
                    
//                    Text(habit.habitDescription)
//                        .font(.body)
//                        .foregroundColor(.secondary)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal)
                }
                .padding()
                .transition(.opacity.combined(with: .slide))
            }
        }
        .padding()
    }
}

#Preview {
    HabitPickerView()
}
