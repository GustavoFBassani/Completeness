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
    let repositoryFactory: HabitRepositoryFactory
    let rowPosition: Int
    let colunmPosition: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                NavigationLink {
                    HabitsConfigView(viewModel: HabitConfigViewModel(habitService: repositoryFactory.makeHabitRepository()))
                } label: {
                    Text("Hábito personalizado")
                        .foregroundColor(.labelPrimary)
                        .frame(width: 362, height: 52)
                        .background(.indigoCustom)
                        .cornerRadius(26)
                        .font(.system(size: 17, weight: .semibold))
                }
                .padding(.vertical)
                
                VStack(spacing: 20) {
                    // Seções dinâmicas

                    HabitSectionView(title: "Hábitos simples",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter {
                        $0.completionType == .byToggle })
                    HabitSectionView(
                        title: "Hábitos múltiplos",
                        rowPosition: rowPosition ,
                        colunmPosition: colunmPosition,
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byMultipleToggle })
                    HabitSectionView(
                        title: "Hábitos por tempo",
                        rowPosition: rowPosition,
                        colunmPosition: colunmPosition,
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byTimer })
                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.backgroundSecondary)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.semibold))
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Novo Hábito")
                        .foregroundStyle(.labelPrimary)
                }
            }
        }
    }
}
