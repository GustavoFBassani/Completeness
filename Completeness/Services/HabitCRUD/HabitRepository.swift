//
//  PersistenceService.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
/// Service responsible for managing habit persistence.
/// Centralizes create, edit, and delete operations
/// using the SwiftData `ModelContext`.

import SwiftData
import Foundation

class HabitRepository: HabitRepositoryProtocol {    
    let context: ModelContext
    init(context: ModelContext) {
        self.context = context
    }
    
    func getAllHabits() async throws -> [Habit] {
        let descriptor = FetchDescriptor<Habit>()
        do {
            let allHabits: [Habit] = try context.fetch(descriptor)
            return allHabits
        } catch {
            print("error to catch Habits")
        }
        return []
    }
    
    func getHabitById(id: UUID) async -> Habit? {
        let predicate = #Predicate<Habit> { $0.id == id }
        let descriptor = FetchDescriptor(predicate: predicate)
        return (try? context.fetch(descriptor))?.first
    }
    
    func createHabit(habit: Habit) async {
        context.insert(habit)
        do {
            try context.save()
        } catch {
            debugPrint(error)
            fatalError()
        }
    }
    
    func saveChanges() {
        try? context.save()
    }
    
    // MARK: - Slot Conflict Validation
    func hasSlotConflict(valuePosition: Int,
                         indicePosition: Int,
                         scheduleDays: [Int],
                         excludingHabitID: UUID?) async -> Bool {
        // Busca todos os hábitos no mesmo slot (linha/coluna)
        let predicate = #Predicate<Habit> {
            $0.valuePosition == valuePosition && $0.indicePosition == indicePosition
        }
        let descriptor = FetchDescriptor<Habit>(predicate: predicate)
        let habitsAtSlot = (try? context.fetch(descriptor)) ?? []
        
        // Considera "todos os dias" se o array estiver vazio ou se contiver todos os 7 dias
        let newDaysSet = Set(scheduleDays)
        let isNewEveryday = scheduleDays.isEmpty || newDaysSet == Set(1...7)
        
        for existing in habitsAtSlot {
            if let excludingHabitID, existing.id == excludingHabitID {
                continue
            }
            
            let existingSet = Set(existing.scheduleDays)
            let isExistingEveryday = existing.scheduleDays.isEmpty || existingSet == Set(1...7)
            
            // Se qualquer um for "todos os dias", há conflito
            if isNewEveryday || isExistingEveryday {
                return true
            }
            
            // Se houver interseção de dias, há conflito
            if !existingSet.isDisjoint(with: newDaysSet) {
                return true
            }
        }
        
        return false
    }
}

