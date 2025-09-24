//
//  AddNewHabit.swift
//  Completeness
//
//  Created by Gustavo Melleu on 23/09/25.
//
//
import SwiftUI

struct AddNewHabit: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Button {
                    //
                } label: {
                    Text("Hábito personalizado")
                        .foregroundColor(.white)
                        .frame(width: 362, height: 52)
                        .background(.indigoCustom)
                        .cornerRadius(26)
                        .font(.system(size: 17, weight: .semibold))
                }
                .padding(.vertical)
                VStack(spacing: 20) {
                    // Seções dinâmicas
                    HabitSectionView(
                        title: "Hábitos simples",
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byToggle }
                    )
                    HabitSectionView(
                        title: "Hábitos múltiplos",
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byMultipleToggle }
                    )
                    HabitSectionView(
                        title: "Hábitos por tempo",
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byTimer }
                    )
                    Spacer()
                }
            }
            .navigationTitle("Novo Hábito")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGray6))
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.semibold))
                    }
                }
            }
        }
    }
}
