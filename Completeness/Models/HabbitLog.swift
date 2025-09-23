//
//  HabbitLog.swift
//  Completeness
//
//  Created by Vítor Bruno on 17/09/25.
//

import Foundation
import SwiftData

/// Represents a single, historical record of a habit's completion on a specific date.
///
/// Each time a user marks a habit as "done" on a given day, an instance of `HabitLog`
/// is created. This model is the source of truth for all analytics and statistics.
@Model
final class HabitLog: Identifiable {
    /// The unique identifier for this specific log entry.
    var id = UUID()
    
    /// The date on which the habit was completed.
    var completionDate = Date()
    
    /// A boolean indicating the status of the completion (typically always true).
    var isCompleted = true
    
    /// A many-to-one relationship back to the parent `Habit` this log belongs to.
    /// This is the inverse of the `habitLogs` relationship in the `Habit` model.
    var habit: Habit?
    
    init(completionDate: Date, isCompleted: Bool = true, habit: Habit? = nil) {
        // By normalizing the date to the start of the day, we ensure that all logs
        // for a given calendar day are treated equally, regardless of the time they were created.
        // This is crucial for accurate daily statistics.
        self.completionDate = Calendar.current.startOfDay(for: completionDate)
        self.isCompleted = isCompleted
        self.habit = habit
    }
}
