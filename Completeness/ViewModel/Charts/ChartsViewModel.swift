//
//  ChartsViewModel.swift
//  Completeness
//
//  Created by Vítor Bruno on 17/09/25.
//

import Foundation
import SwiftData

/// Acts as the bridge between the analytics logic (`ChartsService`) and the chart views (UI).
///
/// Following the MVVM architecture, this ViewModel fetches, holds, and formats the data
/// required by the charts screen. The `@Observable` macro automatically notifies any
/// listening SwiftUI view when its properties change, triggering a UI update.
@Observable
class ChartsViewModel: ChartsViewModelProtocol {
    /// A flag to indicate when a data fetch operation is in progress.
    /// The UI can use this to show a loading indicator (e.g., ProgressView).
    var isLoading = false
    
    /// A reference to the service layer that contains the business logic for chart calculations.
    /// This dependency is injected to promote loose coupling and testability.
    var chartsService: ChartsServiceProtocol
    
    // MARK: - Published State Properties
    // These properties hold the state of the view. When they are updated, the UI automatically reflects the new values.
    
    /// The calculated overall completion rate over the specified period.
    var overallCompletionRate = 0.0
    
    /// A list of the most frequently completed habits.
    var mostCompletedHabits: [Habit] = []
    
    /// A list of the least frequently completed habits.
    var leastCompletedHabits: [Habit] = []
    
    var totalHabitsCompleted = 0
    
    init(chartsService: ChartsServiceProtocol) {
        self.chartsService = chartsService
    }
    
    /// The primary method for fetching all analytics data for the last 7 days.
    ///
    /// This function is marked as `async` to perform its work without blocking the main thread,
    /// ensuring the UI remains responsive. It updates all the published properties with the
    /// latest data from the `ChartsService`.
    func fetchChartBy7Days() async {
        isLoading = true
        
        // Asynchronously call the service methods to get the calculated data.
        // For enhanced performance, these could be run concurrently using a TaskGroup or async let.
        mostCompletedHabits = await chartsService.getMostCompletedHabits(inLastDays: 7)
        leastCompletedHabits = await chartsService.getLeastCompletedHabit(inLastDays: 7)
        overallCompletionRate = await chartsService.getOverallCompletion(inLastDays: 7)
        totalHabitsCompleted = await chartsService.getNumberOfHabbitsCompleted(inLastDays: 7)
        
        isLoading = false
    }
}
