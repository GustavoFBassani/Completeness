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
    struct Position: Identifiable {
        init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
        let id = UUID()
        let row: Int
        let column: Int
    }
    @State private var createHabbitWithPosition: Position?
    @Binding var refreshView: Bool
    
    let repositoryFactory: HabitRepositoryFactory
    
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
                                await viewModel.completeHabit(habit: habitWithPosition, on: viewModel.selectedDate)
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
                                         viewModel: HabitConfigViewModel(habitName: habit.habitName,
                                                                         selectedDays: habit.scheduleDays,
                                                                         habitsSymbol: habit.habitSimbol,
                                                                         completenessType: habit.habitCompleteness ?? .byToggle,
                                                                         timesChoice: habit.howManySecondsToComplete,
                                                                         howManyTimesToComplete: habit.howManyTimesToToggle,
                                                                         habitService: repositoryFactory.makeHabitRepository(),
                                                                         newHabitDescription: habit.habitDescription)
                            )
                        }
                } else {
                    EmptyCircle()
                        .onTapGesture {
                            createHabbitWithPosition = Position(row: row, column: colunm)
                        }
                        .sheet(item: $createHabbitWithPosition, onDismiss: {
                            Task {
                                await viewModel.loadData()
                                refreshView.toggle()
                            }
                        }) { rowAndColunm in
                            AddHabitsView(repositoryFactory: repositoryFactory, rowPosition: rowAndColunm.row,
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
                .padding(.vertical, 16)
            
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
    }
}
