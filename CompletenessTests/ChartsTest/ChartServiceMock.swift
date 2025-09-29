//
//  ChartServiceMock.swift
//  CompletenessTests
//
//  Created by Vítor Bruno on 22/09/25.
//

@testable import Completeness
import Foundation
import SwiftData

class MockChartsService: ChartsServiceProtocol {
    func getNumberOfHabbitsCompleted(inLastDays days: Int) async -> Int {
        return 1
    }
    
    private var sampleHabits: [Habit] = []
    
    init() {
        sampleHabits = MockHelper.setupMockData()
    }
    
    func getMostCompletedHabits(inLastDays days: Int) async -> [Habit] {
        let sorted = sampleHabits.sorted {
            ($0.habitLogs?.count ?? 0) > ($1.habitLogs?.count ?? 0)
        }
        print("Mock: Retornando os hábitos mais completados.")
        return sorted
    }
    
    func getLeastCompletedHabit(inLastDays days: Int) async -> [Habit] {
        let sorted = sampleHabits.sorted {
            ($0.habitLogs?.count ?? 0) < ($1.habitLogs?.count ?? 0)
        }
        print("Mock: Retornando os hábitos menos completados.")
        return sorted
    }
    
    func getOverallCompletion(inLastDays days: Int) async -> Double {
        print("Mock: Retornando taxa de conclusão de 65%.")
        return 0.65
    }
}
