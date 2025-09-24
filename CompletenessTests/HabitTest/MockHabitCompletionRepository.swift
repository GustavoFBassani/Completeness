//
//  MockHabitCompletionRepository.swift
//  Completeness
//
//  Created by Vítor Bruno on 22/09/25.
//

import Foundation
@testable import Completeness

class MockHabitCompletionRepository: HabitCompletionProtocol {
    var sampleHabits: [Habit]

    init(sampleHabits: [Habit] = []) {
        self.sampleHabits = sampleHabits
    }
    
    func getAllHabits() async throws -> [Habit] {
        return sampleHabits
    }
    
    func getHabitById(id: UUID) async -> Habit? {
        return sampleHabits.first(where: { $0.id == id })
    }
    
    func completeByToggle(id: UUID, on date: Date) async {
        guard let habitToChange = await getHabitById(id: id) else { return }
        let targetDay = Calendar.current.startOfDay(for: date)
        
        var logs = habitToChange.habitLogs ?? []
        
        if let logIndex = logs.firstIndex(where: { Calendar.current.isDate($0.completionDate, inSameDayAs: targetDay) }) {
            logs.remove(at: logIndex)
            print("Mock: Log removido para o hábito '\(habitToChange.habitName)'")
        } else {
            let newLog = HabitLog(completionDate: targetDay, habit: habitToChange)
            logs.append(newLog)
            print("Mock: Log adicionado para o hábito '\(habitToChange.habitName)'")
        }
    
        habitToChange.habitLogs = logs
    }
    
    func completeByMultipleToggle(id: UUID, on date: Date) async {
        guard let habitToChange = await getHabitById(id: id) else { return }
        
        if habitToChange.isCompleted(on: date) { return }
        
        habitToChange.howManyTimesItWasDone += 1
        print("Mock: Contador do hábito '\(habitToChange.habitName)' incrementado para \(habitToChange.howManyTimesItWasDone)")

        if habitToChange.howManyTimesItWasDone >= habitToChange.howManyTimesToToggle {
            let newLog = HabitLog(completionDate: date, habit: habitToChange)
            habitToChange.habitLogs?.append(newLog)
            print("Mock: Hábito '\(habitToChange.habitName)' totalmente concluído.")
        }
    }
}
