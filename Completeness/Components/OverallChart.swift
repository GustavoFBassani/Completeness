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
        HStack{
            
            //gráfico geral
            ZStack {
                
                Circle()
                    .stroke(
                        Color.indigoCustomTertiary,
                        lineWidth: 24)
                
                Circle()
                    .trim(from: 0.0, to: viewModel.overallCompletionRate)
                    .stroke(
                        Color.indigoCustom,
                        style: StrokeStyle(lineWidth: 24, lineCap: .round)
                    )
                    .frame(width: 130.41, height: 130.41)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: viewModel.overallCompletionRate) //animation absed on the overallCompletionRate
                
                Circle()
                    .fill(.backgroundPrimary)
                    
                
                Text("\(viewModel.overallCompletionRate)")
                    .font(.title)
                    .foregroundStyle(Color.labelPrimary)
            }
            
            VStack(spacing: 16) {
                Text("Hábitos semanais")
                    .font(.title2)
                    .foregroundStyle(Color.labelPrimary)
                
                if viewModel.overallCompletionRate >= 60 {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate) dos seus hábitos, você foi muito bem!")
                } else {
                    Text("Essa semana você concluiu \(viewModel.overallCompletionRate) dos seus hábitos")
                }
                
                ZStack {
                    Text("tantos habitos feitos")
                }
                .background(
                    RoundedRectangle(cornerRadius: 22.81)
                        .foregroundStyle(.indigoCustom)
                )
            }
        }
        .padding()
    }
}

#Preview {
}
