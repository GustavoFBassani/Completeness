////
////  AddCustomHabit.swift
////  Completeness
////
////  Created by Vítor Bruno on 23/09/25.
////
//
//import SwiftUI
//
//struct AddCustomHabit: View {
//    @Bindable var viewModel: HabitsViewModel
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                Section {
//                    TextField("Ex: Tomar água", text: $viewModel.newHabitName)
//                        .background(Color.textFieldBackground)
//                }   header: {
//                    Text("Nome")
//                        .font(.system(size: 22).bold())
//                        .foregroundStyle(Color.labelSecondary)
//                }
//                
//                Section {
//                    TextField("Ex: Você consegue", text: $viewModel.newHabitDescription)
//                        .background(Color.textFieldBackground)
//                } header: {
//                    Text("Descrição")
//                        .font(.system(size: 22).bold())
//                        .foregroundStyle(Color.labelSecondary)
//                }
//                
//                Section {
//                    Picker(selection: $viewModel.completenessType) {
//                        Text("Simples").tag(CompletionHabit.byToggle)
//                        Text("Etapas").tag(CompletionHabit.byMultipleToggle)
//                        Text("Tempo").tag(CompletionHabit.byTimer)
//                    } label: {
//                        HStack {
//                            Image(systemName: "checklist")
//                                .foregroundStyle(Color.indigoCustom)
//                                .font(.system(size: 16))
//                            Text("Tipo de hábito")
//                        }
//                    }
//                    .tint(.secondary)
//                    
//                    DatePicker(selection: $viewModel.newHabitDate, displayedComponents: .date) {
//                        HStack {
//                            Image(systemName: "calendar")
//                                .foregroundStyle(Color.indigoCustom)
//                                .font(.system(size: 16))
//                            Text("Começa em")
//                        }
//                    }
//                    
//                    Picker(selection: $viewModel.newHabitDays) {
//                        Text("Todos os dias")
//                        Text("Semanalmente")
//                        Text("Personalizado")
//                    } label: {
//                        HStack {
//                            Image(systemName: "repeat")
//                                .foregroundStyle(Color.indigoCustom)
//                                .font(.system(size: 16))
//                            Text("Repete")
//                        }
//                    }
//                    .tint(.secondary)
//                } header: {
//                    Text("Geral")
//                        .font(.system(size: 22).bold())
//                        .foregroundStyle(Color.labelSecondary)
//                }
//                
//                if viewModel.completenessType == .byMultipleToggle {
//                    Section {
//                        HStack {
//                            Image(systemName: "numbers.rectangle")
//                                .font(.system(size: 16))
//                                .foregroundStyle(.indigoCustom)
//                            Text("Meta")
//                            
//                            Spacer()
//                            
//                            let numberFormatter: NumberFormatter = {
//                                let formatter = NumberFormatter()
//                                formatter.numberStyle = .none
//                                formatter.allowsFloats = false
//                                return formatter
//                            }()
//                            
//                            TextField("", value: $viewModel.howManyTimesToCompleteHabit, formatter: numberFormatter)
//                                .keyboardType(.numberPad)
//                                .textFieldStyle(.roundedBorder)
//                                .frame(width: 60)
//                                .multilineTextAlignment(.center)
//                        }
//                    } header: {
//                        Text("Etapas")
//                            .font(.system(size: 22).bold())
//                            .foregroundStyle(Color.secondary)
//                    }
//                }
//                
//                if viewModel.completenessType == .byTimer {
//                    Section {
//                        Picker(selection: $viewModel.howManySecondsToCompleteHabit) {
//                            Text("1 min").tag(TimeInterval(60))
//                            Text("3 min").tag(TimeInterval(300))
//                            Text("5 min").tag(TimeInterval(300))
//                            Text("10 min").tag(TimeInterval(600))
//                            Text("15 min").tag(TimeInterval(900))
//                            Text("20 min").tag(TimeInterval(1_200))
//                            Text("30 min").tag(TimeInterval(1_800))
//                            Text("45 min").tag(TimeInterval(2_700))
//                            Text("1 hora").tag(TimeInterval(3_600))
//                        } label: {
//                            HStack {
//                                Image(systemName: "numbers.rectangle")
//                                    .font(.system(size: 16))
//                                    .foregroundStyle(.indigoCustom)
//                                Text("Meta")
//                            }
//                        }
//                        .tint(.secondary)
//                    } header: {
//                        Text("Tempo")
//                            .font(.system(size: 22).bold())
//                            .foregroundStyle(Color.secondary)
//                    }
//                }
//                
//                Section {
//                    Toggle(isOn: .constant(true)) {
//                        HStack {
//                            Image(systemName: "app.badge")
//                                .foregroundStyle(Color.indigoCustom)
//                                .font(.system(size: 16))
//                            Text("Avisos")
//                        }
//                    }
//                    Toggle(isOn: .constant(true)) {
//                        HStack {
//                            Image(systemName: "bell.badge")
//                                .foregroundStyle(Color.indigoCustom)
//                                .font(.system(size: 16))
//                            Text("Permitir notificações")
//                        }
//                    }
//                }  header: {
//                    Text("Notificações")
//                        .font(.system(size: 22).bold())
//                        .foregroundStyle(Color.labelSecondary)
//                }
//            }
//            .navigationTitle("Hábito personalizado")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button(action: {
//                        dismiss()
//                    }, label: {
//                        Image(systemName: "xmark")
//                    })
//                }
//                
//                ToolbarItem(placement: .confirmationAction) {
//                    Button(action: {
//                        viewModel.createNewHabit()
//                        dismiss()
//                    }, label: {
//                        Image(systemName: "checkmark")
//                    })
//                    .disabled(viewModel.newHabitName.trimmingCharacters(in: .whitespaces).isEmpty)
//                }
//            }
//        }
//    }
//}
