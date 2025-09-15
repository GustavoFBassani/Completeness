//
//  Habit.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 10/09/25.
//

import Foundation
import SwiftData

@Model
final class Habit: Identifiable {
    var id: UUID
    var habitName: String
    var habitIsCompleted: Bool
    var habitCategory: Categories.RawValue
    var habitDescription: String
    var habitColor: String
    var habitRecurrence: String
    var habitSimbol: String
    var timestampHabit: Date
    var count: Int
    var habitCompleteness: CompletionHabit
    
    init(id: UUID = UUID(),
         habitName: String = "",
         habitIsCompleted: Bool = false,
         habitCategory: String = "",
         habitDescription: String = "",
         habitColor: String = "",
         habitRecurrence: String = "",
         habitSimbol: String = "",
         timestampHabit: Date = .now,
         habitCompleteness: CompletionHabit = .byToggle,
         count: Int = 0) {
        self.id = id
        self.habitName = habitName
        self.habitIsCompleted = habitIsCompleted
        self.habitCategory = habitCategory
        self.habitDescription = habitDescription
        self.habitColor = habitColor
        self.habitRecurrence = habitRecurrence
        self.habitSimbol = habitSimbol
        self.timestampHabit = timestampHabit
        self.count = count
        self.habitCompleteness = habitCompleteness
    }
}
