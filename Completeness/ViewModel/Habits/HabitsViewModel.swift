import SwiftUI
#if canImport(ActivityKit)
import ActivityKit
#endif
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
final class HabitsViewModel: /*HabitsViewModelProtocol,*/ Sendable {
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
    var selectedHabit: Habit?
    var isHabbitWithIdRunning: [UUID: Bool] = [:]
    var habitToVerifyIfIsRunning: Habit?
    
    #if canImport(ActivityKit)
    var timerActivity: Activity<timerActivityAttributes>?
    #endif
    var habitTimerForActivity: Timer?
    
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
    
    func isHabitRunning() {
        if let habitToVerifyIfIsRunning {
            let isRunning = habitCompletionService.isHabbitRunning(with: habitToVerifyIfIsRunning.id)
            // Preserve existing running states for other habits and update only this habit's entry
            isHabbitWithIdRunning[habitToVerifyIfIsRunning.id] = isRunning
        }
    }
    
    func isHabitFromWatchRuning(habit: Habit) {
        let isRunning = habitCompletionService.isHabbitRunning(with: habit.id)
        // Preserve existing running states for other habits and update only this habit's entry
        isHabbitWithIdRunning[habit.id] = isRunning
    }
    
    @MainActor
    func didTapHabit(_ habit: Habit) async {
        await triggerNotifications()
        await completeHabit(habit: habit, on: selectedDate)
        await loadData()
        habitToVerifyIfIsRunning = habit
        isHabitRunning()
        
        #if canImport(ActivityKit)
        if habit.habitCompleteness == .byTimer {
            if isHabbitWithIdRunning[habit.id] ?? false {
                if timerActivity == nil {
                    
                    startTimerActivity(for: habit)
                }
                startInternalTimerForActivity(for: habit)
            } else {
                stopInternalTimer()
                endTimerActivity(for: habit)
            }
        }
        #endif
        
        isHabitFromWatchRuning(habit: habit)
    }
    //used at sheet --------
    func didTapSelectedHabit(_ habit: Habit) async {
        await completeHabit(habit: habit, on: selectedDate)
        await loadData()
    }
    
    func completeHabitAutomatically(habit: Habit) async {
        await habitCompletionService.completeToggleAndMultipleToggleAutomatic(id: habit.id, on: selectedDate)
    }
    
    func decreaseHabitSteps(habit: Habit, date: Date) async {
        await habitCompletionService.decreaseHabitStep(id: habit.id, on: date)
    }
    
    func resetHabitTimer(habit: Habit) async {
        await habitCompletionService.restartHabitTimer(id: habit.id, on: selectedDate)
        
        #if canImport(ActivityKit)
        stopInternalTimer()
        endTimerActivity(for: habit)
        #endif
        
        isHabitRunning()
    }
    
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
    
    #if canImport(ActivityKit)
    func startTimerActivity(for habit: Habit) {
        guard timerActivity == nil else { return }
        
        let activityAttributes = timerActivityAttributes(habitName: habit.habitName, habitDuration: habit.howManySecondsToComplete, habitIcon: habit.habitSimbol)
        
        guard let progress = getHabitLog(habit: habit)?.secondsElapsed else { return }
        let initalState = timerActivityAttributes.ContentState(timePassed: progress, isRunning: true)
        
        do {
            timerActivity = try Activity<timerActivityAttributes>.request(
                attributes: activityAttributes,
                contentState: initalState,
                pushType: nil)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func endTimerActivity(for habit: Habit) {
        guard !(timerActivity == nil) else { return }
        guard let progress = getHabitLog(habit: habit)?.secondsElapsed else { return }
        let finalState = timerActivityAttributes.ContentState(timePassed: progress, isRunning: false)
        
        Task {
            await timerActivity?.end(using: finalState, dismissalPolicy: .default)
            timerActivity = nil
        }
    }
    
    func updateTimerActivity(for habit: Habit) {
        guard !(timerActivity == nil) else { return }
        guard let progress = getHabitLog(habit: habit)?.secondsElapsed else { return }
        
        let newState = timerActivityAttributes.ContentState(timePassed: progress, isRunning: true)
        
        Task {
            await timerActivity?.update(using: newState)
        }
    }
    #endif
    
    func startInternalTimerForActivity(for habit: Habit) {
        habitTimerForActivity?.invalidate()
        
        self.habitTimerForActivity = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else {return}
            
            Task {
                await self.loadData()
                
                #if canImport(ActivityKit)
                if let updatedHabit = self.habits.first(where: { $0.id == habit.id }) {
                    self.updateTimerActivity(for: habit)
                    
                    if habit.isCompleted(on: self.selectedDate) {
                        self.stopInternalTimer()
                        self.endTimerActivity(for: updatedHabit)
                    }
                }
                #endif
            }
        }
    }
    
    func stopInternalTimer() {
        self.habitTimerForActivity?.invalidate()
        self.habitTimerForActivity = nil
    }
}
