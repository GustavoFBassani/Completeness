//
//  HabitConfigViewModel.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 27/09/25.
//

import Foundation

@Observable
class HabitConfigViewModel {
    // MARK: HABIT - INFO
//    var habits: [Habit] = []
    var id: UUID?
    var habitName = ""
    var selectedDays: [Int] = []
    var habitsSymbol = "checkmark.circle.fill"
    var newHabitDescription = ""
    //how to complete the habit
    var completenessType = CompletionHabit.byToggle
    var timesChoice = 0
    var howManyTimesToComplete = 1
    //habbit position (if needed)
    var habitRowPosition = 0
    var habitColunmPosition = 0
    var newHabitDate = Date()
    
    // UI feedback
    var showSlotConflictAlert = false
    var conflictMessage = ""
    
    // services
    var habitService: HabitRepositoryProtocol

    // MARK: - INITS
    //create new Habit Predefined
    init(habitName: String,
         habitsSymbol: String,
         completenessType: CompletionHabit,
         habitRowPosition: Int,
         habitColunmPosition: Int,
         habitService: HabitRepository) {
        self.habitName = habitName
        self.habitsSymbol = habitsSymbol
        self.completenessType = completenessType
        self.habitRowPosition = habitRowPosition
        self.habitColunmPosition = habitColunmPosition
        self.habitService = habitService
    }
    
    //create personalized habits
    init(habits: [Habit] = [],
         id: UUID? = nil,
         habitName: String = "",
         selectedDays: [Int] = [],
         habitsSymbol: String = "checkmark.circle",
         newHabitDescription: String = "",
         completenessType: CompletionHabit = .byToggle,
         timesChoice: Int = 0,
         howManyTimesToComplete: Int = 1,
         habitRowPosition: Int,
         habitColunmPosition: Int,
         newHabitDate: Date = Date(),
         habitService: HabitRepositoryProtocol) {
//        self.habits = habits
        self.id = id
        self.habitName = habitName
        self.selectedDays = selectedDays
        self.habitsSymbol = habitsSymbol
        self.newHabitDescription = newHabitDescription
        self.completenessType = completenessType
        self.timesChoice = timesChoice
        self.howManyTimesToComplete = howManyTimesToComplete
        self.habitRowPosition = habitRowPosition
        self.habitColunmPosition = habitColunmPosition
        self.newHabitDate = newHabitDate
        self.habitService = habitService
    }

    
    //edit an habit
    init(habitName: String,
         selectedDays: [Int],
         habitsSymbol: String,
         completenessType: CompletionHabit,
         timesChoice: Int,
         howManyTimesToComplete: Int,
         habitRow: Int = 0,
         habitColunm: Int = 0,
         habitService: HabitRepository,
         newHabitDescription: String) {
        self.habitName = habitName
        self.selectedDays = selectedDays
        self.habitsSymbol = habitsSymbol
        self.completenessType = completenessType
        self.timesChoice = timesChoice
        self.howManyTimesToComplete = howManyTimesToComplete
        self.habitRowPosition = habitRow
        self.habitColunmPosition = habitColunm
        self.habitService = habitService
        self.newHabitDescription = newHabitDescription
    }
    
    // MARK: - Helper
    private func isEveryday(_ days: [Int]) -> Bool {
        let set = Set(days)
        return days.isEmpty || set == Set(1...7)
    }
    
    // MARK: - FUNCTIONS
    @discardableResult
    func createNewHabit() async -> Bool {
        // Validação de conflito antes de salvar/editar
        if let id {
            // Edição: buscar o hábito para obter o slot atual e validar ignorando o próprio id
            guard let habitWithID = await habitService.getHabitById(id: id) else {
                return false
            }
            
            let conflict = await habitService.hasSlotConflict(
                valuePosition: habitWithID.valuePosition,
                indicePosition: habitWithID.indicePosition,
                scheduleDays: selectedDays,
                excludingHabitID: id
            )
            
            if conflict {
                showSlotConflictAlert = true
                conflictMessage = isEveryday(selectedDays)
                ? "Já existe um hábito nesse círculo que conflita com 'Todos os dias'."
                : "Já existe um hábito nesse círculo para um ou mais dos dias selecionados."
                return false
            }
            
            // Sem conflito: aplicar alterações e salvar
            habitWithID.habitName = habitName
            habitWithID.habitDescription = newHabitDescription
            habitWithID.habitSimbol = habitsSymbol
            habitWithID.habitCompleteness = completenessType
            habitWithID.howManyTimesToToggle = howManyTimesToComplete
            habitWithID.scheduleDays = selectedDays
            habitWithID.howManySecondsToComplete = timesChoice
            habitService.saveChanges()
            return true
        } else {
            // Criação: validar no slot informado no VM
            let conflict = await habitService.hasSlotConflict(
                valuePosition: habitRowPosition,
                indicePosition: habitColunmPosition,
                scheduleDays: selectedDays,
                excludingHabitID: nil
            )
            
            if conflict {
                showSlotConflictAlert = true
                conflictMessage = isEveryday(selectedDays)
                ? "Já existe um hábito nesse círculo que conflita com 'Todos os dias'."
                : "Já existe um hábito nesse círculo para um ou mais dos dias selecionados."
                return false
            }
            
            // Sem conflito: criar e salvar
            let newHabit = Habit(
                habitName: habitName,
                habitDescription: newHabitDescription,
                habitColor: "",
                habitRecurrence: "",
                habitSimbol: habitsSymbol,
                habitCompleteness: completenessType,
                howManyTimesToToggle: howManyTimesToComplete,
                scheduleDays: selectedDays,
                valuePosition: habitRowPosition,
                indicePosition: habitColunmPosition,
                howManySecondsToComplete: timesChoice
            )
            await habitService.createHabit(habit: newHabit)
            return true
        }
    }
    
    func toggleSelection(for day: Int) {
        if let index = selectedDays.firstIndex(of: day) {
            selectedDays.remove(at: index)
        } else {
            selectedDays.append(day)
            selectedDays.sort()
        }
    }
    
    func deleteHabitById() async {
        if let id {
            await habitService.deleteHabit(id: id)
            habitService.saveChanges()
            self.id = nil
        }
    }
}

