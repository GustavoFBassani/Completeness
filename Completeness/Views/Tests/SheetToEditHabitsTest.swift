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
            Text("Editar nome do hábito")
            TextField("so de teste", text: $habit.habitName)
            
            Picker("Tipo de Completude", selection: $habit.habitCompleteness) {
                Text("Troca simples").tag(CompletionHabit.byToggle)
                Text("Troca multipla").tag(CompletionHabit.byMultipleToggle)
                Text("Por tempo").tag(CompletionHabit.byTimer)
            }
            
            if habit.habitCompleteness == .byMultipleToggle {
                HStack {
                    Text("Escolha quantas vezes você quer fazer isso no dia")
                    
                    Picker("Quantas vezes", selection: $habit.howManyTimesToToggle) {
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
                Text("Salvar alterações")
            }
        }
        .padding()
    }
}

#Preview {
//    SheetToEditHabitsTest()
}
