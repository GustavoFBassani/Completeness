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
    var id = UUID()
    var habitName: String
    var habitIsCompleted = false
    var habitCategory: Categories.RawValue
    var habitDescription: String
    var habitColor: String
    var habitRecurrence: String
    var habitSimbol: String
    var habitCompleteness: String
    
    var timestampHabit: Date


    init(id: UUID,
         habitName: String,
         habitIsCompleted: Bool,
         habitCategory: String,
         habitDescription: String,
         habitColor: String,
         habitRecurrence: String,
         habitSimbol: String,
         habitCompleteness: String,
         timestampHabit: Date) {
        self.id = id
        self.habitName = habitName
        self.habitIsCompleted = habitIsCompleted
        self.habitCategory = habitCategory
        self.habitDescription = habitDescription
        self.habitColor = habitColor
        self.habitRecurrence = habitRecurrence
        self.habitSimbol = habitSimbol
        self.habitCompleteness = habitCompleteness
        self.timestampHabit = timestampHabit
    }
}
