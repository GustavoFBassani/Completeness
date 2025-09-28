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
    let configsVMFactory: HabitsConfigVMFactory
    let rowPosition: Int
    let colunmPosition: Int
    
    var body: some View {
        NavigationStack {
            ScrollView {
                NavigationLink {
                    HabitsConfigView(viewModel: configsVMFactory.createPersonalizedHabits(rowPosition: rowPosition, colunmPosition: colunmPosition))
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
                                     habits: PredefinedHabits.allCases.filter { $0.completionType == .byToggle },
                                     configsVMFactory: configsVMFactory)
                    HabitSectionView(
                        title: "Hábitos múltiplos",
                        rowPosition: rowPosition,
                        colunmPosition: colunmPosition,
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byMultipleToggle },
                        configsVMFactory: configsVMFactory)
                    HabitSectionView(
                        title: "Hábitos por tempo",
                        rowPosition: rowPosition,
                        colunmPosition: colunmPosition,
                        habits: PredefinedHabits.allCases.filter { $0.completionType == .byTimer },
                        configsVMFactory: configsVMFactory)
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
