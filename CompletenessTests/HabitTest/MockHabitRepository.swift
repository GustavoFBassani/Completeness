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

    init(habitsToReturn: [Habit] = []){
        self.habitsToReturn = habitsToReturn
    }
    
    func getAllHabits() async throws -> [Habit] {
        if shouldThrowError == true {
            throw NSError(domain: "Test", code: 0, userInfo: nil)
        } else {
            return habitsToReturn
        }
    }

    func createHabit(habit: Habit)  {
        createHabitCalled = true
        lastCreatedHabit = habit
    }
    
    func getHabitById(id: UUID) async -> Habit? { return nil }
    func saveChanges() { }
    func deleteHabit(id: UUID) async { }
}
