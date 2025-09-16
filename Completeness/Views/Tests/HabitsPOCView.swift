//
//  HabitsPOCView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//
import SwiftUI
import SwiftData

struct HabitsPOCView: View {
    @Environment(\.modelContext) var context
    @Query private var habits: [Habit]
    var habitCompletionPersistence: HabitCompletionRepository
    var habitRepository: HabitRepository
    @State private var textField = ""
    @State private var completenessType: CompletionHabit = .byToggle
    
    var body: some View {
        VStack(alignment: .center, spacing: 16){ // esse aqui alinha oque está dentro da vstack
            TextField("New Habit Name ", text: $textField)
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 16).fill(.gray))
            
            Picker("Completion Type", selection: $completenessType) {
                Text("Toggle simples").tag(CompletionHabit.byToggle)
                Text("Toggle multiplo").tag(CompletionHabit.byMultipleToggle)
                Text("By Timer").tag(CompletionHabit.byTimer)
            }
            .background(RoundedRectangle(cornerRadius: 16).fill(.brown))
            
            Button {
                let newHabit = Habit(
                    habitName: textField,
                    habitCompleteness: completenessType
                )
                
                habitRepository.createHabit(habit: newHabit)
                habits.forEach { habit in
                    print(habit.habitName)
                }
            } label: {
                Text("Save New Habit")
            }
            
            ForEach(habits) { habit in
                Text(habit.habitName)
            }
        }
        .frame(alignment: .leading)
        .padding(.horizontal, 16)
    }
}
