//
//  ChartsServiceProtocol.swift
//  Completeness
//
//  Created by Vítor Bruno on 18/09/25.
//

/// Defines the interface for a service that provides chart-related analytics.
///
/// By depending on this protocol instead of a concrete class, our ViewModels
/// become more testable and decoupled from the implementation details of the data layer.
protocol ChartsServiceProtocol {
        /// Calculates and returns the most completed habits over a given period.
        func getMostCompletedHabits(inLastDays days: Int) async -> [Habit]
        
        /// Calculates and returns the least completed habits over a given period.
        func getLeastCompletedHabit(inLastDays days: Int) async -> [Habit]
        
        /// Calculates the percentage of "perfect days".
        func getOverallCompletion(inLastDays days: Int) async -> Double
}
