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
    @State private var habbitToEdit: Habit?
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
                                await viewModel.didTapHabit(habitWithPosition)
                                refreshView.toggle()
                            }
                        }
                        .onLongPressGesture {
                            habbitToEdit = habitWithPosition
                            print(habitWithPosition.howManyTimesToToggle)
                        }
                        .sheet(item: $habbitToEdit, onDismiss: {
                            Task {
                                await viewModel.loadData()
                                refreshView.toggle()
                            }
                        }) { habit in
                            HabitsConfigView(id: habit.id,
                                             viewModel: configsVMFactory.editHabits(
                                                habitName: habit.habitName,
                                                scheduleDays: habit.scheduleDays,
                                                habitSimbol: habit.habitSimbol,
                                                habitCompleteness: habit.habitCompleteness,
                                                howManySecondsToComplete: habit.howManySecondsToComplete,
                                                howManyTimesToToggle: habit.howManyTimesToToggle,
                                                habitDescription: habit.habitDescription))
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
            HStack {
                Text("Hábitos")
                    .font(.largeTitle).bold()
                
                Spacer()
                
                //                AddHabitButton {
                //                    showingAddHabit = true
                //                }
            }
            .padding(.horizontal)
            
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
                    .padding(.vertical, 16)
                }
                .defaultScrollAnchor(.top)
                
                
            default:
                EmptyView()
            }
        }
        .onAppear {
            viewModel.selectedDate = Calendar.current.startOfDay(for: Date())
        }
        
        .background(.backgroundSecondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task { await viewModel.loadData() }
//        .navigationTitle("Hábitos")
    }
}
