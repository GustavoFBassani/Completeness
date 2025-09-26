//
//  WeeklyChallengeChart.swift
//  Completeness
//
//  Created by Vítor Bruno on 25/09/25.
//

import SwiftUI

struct WeeklyOverallChart: View {
    
    @Binding var viewModel: ChartsViewModelProtocol
    
    var body: some View {
        HStack{
            
            //gráfico geral
            
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
    //WeeklyChallengeChart()
}
