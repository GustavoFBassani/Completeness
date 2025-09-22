//
//  HabitTrackerService.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
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
    func completeByToggle(id:UUID, on date:Date) async {
           guard let habitToChange = await getHabitById(id: id) else { return }
           let targetDay = Calendar.current.startOfDay(for: date)
           
           var logs = habitToChange.habitLogs ?? []
           
           // Now, instead of using 'habitToChange.habitLogs', we use our local 'logs' variable.
           if let logIndex = logs.firstIndex(where: { Calendar.current.isDate($0.completionDate, inSameDayAs: targetDay) }) {
               // IF A LOG EXISTS: The user is UNCHECKING the habit.
               habitToChange.habitIsCompleted = false
               
               // We remove the log from our local copy
               let logToDelete = logs.remove(at: logIndex)
               // and then delete it from the main context to persist the change.
               context.delete(logToDelete)
           } else {
               // IF NO LOG EXISTS: The user is CHECKING the habit.
               habitToChange.habitIsCompleted = true
               let newHabitLog = HabitLog(completionDate: targetDay)
               
               // We append the new log to our local copy.
               logs.append(newHabitLog)
           }
           
           habitToChange.habitLogs = logs
           
           try? context.save()
       }
       
    func completeByMultipleToggle(id: UUID, on date: Date) async {
           guard let habitToChange = await getHabitById(id: id) else { return }
           let targetDay = Calendar.current.startOfDay(for: date)
           
           // For a simple read operation like 'contains', using '?? []' directly is clean and safe.
           if (habitToChange.habitLogs ?? []).contains(where: { Calendar.current.isDate($0.completionDate, inSameDayAs: targetDay) }) {
               return
           }
           
           if habitToChange.howManyTimesItWasDone < habitToChange.howManyTimesToToggle {
               habitToChange.howManyTimesItWasDone += 1
           }
           
           if habitToChange.howManyTimesItWasDone == habitToChange.howManyTimesToToggle {
               var logs = habitToChange.habitLogs ?? []
               let newLog = HabitLog(completionDate: targetDay)
               
               logs.append(newLog)
               habitToChange.habitLogs = logs // Assign the modified array back
               
               habitToChange.habitIsCompleted = true
               try? context.save()
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
