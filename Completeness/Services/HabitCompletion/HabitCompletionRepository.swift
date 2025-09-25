////
////  HabitTrackerService.swift
////  Completeness
////
////  Created by Gustavo Ferreira bassani on 15/09/25.
////
//
import SwiftData
import Foundation

/// Manages all habit completion logic operations.
class HabitCompletionRepository: HabitCompletionProtocol {
    // The ModelContext is our "bridge" to the database.
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    /// Fetches all habits stored in the database.
    /// - Throws: Throws an error if the SwiftData fetch operation fails.
    /// - Returns: An array containing all `Habit` objects.
    func getAllHabits() async throws -> [Habit] {
        let descriptor = FetchDescriptor<Habit>()
        do {
            let allHabits: [Habit] = try context.fetch(descriptor)
            return allHabits
        } catch {
            print("Error fetching habits: \(error.localizedDescription)")
            // We return an empty array on failure so the UI can handle it gracefully.
            return []
        }
    }
    
    /// Fetches a specific habit by its unique ID.
    /// - Parameter id: The `UUID` of the habit to find.
    /// - Returns: An optional `Habit` object, if found.
    func getHabitById(id: UUID) async -> Habit? {
        let predicate = #Predicate<Habit> { $0.id == id }
        let descriptor = FetchDescriptor(predicate: predicate)
        return (try? context.fetch(descriptor))?.first
    }
    
    // MARK: - Habit Completion Logic
    // The functions below represent the different "strategies" a habit can have for completion.
    
    /// Marks a habit as completed or not completed (toggle logic).
    /// This is the most common strategy: one tap checks it, another unchecks it.
    /// - Parameter id: The `UUID` of the habit to be modified.
    @MainActor
    func completeByToggle(id: UUID, on date: Date) async {
        guard let habitToChange = await getHabitById(id: id) else { return }
        let targetDay = Calendar.current.startOfDay(for: date)
        
        var logs = habitToChange.habitLogs ?? []
        
        // IF THE LOG WITH SAME DAY EXIST
        if let habitLog = habitToChange.habitLogs?.first(where: { Calendar.current.isDate($0.completionDate, inSameDayAs: targetDay)}) {
            // IF IS COMPLETED, CHANGE TO FALSE
            if habitLog.isCompleted {
                habitLog.isCompleted = false
                habitLog.howManyTimesItWasDone -= 1
            } else {
                habitLog.isCompleted = true
                habitLog.howManyTimesItWasDone += 1
            }
        } else {
            // IF NO LOG EXISTS: The user is CHECKING the habit.
            let newHabitLog = HabitLog(completionDate: targetDay)
            newHabitLog.howManyTimesItWasDone += 1
            newHabitLog.isCompleted = true
            print(newHabitLog.howManyTimesItWasDone)
            // We append the new log to our local copy.
            logs.append(newHabitLog)
        }
        
        habitToChange.habitLogs = logs
        
        try? context.save()
    }
    
    @MainActor
    func completeByMultipleToggle(id: UUID, on date: Date) async {
        guard let habitToChange = await getHabitById(id: id) else { return }
        let targetDay = Calendar.current.startOfDay(for: date)
        var logs = habitToChange.habitLogs ?? []
        
        // IF THE LOG WITH SAME DAY EXIST
        if let habitLog = habitToChange.habitLogs?.first(where: { Calendar.current.isDate($0.completionDate, inSameDayAs: targetDay)})  {
            // if the habit is completed, mark as undone and
            if habitLog.isCompleted {
                habitLog.isCompleted = false
                habitLog.howManyTimesItWasDone = 0
                return
            }
            
            // if the habit isnt completed already, add one more
            if habitLog.howManyTimesItWasDone < habitToChange.howManyTimesToToggle - 1 {
                habitLog.howManyTimesItWasDone += 1
                try? context.save()
            } else {
                habitLog.isCompleted = true
                habitLog.howManyTimesItWasDone += 1
                try? context.save()
            }
        } else {
            // IF the log doenst not exist, create one.
            let newHabitLog = HabitLog(completionDate: targetDay)
            newHabitLog.howManyTimesItWasDone += 1
            logs.append(newHabitLog)
            habitToChange.habitLogs = logs
            try? context.save()
        }
    }
    
    
    @MainActor
    func completeByTimer(id: UUID, on date: Date) async {
        guard let habitToChange = await getHabitById(id: id) else { return }
        let targetDay = Calendar.current.startOfDay(for: date)
        
        if (habitToChange.habitLogs ?? []).contains(where: { Calendar.current.isDate($0.completionDate, inSameDayAs: targetDay) &&
            $0.isCompleted == true}) {
            return
        }
        var logs = habitToChange.habitLogs ?? []
        let newLog = HabitLog(completionDate: targetDay)
        logs.append(newLog)
        habitToChange.habitLogs = logs
        
        Task { @MainActor in
            while newLog.secondsElapsed < habitToChange.howManySecondsToComplete {
                try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 segundo
                newLog.secondsElapsed += 1
                try? context.save()
                print(newLog.secondsElapsed)
            }
            
            // Completar o hábito
            habitToChange.habitIsCompleted = true
            try? context.save()
            print("Hábito completado!")
        }
    }
    
    
    /// Marks a habit as complete after a specified time interval.
    /// Useful for duration-based habits, like "Meditate for 5 minutes".
    /// - Parameters:
    ///   - id: The `UUID` of the habit.
    ///   - seconds: The time in seconds to wait before marking as complete.
    //    func completeWithTimer(id: UUID, after seconds: TimeInterval, on date: Date) async {
    //        // We use DispatchQueue.main.asyncAfter to schedule the code's execution.
    //        // This is NON-BLOCKING. The UI remains responsive while the timer is running.
    //        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
    //            // When the timer finishes, we simply reuse the 'completeByToggle' logic.
    //            // This is great for avoiding code duplication.
    //            await self.completeByToggle(id: id, on: date)
    //        }
    //    }
    
}
