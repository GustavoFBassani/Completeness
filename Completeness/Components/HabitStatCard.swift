import SwiftUI

struct HabitStatCard: View {
    @Binding var viewModel: ChartsViewModelProtocol
    let habitCartType: HabitCardType
    
    var body: some View {
        if let mostCompletedHabit = viewModel.mostCompletedHabits.first,
           let leastCompletedHabit = viewModel.leastCompletedHabits.first {
            HStack(spacing: 16) {
                VStack(spacing: 16) {
                    ZStack {
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [Color.indigoCustom, Color.indigoCustomSecondary],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 8
                            )
                        
                        Circle()
                            .fill(Color.backgroundPrimary)
                        
                        Image(systemName: habitCartType == .mostDone ? mostCompletedHabit.habitSimbol : leastCompletedHabit.habitSimbol)
                            .font(.system(size: 50).weight(.semibold))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [Color.indigoCustom, Color.indigoCustomSecondary],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                    .frame(width: 100, height: 100)
                    
                    Text(habitCartType == .mostDone ? mostCompletedHabit.habitName : leastCompletedHabit.habitName)
                        .font(.system(size: 16, weight: .semibold))
                }
                .frame(maxWidth: .infinity)

                VStack(alignment: .leading, spacing: 16) {
                    Text(habitCartType == .mostDone ? "Hábito mais feito" : "Hábito menos feito")
                        .font(.title3.bold())
                        .foregroundStyle(Color.labelPrimary)
                    
                    Text(habitCartType == .mostDone ?
                         "Esse hábito já está se tornando parte da sua rotina, continue assim!" :
                         "Esse hábito apareceu pouco essa semana, podemos juntos melhorar!")
                        .font(.subheadline)
                        .foregroundStyle(Color.labelPrimary)
                    
                    let count = habitCartType == .mostDone ? (mostCompletedHabit.habitLogs?.count ?? 0) : (leastCompletedHabit.habitLogs?.count ?? 0)
                    
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
                .frame(width: 192, alignment: .leading)
            }
            .padding()
            .background(Color.backgroundPrimary)
            .cornerRadius(26)
        }
    }
}
