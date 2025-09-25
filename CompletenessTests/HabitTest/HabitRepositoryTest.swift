//
//  HabitRepositoryTest.swift
//  Completeness
//
//  Created by Vítor Bruno on 23/09/25.
//

import Testing
import SwiftData
@testable import Completeness

struct HabitRepositoryTests {
    var modelContext: ModelContext
    var repository: HabitRepository

    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Habit.self, configurations: config)
        modelContext = ModelContext(container)
        repository = HabitRepository(context: modelContext)
    }

    @Test("createHabit should save a habit to the database")
    func testCreateHabit() throws {
        let newHabit = Habit(habitName: "Habit", howManyTimesToToggle: 1, scheduleDays: [])
        repository.createHabit(habit: newHabit)
        let fetchedHabits = try modelContext.fetch(FetchDescriptor<Habit>())
        
        #expect(fetchedHabits.count == 1)
        #expect(fetchedHabits.first?.habitName == "Habit")
    }

    @Test("deleteHabit should remove the habit from the database")
    func testDeleteHabit() async throws {
        let habitToDelete = Habit(habitName: "habit ot delete", howManyTimesToToggle: 1, scheduleDays: [])
        repository.createHabit(habit: habitToDelete)
        #expect((try await repository.getAllHabits()).count == 1)
        
        await repository.deleteHabit(id: habitToDelete.id)
    
        let allHabits = try await repository.getAllHabits()
        #expect(allHabits.isEmpty == true)
    }
}
