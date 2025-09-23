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
    var scheduleDays: [Int] = []
    var howManyTimesItWasDone = 0
    
    /// A one-to-many relationship to all historical completion records for this habit.
    /// `deleteRule: .cascade` ensures that when a Habit is deleted, all its associated logs are also deleted,
    /// maintaining data integrity.
    @Relationship(deleteRule: .cascade) var habitLogs: [HabitLog]? = []
    
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
         scheduleDays: [Int],
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
        self.scheduleDays = scheduleDays
    }
    
    func isScheduled(for date: Date) -> Bool {
        //if the array is empty, then its for everyday
        if self.scheduleDays.isEmpty {
            return true
        }
        
        // Pega o componente 'weekday' da data (1 para Domingo, 2 para Segunda, etc.)
        let weekday = Calendar.current.component(.weekday, from: date)
        
        // Retorna true se a lista contém o dia da semana da data.
        return scheduleDays.contains(weekday)
    }
    
    func isCompleted(on date: Date) -> Bool {
        let targetDay = Calendar.current.startOfDay(for: date)
        //if there is a log in the same date as in the parameter, then its completed
        return (self.habitLogs ?? []).contains { log in
            let logDay = Calendar.current.startOfDay(for: log.completionDate)
            return logDay == targetDay
        }
    }
}
