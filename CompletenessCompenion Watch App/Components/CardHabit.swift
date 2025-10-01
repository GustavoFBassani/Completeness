//
//  CardHabit.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Melleu on 01/10/25.
//

import SwiftUI

struct CardHabit: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Image("circle.hexagongrid.fill")
                    .font(.system(size: 36, weight: .regular))
                    .foregroundStyle(.indigo)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Algum")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Algum")
                        .font(.subheadline)
                        .foregroundStyle(.indigo)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.indigo)
        }
        .padding()
        .frame(height: 120)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.gray).opacity(0.15))
        )
    }
}
