//
//  ChartsService.swift
//  Completeness
//
//  Created by Vítor Bruno on 17/09/25.
//

import Foundation
import SwiftData

/// Provides the business logic for calculating statistics displayed in the charts.
///
/// This class is responsible for fetching raw data from SwiftData and transforming it
/// into useful information for the UI, such as "what are the most completed habits"
/// or "what is the overall completion rate".
class ChartsService: ChartsServiceProtocol {
    var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    /// Calculates and returns the most completed habits over a given period.
    /// - Parameter days: The number of days in the past to consider (e.g., 7 for the last week).
    /// - Returns: An array of `Habit` objects sorted from most to least completed.
    func getMostCompletedHabits(inLastDays days: Int) async -> [Habit] {
        guard let habits = await fetchAllHabbits() else { return [] }
        let today = Calendar.current.startOfDay(for: Date())
        
        // Define the start date for our filter.
        let startDate = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        
        // Sort the list of habits. The sorting logic is the core of this function.
        let sortedHabits = habits.sorted { (habit1, habit2) in
            // For each habit, we filter its logs to count only those that fall within the time period.
            
            if let habit1Logs = habit1.habitLogs, let habit2Logs = habit2.habitLogs {
                let count1 = habit1Logs.filter({$0.completionDate >= startDate && $0.completionDate <= today && $0.isCompleted}).count
                let count2 = habit2Logs.filter({ $0.completionDate >= startDate && $0.completionDate <= today && $0.isCompleted}).count
                
                // The 'count1 > count2' comparison sorts the list in descending order (from highest to lowest).
                return count1 > count2
            }
            
            return false
        }
        
        return sortedHabits
    }
    
    /// Calculates and returns the least completed habits over a given period.
    /// The logic is identical to 'getMostCompletedHabits', only changing the sort direction.
    func getLeastCompletedHabit(inLastDays days: Int) async -> [Habit] {
        guard let habits = await fetchAllHabbits() else { return [] }
        let today = Calendar.current.startOfDay(for: Date())
        let startDate = Calendar.current.date(byAdding: .day, value: -days, to: Date()) ?? Date()
        
        let sortedHabits = habits.sorted { (habit1, habit2) in
            if let habit1Logs = habit1.habitLogs, let habit2Logs = habit2.habitLogs {
                let count1 = habit1Logs.filter({$0.completionDate >= startDate && $0.completionDate <= today && $0.isCompleted}).count
                let count2 = habit2Logs.filter({$0.completionDate >= startDate && $0.completionDate <= today && $0.isCompleted}).count
                
                // The 'count1 < count2' comparison sorts the list in ascendin order (from lowest to highest).
                return count1 < count2
            }
            
            return false
        }
        
        return sortedHabits
    }
    
    /// Calculates the percentage of "perfect days" ONLY among days with recorded activity.
    /// - Parameter days: The period to analyze.
    /// - Returns: A `Double` representing the percentage (e.g., 80.0 for 80%).
    func getOverallCompletion(inLastDays days: Int) async -> Double {
        guard let allHabits = await fetchAllHabbits(), !allHabits.isEmpty else { return 0.0 }
            let habitsCount = allHabits.count
            
            let today = Calendar.current.startOfDay(for: Date())
            guard let startDate = Calendar.current.date(byAdding: .day, value: -days, to: today) else { return 0.0 }
            
            let predicate = #Predicate<HabitLog> { log in
                log.completionDate >= startDate && log.completionDate <= today && log.isCompleted == true
            }
            let descriptor = FetchDescriptor<HabitLog>(predicate: predicate)
            let periodLogs = (try? modelContext.fetch(descriptor)) ?? []
            
            let totalCompletions = periodLogs.count
            let totalPossibleCompletion = habitsCount * days
            
            return (Double(totalCompletions) / Double(totalPossibleCompletion)) * 100
    }
    
    ///get the count of the logs that are among in the parameters
    /// - Parameter days: The period to analyze.
    /// - Returns: A `Int` representing the total of habits marked as done.
    func getNumberOfHabbitsCompleted(inLastDays days: Int)  async -> Int{
        guard let allHabits = await fetchAllHabbits(), !allHabits.isEmpty else { return 0}
        
        let today = Calendar.current.startOfDay(for: Date())
        let startDate = Calendar.current.date(byAdding: .day, value: -days, to: today)!
        
        let predicate = #Predicate<HabitLog> { log in
            log.completionDate >= startDate && log.completionDate <= today && log.isCompleted == true
        }
        let descriptor = FetchDescriptor<HabitLog>(predicate: predicate)
        let periodLogs = (try? modelContext.fetch(descriptor)) ?? []
        
        let totalCompletions = periodLogs.count
        
        return totalCompletions
    }
    
    ///get the count of the habits
    /// - Parameter ()
    /// - Returns: A `Int` representing the total of habits.
    func getNumberOfHabbits(inLastDays days: Int) async -> Int {
        guard let allHabits = await fetchAllHabbits(), !allHabits.isEmpty else { return 0}
        
        return allHabits.count
    }
    
    // The functions below are private helpers to avoid code repetition.
    private func fetchAllHabbits() async -> [Habit]? {
        let descriptor = FetchDescriptor<Habit>()
        return try? modelContext.fetch(descriptor)
    }
    
    private func fetchAllHabbitsLogs() async -> [HabitLog]? {
        let descriptor = FetchDescriptor<HabitLog>()
        return try? modelContext.fetch(descriptor)
    }
}
