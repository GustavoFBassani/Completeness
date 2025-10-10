//
//  WeeklyChallengeChart.swift
//  Completeness
//
//  Created by Vítor Bruno on 25/09/25.
//

import SwiftUI

struct OverallChart: View {
    @Binding var viewModel: ChartsViewModelProtocol
    @State private var animatedProgress: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 32){
            VStack {
                ZStack {
                    Circle()
                        .stroke(
                            Color.indigoCustomTertiary,
                            lineWidth: 24)
                    
                    Circle()
                        .trim(from: 0.0, to: animatedProgress)
                        .stroke(
                            Color.indigoCustom,
                            style: StrokeStyle(lineWidth: 24, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 0.7), value: animatedProgress) //animation absed on the overallCompletionRate
                    
                    
                    Text("\(viewModel.overallCompletionRate, specifier: "%.0f")%")
                        .font(.title.bold())
                        .foregroundStyle(Color.labelPrimary)
                        .padding(4)
                }
                .frame(width: 100, height: 100)
            }
            .padding(.leading)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Hábitos semanais")
                    .font(.title3.bold())
                    .foregroundStyle(Color.labelPrimary)
                
                if viewModel.overallCompletionRate >= 60 {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate, specifier: "%.0f")% dos seus hábitos, você foi muito bem!")
                        .padding(.trailing, 32)
                        .font(.subheadline)
                } else {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate, specifier: "%.0f")% dos seus hábitos")
                        .padding(.trailing, 32)
                        .font(.subheadline)
                }
                
                ZStack {
                    Text("\(viewModel.totalHabitsCompleted) habitos feitos")
                        .font(.subheadline.bold())
                        .foregroundStyle(.whiteCustom)
                        .padding(.horizontal, 35.5)
                        .padding(.vertical, 7.49)
                }
                .background(
                    RoundedRectangle(cornerRadius: 22.81)
                        .foregroundStyle(.indigoCustom)
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 26)
                .foregroundStyle(Color.backgroundPrimary)
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                animatedProgress = viewModel.overallCompletionRate / 100
            }
        }
    }
}
