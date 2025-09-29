//
//  HabitRepositoryFactory.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 28/09/25.
//

import SwiftData

// Protocolo da factory (optional, good if we are going to test it later)
protocol HabitRepositoryFactoryProtocol {
    func makeHabitRepository() -> HabitRepository
}

// Factory
struct HabitRepositoryFactory: HabitRepositoryFactoryProtocol {
    let context: ModelContext
    
    func makeHabitRepository() -> HabitRepository {
        HabitRepository(context: context)
    }
}
