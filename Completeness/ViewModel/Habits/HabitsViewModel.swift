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
    var notificationService: NotificationHelper
    var chartsService: ChartsService
    
    var createHabbitWithPosition: Position?
    
    init(habitCompletionService: HabitCompletionProtocol,
         habitService: HabitRepositoryProtocol,
         notificationService: NotificationHelper,
         chartsService: ChartsService) {
        self.habitCompletionService = habitCompletionService
        self.habitService = habitService
        self.notificationService = notificationService
        self.chartsService = chartsService
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
    
//    func triggerNotifications() async {
//        let allHabits = await chartsService.getNumberOfHabbits(inLastDays: 1)
//        let countDoneHabitsPerDay = await chartsService.getNumberOfHabbitsCompleted(inLastDays: 1)
//        
//        notificationService.stopAllNotifications()
//        notificationService.weeklyNotification(title: "Resumo da sua semana", body: "Veja como você se saiu nos seus hábitos nesta semana!")
//        notificationService.nightlyNotification(title: "Resumo do seu dia", body: "Você completou \(countDoneHabitsPerDay) de \(allHabits) hábitos hoje, muito bom!")
//        notificationService.dailyNotification(title: "Continue assim!", body: "Faltam \(allHabits - countDoneHabitsPerDay) hábitos para você concluir seu dia!")
//    }
    
    func triggerNotifications() async {
        let allHabits = await chartsService.getNumberOfHabbits(inLastDays: 1)
        let countDoneHabitsPerDay = await chartsService.getNumberOfHabbitsCompleted(inLastDays: 1)
        
        notificationService.stopAllNotifications()
        
        // Notificação semanal
        if UserDefaults.standard.bool(forKey: "weeklyNotification") {
            notificationService.weeklyNotification(
                title: "Resumo da sua semana",
                body: "Veja como você se saiu nos seus hábitos nesta semana!"
            )
        } else {
            notificationService.removeWeeklyNotification()
        }
        
        // Notificação noturna
        if UserDefaults.standard.bool(forKey: "nightlyNotification") {
            notificationService.nightlyNotification(
                title: "Resumo do seu dia",
                body: "Você completou \(countDoneHabitsPerDay) de \(allHabits) hábitos hoje, muito bom!"
            )
        } else {
            notificationService.removeNightlyNotification()
        }
        
        // Notificação diária
        if UserDefaults.standard.bool(forKey: "dailyNotification") {
            notificationService.dailyNotification(
                title: "Continue assim!",
                body: "Faltam \(allHabits - countDoneHabitsPerDay) hábitos para você concluir seu dia!"
            )
        } else {
            notificationService.removeDailyNotification()
        }
    }

    
    
    
    @MainActor
    func didTapHabit(_ habit: Habit) async {
        await triggerNotifications()
        await completeHabit(habit: habit, on: selectedDate)
        await loadData()
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
