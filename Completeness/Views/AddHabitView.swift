//
//  AddHabitView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 17/09/25.
//

import SwiftUI

struct AddHabitView: View {
    @Binding var isPresented: Bool
    @Binding var newHabitName: String
    @Binding var newHabitDate: Date
    @Binding var selectedDays: [Int]
    
    var onSave: () -> Void
    
    let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
    
    private func toggleSelection(for day: Int) {
            if let index = selectedDays.firstIndex(of: day) {
                selectedDays.remove(at: index)
            } else {
                selectedDays.append(day)
                selectedDays.sort() // Keeps the array ordered, which is good practice.
            }
        }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Nome do hábito") {
                    TextField("Exemplo", text: $newHabitName)
                }
                
                Section("Data") {
                    HStack(spacing: 10) {
                               ForEach(1...7, id: \.self) { day in
                                   Text(weekDays[day - 1])
                                       .fontWeight(.bold)
                                       .frame(width: 40, height: 40)
                                       .background(
                                           Circle()
                                               .fill(selectedDays.contains(day) ? Color.accentColor : Color.gray.opacity(0.2))
                                       )
                                       .foregroundColor(selectedDays.contains(day) ? .white : .primary)
                                       .onTapGesture {
                                           toggleSelection(for: day)
                                       }
                               }
                           }
                }
            }
            .navigationTitle("Novo Hábito")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { isPresented = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        onSave()
                    }
                    .disabled(newHabitName.isEmpty)
                }
            }
        }
    }
}
