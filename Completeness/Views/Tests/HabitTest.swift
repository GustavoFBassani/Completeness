//
//  HabitTest.swift
//  Completeness
//
//  Created by Gustavo Melleu on 18/09/25.
//

import SwiftUI
import SwiftData

struct HabitTest: View {
    @Bindable var viewModel: HabitsViewModel
    
    // Controle do sheet/modal
    @State private var showingAddHabit = false
    

    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Hábitos")
                    .font(.largeTitle).bold()
                
                Spacer()
                
                AddHabitButton {
                    viewModel.newHabitDate = viewModel.selectedDate
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
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//        .task { await viewModel.loadData() }
//        .sheet(isPresented: $showingAddHabit) {
//            AddHabitView(
//                isPresented: $showingAddHabit,
//                newHabitName: $viewModel.newHabitName,
//                newHabitDate: $viewModel.newHabitDate
//            ) {
//                let newHabit = Habit(
//                    habitName: viewModel.newHabitName,
//                    timestampHabit: viewModel.newHabitDate,
//                    howManyTimesToToggle: 1
//                )
//                viewModel.habitService.createHabit(habit: newHabit)
//                Task { await viewModel.loadData() }
//                viewModel.newHabitName = ""
//                showingAddHabit = false
//            }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task { await viewModel.loadData() }
        .sheet(isPresented: $showingAddHabit) {
            AddNewHabit()
        }
        }
    }
