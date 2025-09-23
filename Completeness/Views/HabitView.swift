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
                ForEach(viewModel.filteredHabits) { habit in
                    HabitRowView(habit: habit, viewModel: viewModel)
                }
                .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task { await viewModel.loadData() }
        .sheet(isPresented: $showingAddHabit) {
            AddHabitView(
                isPresented: $showingAddHabit,
                newHabitName: $viewModel.newHabitName,
                newHabitDate: $viewModel.selectedDate,
                selectedDays: $viewModel.newHabitDays
            ) {
                viewModel.createNewHabit()
                showingAddHabit = false
            }
        }
    }
}
