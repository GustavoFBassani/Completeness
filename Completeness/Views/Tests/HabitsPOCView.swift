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
    @State private var howManyTimesToCompleteHabit = 1
    var body: some View {
        VStack(alignment: .center, spacing: 16){
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
            if completenessType == .byMultipleToggle {
                HStack {
                    Text("choose how many times you want to do it for a day")
                    Picker("How many times", selection: $howManyTimesToCompleteHabit) {
                        ForEach(1..<10, id: \.self) { count in
                            Text("\(count)").tag(count)
                        }
                    }
                }
            }

            Button {
                let newHabit = Habit(
                    habitName: textField,
                    habitCompleteness: completenessType,
                    howManyTimesToToggle: howManyTimesToCompleteHabit
                )
                howManyTimesToCompleteHabit = 1
                habitRepository.createHabit(habit: newHabit)
            } label: {
                Text("Save New Habit")
            }
            ForEach(habits) { habit in
                HStack {
                    Text(habit.habitName)
                    Spacer()
                    if habit.howManyTimesToToggle <= habit.howManyTimesItWasDone + 1 {
                        Button {
                            habit.habitIsCompleted.toggle()
                            try? context.save()
                        } label: {
                            Circle().fill(habit.habitIsCompleted ? .green : .red)
                                .frame(width: 20, height: 20, alignment: .trailing)
                        }
                    } else {
                        Button {
                            habit.howManyTimesItWasDone += 1
                            try? context.save()
                        } label: {
                            Text("\(habit.howManyTimesItWasDone) / \(habit.howManyTimesToToggle)")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .frame(alignment: .leading)
        .padding(.horizontal, 16)
    }
}
