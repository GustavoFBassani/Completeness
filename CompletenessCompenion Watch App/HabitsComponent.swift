//
//  HabitsComponent.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Ferreira bassani on 08/10/25.
//

import SwiftUI

struct HabitsComponent: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top) {
                Image(systemName: "book.pages.fill")
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.indigo, .indigoCustomSecondary],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
)
                    .font(.system(size: 47))
                    .padding(0)
                
                
                Spacer()
                Image(systemName: "chevron.right")
                    .frame(width: 18, height: 40)
                    .foregroundStyle(.indigoCustom)
            }
            
            Text("Ler páginas")
                .font(.system(size: 18.5))
                .foregroundStyle(.primary)
                .fontWeight(.bold)
                .padding(.leading, 4)
            Text("Hábito etapas")
                .font(.system(size: 17))
                .fontWeight(.medium)
                .foregroundStyle(.indigo)
                .padding(.leading, 4)
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 8)
        .background(RoundedRectangle(cornerRadius: 17).fill(.textFieldBackground))
    }
}

#Preview {
    HabitsComponent()
}
