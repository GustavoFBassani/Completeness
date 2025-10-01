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
    
    // Flags de chamadas
    var completeByToggleCalled = false
    var completeByMultipleToggleCalled = false
    var completeByTimerCalled = false
    
    init(habits: [Habit] = MockHelper.setupMockData()) {
        self.sampleHabits = habits
    }
    
    func getAllHabits() async throws -> [Habit] {
        return sampleHabits
    }
    
    func getHabitById(id: UUID) async -> Habit? {
        return sampleHabits.first { $0.id == id }
    }
    
    func completeByToggle(id: UUID, on date: Date) async {
        completeByToggleCalled = true
        // ... (pode manter ou simplificar a lógica dos logs)
    }
    
    func completeByMultipleToggle(id: UUID, on date: Date) async {
        completeByMultipleToggleCalled = true
        // ... (tua lógica atual dos logs)
    }
    
    func completeByTimer(id: UUID, on date: Date) async {
        completeByTimerCalled = true
    }
    
    func completeToggleAndMultipleToggleAutomatic(id: UUID, on date: Date) async {}
    func decreaseHabitStep(id: UUID, on date: Date) async {}
    func restartHabitTimer(id: UUID, on date: Date) async {}
}
