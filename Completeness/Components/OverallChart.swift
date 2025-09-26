//
//  WeeklyChallengeChart.swift
//  Completeness
//
//  Created by Vítor Bruno on 25/09/25.
//

import SwiftUI

struct OverallChart: View {
    @Binding var viewModel: ChartsViewModelProtocol
    
    var body: some View {
        HStack(spacing: 32){
            ZStack {
                Circle()
                    .stroke(
                        Color.indigoCustomTertiary,
                        lineWidth: 24)
                
                Circle()
                    .trim(from: 0.0, to: viewModel.overallCompletionRate)
                    .stroke(
                        Color.indigoCustom,
                        style: StrokeStyle(lineWidth: 32, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: viewModel.overallCompletionRate) //animation absed on the overallCompletionRate
                
                
                Text(viewModel.overallCompletionRate, format: .percent.precision(.fractionLength(0)))
                    .font(.title.bold())
                    .foregroundStyle(Color.labelPrimary)
            }
            .frame(width: 120, height: 120)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Hábitos semanais")
                    .font(.title2.bold())
                    .foregroundStyle(Color.labelPrimary)
                
                if viewModel.overallCompletionRate >= 60 {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate, specifier: "%.0f")% dos seus hábitos, você foi muito bem!")
                        .padding(.trailing, 30)
                        .font(.subheadline)
                } else {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate, specifier: "%.0f")% dos seus hábitos")
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
        .background(
            RoundedRectangle(cornerRadius: 26)
                .foregroundStyle(.backgroundPrimary)
        )
    }
}
