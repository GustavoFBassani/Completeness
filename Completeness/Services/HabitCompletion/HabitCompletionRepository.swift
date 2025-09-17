//
//  HabitTrackerService.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
//
/// Repository responsible for handling habit completion logic.
/// Provides different strategies to mark habits as completed,
/// such as toggle, batch toggle, or timer-based completion.
import SwiftData
import Foundation

class HabitCompletionRepository: HabitCompletionProtocol {
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
    
    func completeByToggle(id: UUID) {
        let habitToChange = getHabitById(id: id)
        habitToChange?.habitIsCompleted.toggle()
        try? context.save()
    }
    
    func completeByMultipleToggle(id: UUID) {
        let habitToChange = getHabitById(id: id)
        if let habitToChange {
            if habitToChange.howManyTimesToToggle >= habitToChange.howManyTimesItWasDone {
                habitToChange.howManyTimesItWasDone += 1
            } else {
                habitToChange.habitIsCompleted.toggle()
                try? context.save()
            }
        }
    }
    
    func completeWithTimer(id: UUID, after seconds: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds ) {
            let habitToChange = self.getHabitById(id: id)
            habitToChange?.habitIsCompleted.toggle()
            try? self.context.save()
        }
    }
}
