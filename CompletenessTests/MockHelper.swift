//
//  MockHelper.swift
//  Completeness
//
//  Created by Vítor Bruno on 23/09/25.
//

import Foundation
@testable import Completeness

class MockHelper {
    static func setupMockData() -> [Habit] {
        let drinkWater = Habit( //most done
            habitName: "Drink Water",
            habitCompleteness: .byToggle,
            howManyTimesToToggle: 1,
            scheduleDays: []
        )
        
        let runInTheStreet = Habit(
            habitName: "Run in the street",
            habitCompleteness: .byToggle,
            howManyTimesToToggle: 1,
            scheduleDays: [2, 4, 6]
        )
        
        let studySwift = Habit( //leat done
            habitName: "Study Swift",
            habitCompleteness: .byMultipleToggle,
            howManyTimesToToggle: 2,
            scheduleDays: [3, 5]
        )
        
        for index in 0..<5 {
            let date = Calendar.current.date(byAdding: .day, value: -index, to: Date())!
            let log = HabitLog(completionDate: date, habit: drinkWater)
            drinkWater.habitLogs?.append(log)
        }
        
        for index in 0..<2 {
            let date = Calendar.current.date(byAdding: .day, value: -index, to: Date())!
            let log = HabitLog(completionDate: date, habit: runInTheStreet)
            runInTheStreet.habitLogs?.append(log)
        }
        
        
        let date = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        let log = HabitLog(completionDate: date, habit: studySwift)
        studySwift.habitLogs?.append(log)
        
        
        return [drinkWater, runInTheStreet, studySwift]
    }
}
