//
//  HabitsCompletionProtocol.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 16/09/25.
//

import Foundation

protocol HabitCompletionProtocol {
    func getAllHabits() throws -> [Habit]
    func getHabitById(id: UUID) -> Habit?
    func completeByToggle(id: UUID)
    func completeByMultipleToggle(id: UUID)
    func completeWithTimer(id: UUID, after seconds: TimeInterval)
}
