//
//  ChartsTest.swift
//  CompletenessTests
//
//  Created by Vítor Bruno on 22/09/25.
//

import Foundation
import Testing
@testable import Completeness

struct ChartsTest {
    @Test
    func testHabitStats() async {
        let viewModel = ChartsViewModel(chartsService: MockChartsService())
        
        await viewModel.fetchChartBy7Days()
        
        #expect(viewModel.mostCompletedHabits.first?.habitName == "Drink Water")
        #expect(viewModel.leastCompletedHabits.first?.habitName == "Study Swift")
        #expect(viewModel.overallCompletionRate == 0.65)
    }
}
