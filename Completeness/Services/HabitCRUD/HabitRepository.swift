//
//  PersistenceService.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
/// Service responsible for managing habit persistence.
/// Centralizes create, edit, and delete operations
/// using the SwiftData `ModelContext`.

import SwiftData
import Foundation

class HabitRepository: HabitRepositoryProtocol {
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func getAllHabits() throws -> [Habit] {
        let descriptor = FetchDescriptor<Habit>()
        do {
            let allHabits: [Habit] = try context.fetch(descriptor)
            return allHabits
        } catch {
            print("error to catch Habits")
        }
        return []
    }
    
    func getHabitById(id: UUID) -> Habit? {
        try? getAllHabits().first {$0.id == id }
    }
    
    func createHabit(habit: Habit) {
        let newHabit = Habit(id: habit.id,
                             habitName: habit.habitName,
                             habitIsCompleted: habit.habitIsCompleted,
                             habitCategory: habit.habitCategory,
                             habitDescription: habit.habitDescription,
                             habitColor: habit.habitColor,
                             habitRecurrence: habit.habitRecurrence,
                             habitSimbol: habit.habitSimbol,
                             timestampHabit: habit.timestampHabit,
                             habitCompleteness: habit.habitCompleteness,
                             howManyTimesToToggle: habit.howManyTimesToToggle
        )
        
        context.insert(newHabit)
        do {
            try context.save()
        } catch {
            debugPrint(error)
            fatalError()
        }
    }
    
    func editHabit() {
        //edit habits
    }
    
    func deleteHabit() {
        //delete habits
    }
}
