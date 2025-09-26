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
        HStack(spacing: 16){
            ZStack {
                Circle()
                    .stroke(
                        Color.indigoCustomTertiary,
                        lineWidth: 32)
                
                Circle()
                    .trim(from: 0.0, to: viewModel.overallCompletionRate)
                    .stroke(
                        Color.indigoCustom,
                        style: StrokeStyle(lineWidth: 32, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: viewModel.overallCompletionRate) //animation absed on the overallCompletionRate
                
                
                Text("\(viewModel.overallCompletionRate)%")
                    .font(.title.bold())
                    .foregroundStyle(Color.labelPrimary)
            }
            .frame(width: 130.41, height: 130.41)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Hábitos semanais")
                    .font(.title2.bold())
                    .foregroundStyle(Color.labelPrimary)
                
                if viewModel.overallCompletionRate >= 60 {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate)% dos seus hábitos, você foi muito bem!")
                    Text("Essa semana você concluiu 70% dos seus hábitos, você foi muito bem!")
                        .padding(.trailing, 30)
                        .font(.subheadline)
                } else {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate)% dos seus hábitos")
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
            .padding(.horizontal, 16)
            .padding(.vertical, 22.01)
        }
        .background(
            RoundedRectangle(cornerRadius: 26)
                .foregroundStyle(.backgroundPrimary)
        )
    }
}
