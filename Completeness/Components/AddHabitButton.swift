//
//  AddHabitButton.swift
//  Completeness
//
//  Created by Gustavo Melleu on 17/09/25.
//

import SwiftUI

struct AddHabitButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.title2)
                .fontWeight(.regular)
                .foregroundColor(Color.indigo.opacity(0.8))
                .padding(14)
        }
        .background(.ultraThinMaterial, in: Circle())
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.trailing)
    }
}
