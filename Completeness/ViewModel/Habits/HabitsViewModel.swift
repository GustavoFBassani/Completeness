//
//  HabitsViewModel.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 16/09/25.
//

import SwiftUI
import Observation

// MARK: - State
enum HabitsStates {
    case idle
    case error
    case loaded
}

// MARK: - ViewModel
@Observable
final class HabitsViewModel: HabitsProtocol {
    var newHabitName: String = ""
    var state: HabitsStates = .idle
    var selectedDate: Date = .now
    var errorMessage: String?
    var habits: [Habit] = []
    var habitCompletionService: HabitCompletionProtocol
    var habitService: HabitRepositoryProtocol
    var textField = ""
    var completenessType: CompletionHabit = .byToggle
    var howManyTimesToCompleteHabit = 1
    var filteredHabits: [Habit] {
           habits.filter {
               Calendar.current.isDate($0.timestampHabit, inSameDayAs: selectedDate)
           }
       }

    func selectDate(_ date: Date) {
          selectedDate = date
      }

    var habitToEdit: Habit = .init(howManyTimesToToggle: 1)

    
    init(habitCompletionService: HabitCompletionProtocol, habitService: HabitRepositoryProtocol) {
        self.habitCompletionService = habitCompletionService
        self.habitService = habitService
    }
    
    // MARK: - Functions
    func getAllHabits() throws {
        do {
            habits = try habitService.getAllHabits()
        } catch {
            print("cannot get all Habits, ERROR: \(error.localizedDescription)")
        }
    }
    
    func createNewHabit() {
        let newHabit = Habit(
            habitName: textField,
            habitCompleteness: completenessType,
            howManyTimesToToggle: howManyTimesToCompleteHabit
        )
        
        habitService.createHabit(habit: newHabit)
        Task{
            await loadData()
        }
    }
    
    func completeHabitByToggle(by id: UUID) {
        habitCompletionService.completeByToggle(id: id)
    }
    
    func completeHabitByMultipleToggle(by id: UUID) {
        habitCompletionService.completeByMultipleToggle(id: id)
    }
    
    func showAditionalConfigForHabit() -> Bool {
        self.completenessType == .byMultipleToggle
    }
    
    func deleteHabit(by id: UUID) {
        habitService.deleteHabit(id: id)
    }
    
    func editHabit() {
        habitService.saveChanges()
    }
    
    @MainActor
    func loadData() async {
        do {
            try getAllHabits()
            state = .loaded
        } catch {
            errorMessage = "Error fetching products: \(error.localizedDescription)"
            state = .error
        }
    }
}

