//
//  SwiftUIView.swift
//  CompletenessCompenion Watch App
//
//  Created by Vítor Bruno on 08/10/25.
//

import SwiftUI

struct HabitControlView: View {
    @Binding var habit: Habit
    
    private var progressDone: Int {
        let habitLog = habit.habitLogs?.first(where: {
            Calendar.current.isDate($0.completionDate, inSameDayAs: .now)
        })
        switch habit.habitCompleteness {
        case .byToggle, .byMultipleToggle:
            return habitLog?.howManyTimesItWasDone ?? 0
        case .byTimer:
            return habitLog?.secondsElapsed ?? 0
        case .none:
            return 0
        }
    }
    
    private var progressTimer: String {
        if let habitLog = habit.habitLogs?.first(where: {
            Calendar.current.isDate($0.completionDate, inSameDayAs: .now)
        }) {
            return habitLog.formattedTime
        }
        return "00:00"
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(habit.habitName)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.indigo)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                
                HStack(spacing: 15) {
                    if #available(watchOS 26.0, *) {
                        Button() {
                            
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                        .glassEffect()
                    } else {
                        Button() {} label: {
                            Image(systemName: "minus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                    }
                    
                    VStack{
                        Text(habit.habitCompleteness == .byTimer ? progressTimer : "\(progressDone)/\(habit.howManyTimesToToggle)")
                            .font(.title.bold())
                            .foregroundStyle(.primary)
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.indigoCustomSecondary)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.indigo)
                                .frame(width: 64 * (Double(progressDone) / Double(habit.habitCompleteness == .byTimer ? habit.howManySecondsToComplete : habit.howManyTimesToToggle)))
                        }
                        .frame(width: 64, height: 5)
                        .padding(-8)
                    }
                    
                    
                    
                    if #available(watchOS 26.0, *) {
                        Button() {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                        .glassEffect()
                    } else {
                        Button() {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                    }
                    
                }
                
                Spacer()
                
                if #available(watchOS 26.0, *) {
                    Button() {
                        
                    } label : {
                        Text("Preencher Meta")
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                    .glassEffect()
                } else {
                    Button() {
                        
                    } label : {
                        Text("Preencher Meta")
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        
    }
}
