//
//  ConfigView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI
import SwiftData

struct swiftDataTest: View {
    @Environment(\.modelContext) var context
    @State private var cont = 1
    
    var body: some View {
        Button {
            cont += 1
            let newHabit = Habit(id: UUID(), habitName: "habito\(cont)",
                                 habitIsCompleted: true, habitCategory: "",
                                 habitDescription: "",
                                 habitColor: "",
                                 habitRecurrence: "",
                                 habitSimbol: "",
                                 timestampHabit: Date.now, habitCompleteness: CompletionHabit.byToggle)
            
            context.insert(newHabit)
            try? context.save()
            print("contato salvo")
        } label: {
            Text("salvar outro hábito")
                .padding(.bottom)
        }
        
        Button {
            let descriptor = FetchDescriptor<Habit>()
            let queriedHabits = try? context.fetch(descriptor)
            queriedHabits?.forEach({ qh in
                print(qh.habitName) })
        } label: {
            Text("printar todos os habitos salvos")
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 16).fill(.blue))
                .padding()
        }
    }
}

#Preview {
    swiftDataTest()
}
