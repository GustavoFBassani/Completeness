//
//  PersistenceService.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
/// Service responsible for managing habit persistence.
/// Centralizes create, edit, and delete operations
/// using the SwiftData `ModelContext`.

import SwiftData

class PersistenceService {
    let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func createHabit() {
    }
    
    func editHabit() {
    }
    
    func deleteHabit() {
    }
}
