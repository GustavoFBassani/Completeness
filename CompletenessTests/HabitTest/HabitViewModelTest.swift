////
////  HabitTest.swift
////  CompletenessTests
////
////  Created by Vítor Bruno on 23/09/25.
////
//
//import Testing
//@testable import Completeness
//import Foundation
//
//struct HabitsViewModelTests {
//    var mockHabitRepo: MockHabitRepository!
//    var mockCompletionService: MockHabitCompletionRepository!
//    var viewModel: HabitsViewModel!
//
//    init() {
//        mockHabitRepo = MockHabitRepository()
//        mockCompletionService = MockHabitCompletionRepository()
//        viewModel = HabitsViewModel(
//            habitCompletionService: mockCompletionService,
//            habitService: mockHabitRepo
//        )
//    }
//    
//    @Test("Toggling a simple habit should add a log")
//    func testSimpleToggleCompletion() async {
//        let testDate = Date()
//        let habit = Habit(habitName: "Test Toggle", howManyTimesToToggle: 1, scheduleDays: [])
//        
//        viewModel.habits = [habit]
//        mockCompletionService.sampleHabits = [habit]
//
//        #expect(habit.isCompleted(on: testDate) == false)
//        
//        await viewModel.completeHabit(habit: habit, on: testDate)
//    
//        #expect(habit.isCompleted(on: testDate) == true)
//    }
//    
//    @Test("Toggling a multi-step habit should increment its counter")
//    func testMultiToggleIncrement() async {
//        let testDate = Date()
//        let habit = Habit(habitName: "Drink Water 3x", habitCompleteness: .byMultipleToggle, howManyTimesToToggle: 3, scheduleDays: [])
//        
//        viewModel.habits = [habit]
//        mockCompletionService.sampleHabits = [habit]
//        
//        #expect(habit.howManyTimesItWasDone == 0, "O contador inicial deve ser 0")
//        
//        await viewModel.completeHabit(habit: habit, on: testDate)
//        
//        #expect(habit.howManyTimesItWasDone == 1, "O contador deve ser 1 após o primeiro toque")
//        #expect(habit.isCompleted(on: testDate) == false, "O hábito ainda não deve estar completo")
//        
//        await viewModel.completeHabit(habit: habit, on: testDate)
//        await viewModel.completeHabit(habit: habit, on: testDate)
//        
//        #expect(habit.howManyTimesItWasDone == 3, "O contador deve ser 3 após o terceiro toque")
//        #expect(habit.isCompleted(on: testDate) == true, "O hábito agora deve estar completo")
//    }
//}
