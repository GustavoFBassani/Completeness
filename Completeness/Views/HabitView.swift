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
//    @State private var newHabitName = ""
//    @State private var newHabitDate = Date()
//    
    init(viewModel: HabitsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Hábitos")
                    .font(.largeTitle).bold()
                
                Spacer()
                
                AddHabitButton {
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
                newHabitName: $viewModel.newHabitName,
                newHabitDate: $viewModel.selectedDate
            ) {
                let newHabit = Habit(
                    habitName: viewModel.newHabitName,
                    timestampHabit: viewModel.selectedDate,
                    howManyTimesToToggle: 1
                )
                viewModel.habitService.createHabit(habit: newHabit)
                Task { await viewModel.loadData() }
                viewModel.newHabitName = ""
                showingAddHabit = false
            }
        }
    }
}
