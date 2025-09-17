//
//  HabitRepositoryProtocol.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 16/09/25.
//

import Foundation

protocol HabitRepositoryProtocol {
    func getAllHabits() throws -> [Habit]
    func getHabitById(id: UUID) -> Habit?
    func createHabit(habit: Habit)
    func editHabit()
    func deleteHabit()
}
