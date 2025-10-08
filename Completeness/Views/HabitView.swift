//
//  HabitView.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
//

import SwiftUI
import SwiftData

struct HabitView: View {
    @Bindable var viewModel: HabitsViewModel
    @Binding var refreshView: Bool
    
    let configsVMFactory: HabitsConfigVMFactory
    
    func showHabitsRow(witch row: Int) -> some View {
        let numberOfColunms = row.isMultiple(of: 2) ? 3 : 4
        
        return HStack(alignment: .center, spacing: 12) {
            ForEach(1...numberOfColunms, id: \.self) { colunm in
                if let habitWithPosition = viewModel.habits.first(where: {habit in
                    habit.valuePosition == row && habit.indicePosition == colunm &&
                    viewModel.filteredHabits.contains(habit) }) {
                    HabitViewComponent(habit: habitWithPosition, refreshView: refreshView, day: viewModel.selectedDate)
                        .onTapGesture {
                            Task {
                                viewModel.habitToVerifyIfIsRunning = habitWithPosition
                                viewModel.selectedHabit = habitWithPosition
                                await viewModel.triggerNotifications()
                                refreshView.toggle()
                            }
                        }
                        .sheet(item: $viewModel.selectedHabit, onDismiss: {
                            Task {
                                await viewModel.loadData()
                                refreshView.toggle()
                            }
                        }) {  habit in
                            HabitSheetView(isHabbitRunning: $viewModel.isHabbitWithIdRunning,
                                           selectedDate: viewModel.selectedDate,
                                           resetHabitTimer: {Task{ await viewModel.resetHabitTimer(habit: habit) }; refreshView.toggle()},

                                           completeTheHabitAutomatically: { Task {await viewModel.completeHabitAutomatically(habit: habit);  refreshView.toggle()}},
                                           subtractOneStep: { Task { await viewModel.decreaseHabitSteps(habit: habit);  refreshView.toggle() }},
                                           increaseOneStepOrStopAndPauseTimer: { Task { await viewModel.didTapHabit(habit); refreshView.toggle()}},
                                           habit: habit,
                                           configsVMFactory: configsVMFactory)
                                .presentationDetents([.medium])
                        }
                } else {
                    EmptyCircle()
                        .onTapGesture {
                            viewModel.createHabbitWithPosition = Position(row: row, column: colunm)
                        }
                        .sheet(item: $viewModel.createHabbitWithPosition, onDismiss: {
                            Task {
                                await viewModel.loadData()
                                refreshView.toggle()
                                _ = await NotificationHelper().requestNotificationPermissions()
                            }
                        }) { rowAndColunm in
                            AddHabitsView(configsVMFactory: configsVMFactory,
                                          rowPosition: rowAndColunm.row,
                                          colunmPosition: rowAndColunm.column)
                        }
                }
            }
        }
    }
    
    
    var body: some View {
        VStack(alignment: .leading) {
            WeekDayPicker(selectedDate: $viewModel.selectedDate)
//                .padding(.vertical, 16)
            
            Divider()
            
            switch viewModel.state {
            case .error:
                Text(viewModel.errorMessage ?? "Erro desconhecido")
                    .foregroundColor(.red)
                    .padding()
            case .loaded:
                ScrollView([.horizontal, .vertical]) {
                    VStack(spacing: 20) {
                        ForEach(1...4, id: \.self) { row in
                            showHabitsRow(witch: row)
                        }
                    }
                    .padding()
                }
                .defaultScrollAnchor(.top)
                .scrollIndicators(.hidden)
            default:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.selectedDate = Calendar.current.startOfDay(for: Date())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task { await viewModel.loadData() }
        .navigationTitle("Hábitos")
    }
}
