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
                    HabitsConfigView(viewModel: configsVMFactory.createPersonalizedHabits(rowPosition: rowPosition, colunmPosition: colunmPosition), howManyTimesToToggle: 1)
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
                    HabitSectionView(title: "Saúde",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .health },
                                     configsVMFactory: configsVMFactory)

                    HabitSectionView(title: "Trabalho",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .work },
                                     configsVMFactory: configsVMFactory)

                    HabitSectionView(title: "Hobbies",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .hobby },
                                     configsVMFactory: configsVMFactory)

                    HabitSectionView(title: "Esportes",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .sports },
                                     configsVMFactory: configsVMFactory)

                    HabitSectionView(title: "Estudos",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .studies },
                                     configsVMFactory: configsVMFactory)

                    HabitSectionView(title: "Casa",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .home },
                                     configsVMFactory: configsVMFactory)

                    HabitSectionView(title: "Fé",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .feith },
                                     configsVMFactory: configsVMFactory)

                    HabitSectionView(title: "Outros",
                                     rowPosition: rowPosition,
                                     colunmPosition: colunmPosition,
                                     habits: PredefinedHabits.allCases.filter { $0.categories == .other },
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
