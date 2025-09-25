//
//  EmptyCircle.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 22/09/25.
//

import SwiftUI

struct EmptyCircle: View {
    var habit: Habit? = nil

    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            Image(systemName: habit?.habitSimbol ?? "plus")
                .foregroundStyle(.labelTertiary)
                .font(.system(size: 58))
                .fontWeight(.semibold)
                .padding(33)
                .background(Circle().fill(.backgroundSecondary))
                .shadow(color: .shadow, radius: 20, x: 4.52, y: 4.52)
            
            Text(habit?.habitName ?? "Adicionar")
                .font(.system(size: 13))
                .foregroundStyle(habit?.habitName != nil ? .labelPrimary : .labelSecondary)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    EmptyCircle()
}
