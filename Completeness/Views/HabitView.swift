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
    @State private var showingAddHabit = false
    @State private var showEditHabbit = false
    @State private var habbitToEdit: Habit?
    @Binding var refreshView: Bool
    
    
    func showHabitsRow(witch row: Int) -> some View {
        var numberOfColunms: Int
        
        if row.isMultiple(of: 2) {
            numberOfColunms = 3
        } else {
            numberOfColunms = 4
        }
        
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
                        .sheet(item: $habbitToEdit) { habit in
                            HabitsConfig(id: habit.id,
                                         viewModel: viewModel,
                                         title: "Edit \(habit.habitName)",
                                         habitName: habit.habitName,
                                         timesChoice: TimeOption(rawValue: habit.howManySecondsToComplete) ?? TimeOption.oneMinute,
                                         selectedDays: habit.scheduleDays,
                                         howManyTimesToComplete: habit.howManyTimesToToggle,
                                         completenessType: habit.habitCompleteness ?? CompletionHabit.byToggle,
                                         habitsSymbol: habit.habitSimbol)
                        }
                } else {
                    EmptyCircle()
                        .onTapGesture {
                            viewModel.newValuePosition = row
                            viewModel.newIndicePosition = colunm
                            showingAddHabit = true
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
        .sheet(isPresented: $showingAddHabit) {
            AddHabitsView(viewModel: viewModel)
        }
    }
}
