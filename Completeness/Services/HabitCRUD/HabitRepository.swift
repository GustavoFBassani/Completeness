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
    
    func getAllHabits() async throws -> [Habit] {
        let descriptor = FetchDescriptor<Habit>()
        do {
            let allHabits: [Habit] = try context.fetch(descriptor)
            return allHabits
        } catch {
            print("error to catch Habits")
        }
        return []
    }
    func getHabitById(id: UUID) async -> Habit? {
        try? await getAllHabits().first {$0.id == id }
    }
    func createHabit(habit: Habit) {
        context.insert(habit)
        do {
            try context.save()
        } catch {
            debugPrint(error)
            fatalError()
        }
    }
    func saveChanges() {
        try? context.save()
    }
    func deleteHabit(id: UUID) async {
        if let habitToDelete = await getHabitById(id: id) {
            context.delete(habitToDelete)
            try? context.save()
        }
    }
}
