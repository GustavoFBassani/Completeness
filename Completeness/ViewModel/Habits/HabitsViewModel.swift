////
////  HabitsViewModel.swift
////  Completeness
////
////  Created by Gustavo Ferreira bassani on 16/09/25.
////

import SwiftUI
import Observation
import Combine

// MARK: - State
enum HabitsStates {
    case idle
    case error
    case loaded
}

// MARK: - ViewModel
@Observable
final class HabitsViewModel: HabitsProtocol, Sendable {
    var state: HabitsStates = .idle
    var selectedDate: Date = .now {
        didSet {
           filteredHabits = habits.filter {
               $0.isScheduled(for: selectedDate)
           }
        }
    }
    var errorMessage: String?
    var habits: [Habit] = []
    var habitCompletionService: HabitCompletionProtocol
    var habitService: HabitRepositoryProtocol
    var textField = ""
    
    // MARK: - NEW HABIT
    var completenessType: CompletionHabit = .byTimer
    var howManyTimesToCompleteHabit = 5
    var howManySecondsToCompleteHabit = 300
    var newHabitName = ""
    var newValuePosition = 0
    var newIndicePosition = 0
    var newHabitDate = Date()
    var newHabitDays: [Int] = []
    var filteredHabits: [Habit] = []
         
    init(habitCompletionService: HabitCompletionProtocol, habitService: HabitRepositoryProtocol) {
        self.habitCompletionService = habitCompletionService
        self.habitService = habitService
    }
    
    // MARK: - Functions
    func getAllHabits() async throws {
        do {
            habits = try await habitService.getAllHabits()
            state = .loaded
        } catch {
            print("cannot get all Habits, ERROR: \(error.localizedDescription)")
            state = .error
        }
    }
    
    func createNewHabit() {
        guard !newHabitName.isEmpty else {return }
        
        let newHabit = Habit(
            habitName: newHabitName,
            habitCompleteness: completenessType,
            howManyTimesToToggle: howManyTimesToCompleteHabit,
            scheduleDays: newHabitDays,
            valuePosition: newValuePosition,
            indicePosition: newIndicePosition,
            howManySecondsToComplete: howManySecondsToCompleteHabit
        )
        
        habits.append(newHabit)
        habitService.createHabit(habit: newHabit)
        Task{
            await loadData()
        }
    }
    
    func completeHabit(habit: Habit, on date: Date) async {
        switch habit.habitCompleteness {
        case .byMultipleToggle:
            return await habitCompletionService.completeByMultipleToggle(id: habit.id, on: date)
        case .byToggle:
            return await habitCompletionService.completeByToggle(id: habit.id, on: date)
        case .byTimer:
            return await habitCompletionService.completeByTimer(id: habit.id, on: date)
        default:
            break
        }
    }
    
    func editHabit() {
        habitService.saveChanges()
    }
    
    @MainActor
    func loadData() async {
        do {
            try await getAllHabits()

            filteredHabits = habits.filter {
                $0.isScheduled(for: selectedDate)
            }
            
            print(filteredHabits)

            state = .loaded
        } catch {
            errorMessage = "Error fetching products: \(error.localizedDescription)"
            state = .error
        }
    }
}
