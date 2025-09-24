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
                        ForEach(1...4, id: \.self) { indice in
                            if indice.isMultiple(of: 2) {
                                HStack(alignment: .center, spacing: 12) {
                                    ForEach(1...3, id: \.self) { value in
                                        if let habitWithPosition = viewModel.habits.first(where: {habit in
                                            habit.valuePosition == value && habit.indicePosition == indice &&
                                            viewModel.filteredHabits.contains(habit) }) {
                                            EmptyCircle(habit: habitWithPosition)
                                                .onTapGesture {
                                                    Task { await viewModel.completeHabit(habit: habitWithPosition, on: viewModel.selectedDate) }
                                                }
                                        } else {
                                            EmptyCircle()
                                                .onTapGesture {
                                                    viewModel.newValuePosition = value
                                                    viewModel.newIndicePosition = indice
                                                    showingAddHabit = true
                                                }
                                        }
                                    }
                                }
                            } else {
                                HStack(alignment: .center, spacing: 12) {
                                    ForEach(1...4, id: \.self) { value in
                                        if let habitWithPosition = viewModel.habits.first(where: {habit in
                                            habit.valuePosition == value && habit.indicePosition == indice &&
                                            viewModel.filteredHabits.contains(habit) }) {
                                            EmptyCircle(habit: habitWithPosition)
                                                .onTapGesture {
                                                    Task {
                                                        await viewModel.completeHabit(habit: habitWithPosition, on: viewModel.selectedDate)
                                                    }
                                                }
                                        } else {
                                            EmptyCircle()
                                                .onTapGesture {
                                                    viewModel.newValuePosition = value
                                                    viewModel.newIndicePosition = indice
                                                    showingAddHabit = true
                                                }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 16)
                }
                .defaultScrollAnchor(.top)
                
                
            default:
                EmptyView()
            }
        }
        .background(.backgroundSecondary)
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

#Preview {
    @Previewable @Environment(\.modelContext) var context
    HabitView(viewModel: HabitsViewModel(habitCompletionService: HabitCompletionRepository(context: context), habitService: HabitRepository(context: context)))
}
