//
//  HabitView.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
//

import SwiftUI
import SwiftData

struct HabitView: View {
    @State private var viewModel: HabitsViewModel
    
    // Controle do sheet/modal
    @State private var showingAddHabit = false
    @State private var newHabitName = ""
    @State private var newHabitDate = Date()
    
    init(context: ModelContext) {
        _viewModel = State(initialValue: HabitsViewModel(
            habitCompletionService: HabitCompletionRepository(context: context),
            habitService: HabitRepository(context: context)
        ))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Hábitos")
                    .font(.largeTitle).bold()
                
                Spacer()
                
                AddHabitButton {
                    newHabitDate = viewModel.selectedDate
                    showingAddHabit = true
                }
            }
            .padding(.horizontal)
            
            WeekDayPicker(selectedDate: $viewModel.selectedDate)
            
            Divider()
            
            if viewModel.state == .error {
                Text(viewModel.errorMessage ?? "Erro desconhecido")
                    .foregroundColor(.red)
                    .padding()
            } else if viewModel.filteredHabits.isEmpty {
                Text("Nenhum hábito para este dia")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                List(viewModel.filteredHabits) { habit in
                    HStack {
                        Text(habit.habitName)
                        Spacer()
                    }
                }
                .listStyle(.plain)
                .background(Color.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task { await viewModel.loadData() }
        .sheet(isPresented: $showingAddHabit) {
            AddHabitView(
                isPresented: $showingAddHabit,
                newHabitName: $newHabitName,
                newHabitDate: $newHabitDate
            ) {
                let newHabit = Habit(
                    habitName: newHabitName,
                    timestampHabit: newHabitDate,
                    howManyTimesToToggle: 1
                )
                viewModel.habitService.createHabit(habit: newHabit)
                Task { await viewModel.loadData() }
                newHabitName = ""
                showingAddHabit = false
            }
        }
    }
}
