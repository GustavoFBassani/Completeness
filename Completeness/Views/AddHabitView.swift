//
//  AddHabitView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 17/09/25.
//
//
import SwiftUI

struct AddHabitView: View {
    @Binding var isPresented: Bool
    @Binding var newHabitName: String
    @Binding var newHabitDate: Date
    
    @State private var selectedPredefinedHabit: PredefinedHabits? = nil
        
    var onSave: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Nome do hábito") {
                    TextField("Exemplo", text: $newHabitName)
                }
                
                Section("Data") {
                    DatePicker("Escolha o dia", selection: $newHabitDate, displayedComponents: .date)
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
