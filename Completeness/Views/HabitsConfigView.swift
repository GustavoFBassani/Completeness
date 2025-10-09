//
//  AddCustomHabit.swift
//  Completeness
//
//  Created by Vítor Bruno on 23/09/25.
//

enum TimeOption: Int {
    case oneMinute = 60
    case threeMinutes = 180
    case fiveMinutes = 300
    case tenMinutes = 600
    case fifteenMinutes = 900
    case twentyMinutes = 1_200
    case thirtyMinutes = 1_800
    case fortyFiveMinutes = 2_700
    case oneHour = 3_600
}

enum DaysRepeation: String {
    case allDays = "Todos os dias"
    case personalized = "Personalizado"
}

import SwiftUI

struct HabitsConfigView: View {
    var id: UUID?
    @State var viewModel: HabitConfigViewModel
    
    //view variables
    var title = "Hábito Personalizado"
    let weekDays = ["D", "S", "T", "Q", "Q", "S", "S"]
    
    var habitCompletenessDescription: String {
            switch viewModel.completenessType {
            case .byToggle:
                return "Toque único para marcar o hábito como feito."
            case .byMultipleToggle:
                return "Cada toque avança o contador até o objetivo."
            case .byTimer:
                return "Inicie um cronômetro e o hábito se completa quando o tempo acabar."
            }
        }
    
    @State var howManyTimesToToggle: Int
    @State var typeOfRepetition: DaysRepeation = .allDays
    @State private var showDeleteAlert = false
    @State private var showGoalMeta = false
    var dismissSheet: DismissAction? = nil
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack{
                Form {
                    Section {
                        TextField("Ex: Tomar água", text: $viewModel.habitName)
                    }   header: {
                        Text("Nome")
                            .font(.system(size: 22).bold())
                            .foregroundStyle(Color.labelSecondary)
                    }
                    
                    Section {
                        TextField("Ex: Você consegue", text: $viewModel.newHabitDescription)
                    } header: {
                        Text("Descrição")
                            .font(.system(size: 22).bold())
                            .foregroundStyle(Color.labelSecondary)
                    }
                    
                    Section {
                        Picker(selection: $viewModel.completenessType) {
                            Text("Simples").tag(CompletionHabit.byToggle)
                            Text("Etapas").tag(CompletionHabit.byMultipleToggle)
                            Text("Tempo").tag(CompletionHabit.byTimer)
                        } label: {
                            HStack {
                                Image(systemName: "checklist")
                                    .foregroundStyle(Color.indigoCustom)
                                    .font(.system(size: 16))
                                Text("Tipo de hábito")
                            }
                        }
                        .tint(.secondary)
                        
                        
                        NavigationLink {
                            IconPickerView(selectedIcon: $viewModel.habitsSymbol)
                        } label: {
                            HStack {
                                Image(systemName: viewModel.habitsSymbol)
                                    .foregroundStyle(Color.indigoCustom)
                                    .font(.system(size: 16))
                                Text("Icone")
                                
                                Spacer()
                            }
                        }
                        
                        
                        
                        Picker(selection: $typeOfRepetition) {
                            Text("Todos os dias").tag(DaysRepeation.allDays)
                            Text("Personalizado").tag(DaysRepeation.personalized)
                        } label: {
                            HStack {
                                Image(systemName: "repeat")
                                    .foregroundStyle(Color.indigoCustom)
                                    .font(.system(size: 16))
                                Text("Repete")
                            }
                        }
                        .tint(.secondary)
                    } header: {
                        Text("Geral")
                            .font(.system(size: 22).bold())
                            .foregroundStyle(Color.labelSecondary)
                    } footer: {
                        Text(habitCompletenessDescription)
                            .font(.footnote)
                            .foregroundStyle(Color.labelSecondary)
                            .padding(.top, 4)
                    }
                    
                    if typeOfRepetition == .personalized {
                        Section{
                            HStack(spacing: 10) {
                                ForEach(1...7, id: \.self) { day in
                                    Text(weekDays[day - 1])
                                        .fontWeight(.bold)
                                        .frame(width: 40, height: 40)
                                        .background(
                                            Circle()
                                                .fill(viewModel.selectedDays.contains(day) ? Color.accentColor : Color.gray.opacity(0.2))
                                        )
                                        .foregroundColor(viewModel.selectedDays.contains(day) ? .white : .primary)
                                        .onTapGesture {
                                            viewModel.toggleSelection(for: day)
                                        }
                                }
                            }
                        } header: {
                            Image(systemName: "numbers.rectangle")
                                .font(.system(size: 16))
                                .foregroundStyle(.indigoCustom)
                            Text("Meta")
                        }
                    }
                    
                    if viewModel.completenessType == .byMultipleToggle {
                        Section {
                            HStack {
                                Image(systemName: "numbers.rectangle")
                                    .font(.system(size: 16))
                                    .foregroundStyle(.indigoCustom)
                                Text("Meta")
                                Spacer()
                                
                                let numberFormatter: NumberFormatter = {
                                    let formatter = NumberFormatter()
                                    formatter.numberStyle = .none
                                    formatter.allowsFloats = false
                                    return formatter
                                }()
                                
                                TextField("", value: $howManyTimesToToggle, formatter: numberFormatter)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                                    .frame(width: 60)
                                    .multilineTextAlignment(.center)
                            }
                        } header: {
                            Text("Etapas")
                                .font(.system(size: 22).bold())
                                .foregroundStyle(Color.secondary)
                        }
                    }
                    
                    if viewModel.completenessType == .byTimer {
                        Section {
                            Picker(selection: $viewModel.timesChoiceEnum) {
                                Text("1 min").tag(TimeOption.oneMinute)
                                Text("3 min").tag(TimeOption.threeMinutes)
                                Text("5 min").tag(TimeOption.fiveMinutes)
                                Text("10 min").tag(TimeOption.tenMinutes)
                                Text("15 min").tag(TimeOption.fifteenMinutes)
                                Text("20 min").tag(TimeOption.twentyMinutes)
                                Text("30 min").tag(TimeOption.thirtyMinutes)
                                Text("45 min").tag(TimeOption.fortyFiveMinutes)
                                Text("1 hora").tag(TimeOption.oneHour)
                            } label: {
                                HStack {
                                    Image(systemName: "numbers.rectangle")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.indigoCustom)
                                    Text("Meta")
                                }
                            }
                            .tint(.secondary)
                            .pickerStyle(.menu)
                        } header: {
                            Text("Tempo")
                                .font(.system(size: 22).bold())
                                .foregroundStyle(Color.secondary)
                        }
                    }
                    
                    if let id {
                        Section {
                            Button {
                                showDeleteAlert = true
                                viewModel.id = id
                            } label: {
                                Text("Excluir hábito")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 16).fill(.fillsTertiary))
                                    .foregroundStyle(Color.indigoCustom)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 17))
                            }
                            .alert("Voçê tem certeza que deseja excluir esse hábito?", isPresented: $showDeleteAlert) {
                                Button(role: .cancel) {}
                                label: {
                                    Text("Voltar a editar")
                                        .foregroundStyle(.white)
                                }
                                .background(.indigoCustom)
                                Button("Excluir hábito", role: .destructive) {
                                    Task { await viewModel.deleteHabitById()
                                        dismissSheet?()
                                        dismiss()
                                        dismiss()
                                    }
                                }
                            } message: { //alert's description
                                Text("Ao excluir, você perderá todos os seus resumos e dados do seu hábito")
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.backgroundSecondary)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                    })
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if typeOfRepetition == .allDays {
                            viewModel.selectedDays = [1, 2, 3, 4, 5, 6, 7]
                        }
                        
                        viewModel.timesChoice = viewModel.timesChoiceEnum.rawValue
                        if let id {
                            viewModel.id = id
                        }
                        if viewModel.howManyTimesToComplete <= howManyTimesToToggle {
                            Task {
                                viewModel.howManyTimesToComplete = howManyTimesToToggle
                                viewModel.newHabitDescription = ""
                                await viewModel.createNewHabit()
                                dismiss()
                                dismiss()
                            }
                        } else {
                            showGoalMeta = true
                        }
                    }, label: {
                        Image(systemName: "checkmark")
                    })
                    .disabled(viewModel.habitName.trimmingCharacters(in: .whitespaces) == "")
                }
            }
            .navigationBarBackButtonHidden()
            .alert("Conflito de posição", isPresented: $viewModel.showSlotConflictAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.conflictMessage)
            }
            .alert("Meta não pode ser reduzida", isPresented: $showGoalMeta) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("A meta só pode ser mantida ou aumentada. Se quiser definir uma meta menor, crie um novo hábito.")
            }
        }
    }
}
