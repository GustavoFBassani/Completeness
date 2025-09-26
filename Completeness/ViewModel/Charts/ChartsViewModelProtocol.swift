//
//  ChartsViewModelProtocol.swift
//  Completeness
//
//  Created by Vítor Bruno on 18/09/25.
//

import Foundation

protocol ChartsViewModelProtocol: Observable {
    var isLoading: Bool { get }
    var overallCompletionRate: Double { get }
    var mostCompletedHabits: [Habit] { get }
    var leastCompletedHabits: [Habit] { get }
    var totalHabitsCompleted: Int { get }
    func fetchChartBy7Days() async
}
