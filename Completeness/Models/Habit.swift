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
    var habitName = ""
    var habitIsCompleted = false
    var habitCategory: Categories.RawValue = ""
    var habitDescription = ""
    var habitColor = ""
    var habitRecurrence = ""
    var habitSimbol = ""
    var habitCompleteness = ""
    
    var timestampHabit = Date.now


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
