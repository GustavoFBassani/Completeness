//
//  habitViewComponent.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 22/09/25.
//

import SwiftUI

struct HabitViewComponent: View {
    @Bindable var habit: Habit
    let day: Date
    
    private var maxProgress: Int {
        switch habit.habitCompleteness {
        case .byToggle, .byMultipleToggle:
            return habit.howManyTimesToToggle
        case .byTimer:
            return habit.howManySecondsToComplete
        case .none:
            return habit.howManyTimesToToggle
        }
    }
    
    private var isCompleted: Bool {
        habit.isCompleted(on: day)
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(isCompleted ? Color.indigoCustom : Color.white)
                    .frame(width: 130, height: 130)
                    .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 4)
                
                Circle()
                    .trim(from: 0, to: CGFloat(habit.howManyTimesItWasDone) / CGFloat(maxProgress))
                    .stroke(Color.indigoCustom,
                            style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 124, height: 124)
                    .rotationEffect(.degrees(90))
                    .animation(.easeInOut, value: habit.howManyTimesItWasDone)
                
                VStack {
                    Image(systemName: habit.habitSimbol)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(habit.howManyTimesItWasDone == maxProgress ? .white : .indigoCustom)
                        .frame(width: 58, height: 58)
                    
                    if habit.howManyTimesItWasDone < maxProgress && habit.habitCompleteness == .byMultipleToggle {
                        Text("\(habit.howManyTimesItWasDone)/\(maxProgress)")
                            .font(.system(size: 12.8, weight: .semibold))
                            .foregroundColor(.labelSecondary)
                    }
                    
                    if habit.howManyTimesItWasDone == maxProgress {
                        Text("Feito!")
                            .font(.system(size: 12.8, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            
            Text(habit.habitName)
                .padding(.top, 6)
                .font(.system(size: 12.8, weight: .semibold))
                .foregroundColor(.labelPrimary)
        }
    }
}

//#Preview {
//    HabitViewComponent(habit: ...)
//}

