//
//  EmptyCircle.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 22/09/25.
//

import SwiftUI

struct EmptyCircle: View {
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            Image(systemName: "plus")
                .foregroundStyle(.labelTertiary)
                .font(.system(size: 58))
                .fontWeight(.semibold)
                .padding(33)
                .background(Circle().fill(.backgroundSecondary))
                .shadow(color: .shadow, radius: 10, x: 4.52, y: 4.52)
            
            Text("Adicionar")
                .font(.system(size: 13))
                .foregroundStyle(.labelSecondary)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    EmptyCircle()
}
