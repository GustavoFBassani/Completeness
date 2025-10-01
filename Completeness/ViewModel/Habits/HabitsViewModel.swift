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
    var filteredHabits: [Habit] = []
    var createHabbitWithPosition: Position?
    var selectedHabit: Habit?
    var isHabbitWithIdRunning: [UUID : Bool] = [UUID() : false]
    var habitToVerifyIfIsRunning: Habit?
    
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
    
    func isHabitRunning() {
        if let habitToVerifyIfIsRunning {
            let isRunning = habitCompletionService.isHabbitRunning(with: habitToVerifyIfIsRunning.id)
            isHabbitWithIdRunning = [habitToVerifyIfIsRunning.id : isRunning]
        }
    }
    
    @MainActor
    func didTapHabit(_ habit: Habit) async {
        await completeHabit(habit: habit, on: selectedDate)
        await loadData()
        isHabitRunning()
    }
    //used at sheet --------
    func didTapSelectedHabit(_ habit: Habit) async {
        await completeHabit(habit: habit, on: selectedDate)
        await loadData()
    }
    
    func completeHabitAutomatically(habit: Habit) async {
        await habitCompletionService.completeToggleAndMultipleToggleAutomatic(id: habit.id, on: selectedDate)
    }
    
    func decreaseHabitSteps(habit: Habit) async {
        await habitCompletionService.decreaseHabitStep(id: habit.id, on: selectedDate)
    }
    
    func resetHabitTimer(habit: Habit) async {
        await habitCompletionService.restartHabitTimer(id: habit.id, on: selectedDate)
        isHabitRunning()
        
    }
    // --------------------
    func getHabitLog(habit: Habit) -> HabitLog? {
        if let habitLog = habit.habitLogs?.first(where: {log in
            log.completionDate == selectedDate }) {
            return habitLog
        }
        return nil
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
