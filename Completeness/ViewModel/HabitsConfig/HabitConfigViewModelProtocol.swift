//
//  HabitConfigViewModelProtocol.swift
//  Completeness
//
//  Created by Vítor Bruno on 01/10/25.
//

import Foundation

protocol HabitConfigViewModelProtocol {
    var habitName: String { get set }
        var newHabitDescription: String { get set }
        var selectedDays: [Int] { get set }
        var habitsSymbol: String { get set }
        var completenessType: CompletionHabit { get set }
        var howManyTimesToComplete: Int { get set }
        var timesChoice: Int { get set } 
        
        func createNewHabit() async -> Bool
        func deleteHabitById() async
        func toggleSelection(for day: Int)
}
