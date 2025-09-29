//
//  HabitStatCard.swift
//  Completeness
//
//  Created by Vítor Bruno on 25/09/25.
//

import SwiftUI

struct HabitStatCard: View {
    @Binding var viewModel: ChartsViewModelProtocol
    let habitCartType: HabitCardType
    
    var body: some View {
            if let mostCompletedHabit = viewModel.mostCompletedHabits.first,
               let leastCompletedHabit = viewModel.leastCompletedHabits.first {
                HStack {
                    VStack(alignment: .center, spacing: 12){
                        ZStack {
                            Circle()
                                .stroke(LinearGradient(
                                    colors: [Color.indigoCustom, Color.indigoCustomSecondary],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ), lineWidth: 8)
                            
                            Circle()
                                .fill(Color.backgroundPrimary)
                            
                            Image(systemName: habitCartType == .mostDone ? mostCompletedHabit.habitSimbol : leastCompletedHabit.habitSimbol)
                                .font(.system(size: 58).weight(.semibold))
                                .foregroundStyle(LinearGradient(
                                    colors: [Color.indigoCustom, Color.indigoCustomSecondary],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                        }
                        .frame(width: 130, height: 130)
                        
                        Text(habitCartType == .mostDone ? mostCompletedHabit.habitName : leastCompletedHabit.habitName)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(habitCartType == .mostDone ? "Hábito mais feito" : "Hábito menos feito")
                            .font(.title2.bold())
                            .foregroundStyle(Color.labelPrimary)
                        
                        Text(habitCartType == .mostDone ?
                             "Esse hábito já está se tornando parte da sua rotina, continue assim!" :
                             "Esse hábito apareceu pouco essa semana, podemos juntos melhorar!")
                            .font(.subheadline)
                            .foregroundStyle(Color.labelPrimary)
                        
                        let count = habitCartType == .mostDone ? (mostCompletedHabit.habitLogs?.count ?? 0) : (leastCompletedHabit.habitLogs?.count ?? 0)
                        
                        Text("Hábito feito \(count) vezes")
                            .font(.subheadline.bold())
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                            .background(
                                Capsule()
                                    .foregroundStyle(.indigoCustom)
                            )
                    }
                    .padding(.trailing, 16)
                    .padding(.vertical, 22)
                }
                .background(Color.backgroundPrimary)
                .cornerRadius(26)
                .shadow(
                    color: .black.opacity(0.15),
                    radius: 33
                )
            } else {
                Text("Carregando estatísticas...")
                    .padding()
            }
        }
}

#Preview {
    //HabitStatCard()
}
