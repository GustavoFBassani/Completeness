//
//  SwiftUIView.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 17/09/25.
//

import SwiftUI

struct SheetToEditHabitsTest: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var habit: Habit
    var editHabit: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            Text("editar nome do hábito")
            TextField("so de teste", text: $habit.habitName)
            
            Picker("Completion Type", selection: $habit.habitCompleteness) {
                Text("Toggle simples").tag(CompletionHabit.byToggle)
                Text("Toggle multiplo").tag(CompletionHabit.byMultipleToggle)
                Text("By Timer").tag(CompletionHabit.byTimer)
            }
            
            if habit.habitCompleteness == .byMultipleToggle {
                HStack {
                    Text("choose how many times you want to do it for a day")
                    
                    Picker("How many times", selection: $habit.howManyTimesToToggle) {
                        ForEach(1..<10, id: \.self) { count in
                            Text("\(count)").tag(count)
                        }
                    }
                }
            }

            Button {
                editHabit()
                dismiss()
            } label: {
                Text("Save Changes")
            }
        }
        .padding()
    }
}

#Preview {
//    SheetToEditHabitsTest()
}
