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
    var timestampHabit = Date()
    var habitCompleteness: CompletionHabit?

    var howManyTimesToToggle = 1
    var howManyTimesItWasDone = 0

    init(id: UUID = UUID(),
         habitName: String = "",
         habitIsCompleted: Bool = false,
         habitCategory: String = "",
         habitDescription: String = "",
         habitColor: String = "",
         habitRecurrence: String = "",
         habitSimbol: String = "",
         timestampHabit: Date = .now,
         habitCompleteness: CompletionHabit? = .byToggle,
         howManyTimesToToggle: Int,
         howManyTimesItWasDone: Int = 0) {
        self.id = id
        self.habitName = habitName
        self.habitIsCompleted = habitIsCompleted
        self.habitCategory = habitCategory
        self.habitDescription = habitDescription
        self.habitColor = habitColor
        self.habitRecurrence = habitRecurrence
        self.habitSimbol = habitSimbol
        self.timestampHabit = timestampHabit
        self.habitCompleteness = habitCompleteness ?? .byToggle
        self.howManyTimesToToggle = howManyTimesToToggle
        self.howManyTimesItWasDone = howManyTimesItWasDone
    }
}
