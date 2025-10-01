//
//  HabitsConfigVMFactory.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 28/09/25.
//

import Foundation

struct HabitsConfigVMFactory {
    let repositoryFactory: HabitRepositoryFactory
    let completitionFactory: HabitCompletitionFactory
    
    func createPredefinedHabits(habitName: String,
                                habitsSymbol: String,
                                completenessType: CompletionHabit,
                                habitRowPosition: Int,
                                habitColunmPosition: Int) -> HabitConfigViewModel {
        return HabitConfigViewModel(habitName: habitName,
                                    habitsSymbol: habitsSymbol,
                                    completenessType: completenessType,
                                    habitRowPosition: habitRowPosition,
                                    habitColunmPosition: habitColunmPosition,
                                    habitService: repositoryFactory.makeHabitRepository(),
                                    habitCompletition: completitionFactory.makeHabitRepository())
    }
    
    func createPersonalizedHabits(rowPosition: Int, colunmPosition: Int) -> HabitConfigViewModel {
        return HabitConfigViewModel(habitRowPosition: rowPosition,
                                    habitColunmPosition: colunmPosition,
                                    habitService: repositoryFactory.makeHabitRepository(),
                                    habitCompletition: completitionFactory.makeHabitRepository())
    }
    
    func editHabits(habitName: String,
                    scheduleDays: [Int],
                    habitSimbol: String,
                    habitCompleteness: CompletionHabit?,
                    howManySecondsToComplete: Int,
                    howManyTimesToToggle: Int,
                    habitDescription: String) -> HabitConfigViewModel {
                      return HabitConfigViewModel(habitName: habitName,
                                                     selectedDays: scheduleDays,
                                                     habitsSymbol: habitSimbol,
                                                     completenessType: habitCompleteness ?? .byToggle,
                                                     timesChoice: howManySecondsToComplete,
                                                     howManyTimesToComplete: howManyTimesToToggle,
                                                     habitService: repositoryFactory.makeHabitRepository(),
                                                  newHabitDescription: habitDescription,
                                                  habitCompletition: completitionFactory.makeHabitRepository())
    }
}
