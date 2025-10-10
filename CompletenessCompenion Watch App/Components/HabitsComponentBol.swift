//
//  HabitsComponentBol.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Melleu on 09/10/25.
//
import SwiftUI

struct HabitsComponentBol: View {
    var body: some View {
        VStack(spacing: 6) {
            ZStack {
                Circle()
                    .fill(Color(.textFieldBackground))
                    .frame(width: 120, height: 120)
                    .shadow(radius: 1)

                VStack(spacing: 6) {
                    Image(systemName: "book.pages.fill")
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.indigo, .indigoCustomSecondary],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .font(.system(size: 42))
                    Text("1/10")
                        .font(.system(size: 14, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.black)
                }
            }

            Text("Ler páginas")
                .font(.system(size: 14, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    HabitsComponentBol()
}
