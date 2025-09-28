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
    var completenessType: CompletionHabit = .byToggle
    var howManyTimesToCompleteHabit = 1
    var howManySecondsToCompleteHabit = 900
    var newHabitName = " "
    var newHabitDescription = ""
    var newValuePosition = 0
    var newIndicePosition = 0
    var newHabitDate = Date()
    var newHabitDays: [Int] = []
    var filteredHabits: [Habit] = []
    var habitSymbol = ""
    var id: UUID?
    
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
    
    // isso aqui nao era pra ta aqui
    func createNewHabit() async {
        guard !newHabitName.isEmpty else { return }
        
        if let id {
            print(" entrou aqui? ")
            print(#file, #line, id)

            if let habitWithID = await habitService.getHabitById(id: id) {
                habitWithID.habitName = newHabitName
                habitWithID.habitSimbol = habitSymbol
                habitWithID.habitCompleteness = completenessType
                habitWithID.howManyTimesToToggle = howManyTimesToCompleteHabit
                habitWithID.scheduleDays = newHabitDays
                habitWithID.howManySecondsToComplete = howManySecondsToCompleteHabit
                
                habitService.saveChanges()
                    await loadData()
            }
            
        } else {
            let newHabit = Habit(
                habitName: newHabitName,
                habitSimbol: habitSymbol,
                habitCompleteness: completenessType,
                howManyTimesToToggle: howManyTimesToCompleteHabit,
                scheduleDays: newHabitDays,
                valuePosition: newValuePosition,
                indicePosition: newIndicePosition,
                howManySecondsToComplete: howManySecondsToCompleteHabit
            )
            
                habits.append(newHabit)
                await habitService.createHabit(habit: newHabit)
                await loadData()
        }
    }
    
    func deleteHabitById() async {
        if let id {
            await habitService.deleteHabit(id: id)
            habitService.saveChanges()
            self.id = nil
        }
        await loadData()
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
