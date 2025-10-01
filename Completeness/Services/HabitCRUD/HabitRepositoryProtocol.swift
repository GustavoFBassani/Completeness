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
    func createHabit(habit: Habit) async
    func saveChanges()

    /// Verifica se existe conflito de slot (posição) e dias com hábitos já existentes.
    /// - Parameters:
    ///   - valuePosition: Linha (row) do slot.
    ///   - indicePosition: Coluna (column) do slot.
    ///   - scheduleDays: Dias do novo hábito. Consideramos "todos os dias" quando vazio ou [1...7].
    ///   - excludingHabitID: Opcional, para ignorar um hábito específico (útil em edição).
    /// - Returns: true se houver conflito; false caso contrário.
    func hasSlotConflict(valuePosition: Int,
                         indicePosition: Int,
                         scheduleDays: [Int],
                         excludingHabitID: UUID?) async -> Bool
}

