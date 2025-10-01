import Foundation
import Testing
@testable import Completeness

struct HabitConfigViewModelTests {
    var mockHabitRepo: MockHabitRepository!
    
    init() {
        mockHabitRepo = MockHabitRepository()
    }
    
    // --- TESTE DE CRIAÇÃO ---
    @Test("createNewHabit should call createHabit on service when id is nil")
    mutating func testCreateMode() async {
        // Arrange
        // Usamos o init que aceita um protocolo, garantindo a compatibilidade.
        let viewModel = HabitConfigViewModel(
            id: nil,
            habitRowPosition: 1,
            habitColunmPosition: 1,
            habitService: mockHabitRepo
        )
        viewModel.habitName = "Novo Hábito de Teste"
        viewModel.selectedDays = [2, 4, 6]
        
        // Act
        await viewModel.createNewHabit()
        
        // Assert
        #expect(mockHabitRepo.createHabitCalled == true)
        #expect(mockHabitRepo.lastCreatedHabit?.habitName == "Novo Hábito de Teste")
        #expect(mockHabitRepo.saveChangesCalled == false)
    }
    
    @Test("createNewHabit should update habit and call saveChanges when editing")
    mutating func testEditMode() async {
        let existingHabit = Habit(habitName: "Old name", howManyTimesToToggle: 1, scheduleDays: [])
        
        #expect(existingHabit.habitName == "Old name", "first atribution should have worked")
        
        mockHabitRepo = MockHabitRepository(habitsToReturn: [existingHabit])
        
        let viewModel = HabitConfigViewModel(
            id: existingHabit.id,
            habitRowPosition: 1,
            habitColunmPosition: 1,
            habitService: mockHabitRepo
        )
        
        viewModel.habitName = "New name"
        viewModel.selectedDays = [2, 4]
        
        await viewModel.createNewHabit()
        #expect(existingHabit.habitName == "New name", "Habit name should be updated")
        #expect(existingHabit.scheduleDays == [2, 4], "Habit schedule should have been updated")
        #expect(mockHabitRepo.saveChangesCalled == true, "func saveChanges should have been called")
        #expect(mockHabitRepo.createHabitCalled == false, "func createHabit should not have been called")
    }
    
    @Test("deleteHabitById should call delete on the service")
    mutating func testDelete() async {
        let habitIdToDelete = UUID()
        let viewModel = HabitConfigViewModel(id: habitIdToDelete, habitRowPosition: 0, habitColunmPosition: 0, habitService: mockHabitRepo)
        
        await viewModel.deleteHabitById()
        
        #expect(mockHabitRepo.deleteHabitCalledWithId == habitIdToDelete)
        #expect(viewModel.id == nil)
    }
}
