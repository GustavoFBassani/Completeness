//
//  AddNewHabit.swift
//  Completeness
//
//  Created by Gustavo Melleu on 23/09/25.
//
//
import SwiftUI

struct AddHabitsView: View {
    @Environment(\.dismiss) var dismiss
    
    @Bindable var viewModel: HabitsViewModel
    @State private var showPersonalizedHabits = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                NavigationLink {
                    HabitsConfig(viewModel: viewModel)
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
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byToggle }, viewModel: viewModel
                    )
                    HabitSectionView(
                        title: "Hábitos múltiplos",
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byMultipleToggle }, viewModel: viewModel
                    )
                    HabitSectionView(
                        title: "Hábitos por tempo",
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byTimer }, viewModel: viewModel
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
