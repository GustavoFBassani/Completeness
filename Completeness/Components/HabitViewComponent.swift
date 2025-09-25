//
//  habitViewComponent.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 22/09/25.
//

import SwiftUI

struct HabitViewComponent: View {
    @Bindable var habit: Habit
    var refreshView = false
    let day: Date
    
        private var maxProgress: Int {
            switch habit.habitCompleteness {
            case .byToggle, .byMultipleToggle, .byTimer:
                return habit.howManyTimesToToggle
            case .none:
                return habit.howManyTimesToToggle
            }
        }
    
    private var progressDone: Int {
        switch habit.habitCompleteness {
        case .byToggle, .byMultipleToggle:
            let habitLog = habit.habitLogs?.first(where: {log in
                log.completionDate == day })
            return habitLog?.howManyTimesItWasDone ?? 0
            
        case .byTimer:
            let habitLog = habit.habitLogs?.first(where: {log in
                log.completionDate == day })
            return habitLog?.secondsElapsed ?? 0
        case .none:
            return 0
        }
    }
    
    private var isCompleted: Bool {
        habit.isCompleted(on: day)
    }
    
    private var circleColor: Color {
        switch isCompleted {
        case true:
            return Color.indigoCustom
        case false:
            return Color.white
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(circleColor)
                    .frame(width: 130, height: 130)
                    .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 4)
                    .animation(.easeInOut(duration: 0.4).delay(0.3), value: isCompleted)
                
                Circle()
                    .trim(from: 0, to: maxProgress > 0 ? min(1, CGFloat(progressDone) / CGFloat(maxProgress)) : 0)
                    .stroke(Color.indigoCustom,
                            style: StrokeStyle(lineWidth: 6, lineCap: .round))
                    .frame(width: 124, height: 124)
                    .rotationEffect(.degrees(90))
                    .animation(.easeInOut(duration: 0.4), value: progressDone)
                
                VStack {
                    Image(systemName: habit.habitSimbol)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(isCompleted ? .white : .indigoCustom)
                        .animation(.easeInOut(duration: 0.4).delay(0.3), value: isCompleted)
                        .frame(width: 58, height: 58)
                    
                    if progressDone < maxProgress {
                        Text("\(progressDone)/\(maxProgress)")
                            .font(.system(size: 12.8, weight: .semibold))
                            .foregroundColor(.labelSecondary)
                    }
                    
                    if progressDone == maxProgress {
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
