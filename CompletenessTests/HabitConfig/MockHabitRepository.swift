//
//  HabitServiceMock.swift
//  Completeness
//
//  Created by Vítor Bruno on 22/09/25.
//

import Foundation
@testable import Completeness

class MockHabitRepository: HabitRepositoryProtocol {
    var habitsToReturn: [Habit]
    var createHabitCalled = false
    var saveChangesCalled = false
    var lastCreatedHabit: Habit?
    
    var shouldThrowError = false
    
    var deleteHabitCalled = false
    var deleteHabitCalledWithId: UUID?
    var getHabitByIdToReturn: Habit?
    
    init(habitsToReturn: [Habit] = []) {
        self.habitsToReturn = habitsToReturn
    }
    
    func getAllHabits() async throws -> [Habit] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 0)
        }
        return habitsToReturn
    }
    
    func createHabit(habit: Completeness.Habit) async {
        createHabitCalled = true
        lastCreatedHabit = habit
        habitsToReturn.append(habit)
    }
    
    func getHabitById(id: UUID) async -> Habit? {
        return habitsToReturn.first { $0.id == id }
    }
    
    func saveChanges() {
        saveChangesCalled = true
    }
    
    func deleteHabit(id: UUID) async {
        deleteHabitCalled = true
        deleteHabitCalledWithId = id
        habitsToReturn.removeAll { $0.id == id }
    }
}
