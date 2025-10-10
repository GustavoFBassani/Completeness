//
//  HabitsComponent.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Ferreira bassani on 08/10/25.
//

import SwiftUI
import SwiftData

struct HabitsComponent: View {
    @State var habit: Habit
    @State var habitControlView: Habit? = nil
    @Environment(\.modelContext) var context
    
    var habitCompletenesString: String {
        switch habit.habitCompleteness {
        case .byToggle: "Hábito Simples"
        case .byMultipleToggle: "Hábito multiplo"
        case .byTimer: "Hábito de tempo"
        case .none:
            ""
        }
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top) {
                Image(systemName: habit.habitSimbol)
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
            
            Text(habit.habitName)
                .font(.system(size: 18.5))
                .foregroundStyle(.primary)
                .fontWeight(.bold)
                .padding(.leading, 4)
            Text(habitCompletenesString)
                .font(.system(size: 17))
                .fontWeight(.medium)
                .foregroundStyle(.indigo)
                .padding(.leading, 4)
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 8)
        .background(RoundedRectangle(cornerRadius: 17).fill(.textFieldBackground))
        .onTapGesture {
            habitControlView = habit
        }
        .sheet(item: $habitControlView) { habit in
            CompletenessCompenion_Watch_App.HabitControlView(habit: $habit, viewmodel: HabitsViewModel(habitCompletionService: HabitCompletionRepository(context: context),
                                                                                                                        habitService: HabitRepository(context: context),
                                                                                                                        notificationService: NotificationHelper(),
                                                                                                                        chartsService: ChartsService(modelContext: context)))
        }
    }
}

//
//#Preview {
//    HabitsComponent()
//}
