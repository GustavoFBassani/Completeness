//
//  HabitRepositoryProtocol.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 16/09/25.
//

import Foundation

protocol HabitRepositoryProtocol {
    func getAllHabits() async throws -> [Habit]
    func getHabitById(id: UUID) async -> Habit?
    func createHabit(habit: Habit)
    func saveChanges()
    func deleteHabit(id: UUID) async
}
