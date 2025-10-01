//
//  HabitsCompletionProtocol.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 16/09/25.
//

import Foundation

protocol HabitCompletionProtocol {
    func getAllHabits() async throws -> [Habit]
    func getHabitById(id: UUID) async -> Habit?
    func completeByToggle(id: UUID, on date: Date) async
    func completeByMultipleToggle(id: UUID, on date: Date) async
    func completeByTimer(id: UUID, on date: Date) async
    func completeToggleAndMultipleToggleAutomatic(id: UUID, on date: Date)  async
    func isHabbitRunning(with id: UUID) -> Bool
    func decreaseHabitStep(id: UUID, on date: Date) async
    func restartHabitTimer(id: UUID, on date: Date) async
    func deleteHabit(id: UUID) async
}
