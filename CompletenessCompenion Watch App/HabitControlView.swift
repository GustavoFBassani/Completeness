//
//  SwiftUIView.swift
//  CompletenessCompenion Watch App
//
//  Created by Vítor Bruno on 08/10/25.
//

import SwiftUI
import SwiftData

struct HabitControlView: View {
    @State var refreshView = false
    @Binding var habit: Habit
    @Bindable var viewmodel: HabitsViewModel
    
    init(refreshView: Bool = false, habit: Binding<Habit>, viewmodel: HabitsViewModel) {
        self._refreshView = State(initialValue: refreshView)
        self._habit = habit
        self.viewmodel = viewmodel
        viewmodel.habitToVerifyIfIsRunning = habit.wrappedValue
    }
    
    var habitMaxProgress: Int  {
        switch habit.habitCompleteness {
        case .byToggle, .byMultipleToggle:
            return habit.howManyTimesToToggle
        case .byTimer:
            return habit.howManySecondsToComplete
        case .none:
            return 0
        }
    }
    
    var habitProgress: Int {
        guard let habitLog = habit.habitLogs?.first(where: { log in
            log.completionDate == Calendar.current.startOfDay(for: Date()) })  else { return 0}
        
        switch habit.habitCompleteness {
        case .byToggle, .byMultipleToggle:
            return habitLog.howManyTimesItWasDone
        case .byTimer:
            return habitLog.secondsElapsed
        case .none:
            return 0
        }
    }
    
    var habitProgressTimer: String {
        if let habitLog = habit.habitLogs?.first(where: { log in
            log.completionDate == Date()}) {
            return habitLog.formattedTime
        }
        return "00:00"
    }
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Text(habit.habitName)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.indigo)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
//                Spacer()
                
                HStack(spacing: 15) {
                    if habit.habitCompleteness == .byMultipleToggle {
                        if #available(watchOS 26.0, *) {
                            Button {
                                refreshView.toggle()
                                Task {
                                    refreshView.toggle()
                                    await viewmodel.decreaseHabitSteps(habit: habit, date: Calendar.current.startOfDay(for: Date()))
                                    refreshView.toggle()
                                }
                                refreshView.toggle()
                            } label: {
                                Image(systemName: "minus")
                                    .font(.system(size: 24).bold())
                            }
                            .clipShape(.circle)
                            .contentShape(.circle)
                            .frame(width: 44.5, height: 44.5)
                            .glassEffect()
                        } else {
                            Button {
                                refreshView.toggle()
                                Task {
                                    refreshView.toggle()

                                    await viewmodel.decreaseHabitSteps(habit: habit, date: Calendar.current.startOfDay(for: Date()))
                                    refreshView.toggle()
                                }
                                refreshView.toggle()
                            } label: {
                                Image(systemName: "minus")
                                    .font(.system(size: 24).bold())
                            }
                            .clipShape(.circle)
                            .contentShape(.circle)
                            .frame(width: 44.5, height: 44.5)
                        } //botao e menos
                    }
                    VStack {
                        Text(habit.habitCompleteness == .byTimer ? "\(habitProgressTimer)":  "\(habitProgress)/\(habitMaxProgress)")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                            
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.indigoCustomSecondary)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.indigo)
                                .frame(width: {
                                    let maxValue = Swift.max(1, habitMaxProgress)
                                    let clampedProgress = Swift.min(maxValue, Swift.max(0, habitProgress))
                                    return 64 * (Double(clampedProgress) / Double(maxValue))
                                }())
                                .animation(.easeInOut(duration: 0.2), value: habitProgress)
                        }
                        .frame(width: 64, height: 5)
                        .padding(-8)
                    } // numero e barrinha
                    
                    if habit.habitCompleteness == .byMultipleToggle {
                        if #available(watchOS 26.0, *) {
                            Button {
                                Task {
                                    await viewmodel.completeHabit(habit: habit, on: Date())
                                }
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 24).bold())
                            }
                            .clipShape(.circle)
                            .contentShape(.circle)
                            .frame(width: 44.5, height: 44.5)
                            .glassEffect()
                        } else {
                            Button() { } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 24).bold())
                            }
                            .clipShape(.circle)
                            .contentShape(.circle)
                            .frame(width: 44.5, height: 44.5)
                        }
                    } //botao e mais
                }
            }
            Spacer()
            if habit.habitCompleteness != .byTimer {
                if #available(watchOS 26.0, *) {
                    Button {
                        switch habit.habitCompleteness {
                        case .byToggle:
                            Task{
                                await viewmodel.completeHabit(habit: habit, on: Date())
                            }
                        case .byMultipleToggle:
                            Task {
                                await viewmodel.completeHabitAutomatically(habit: habit)
                            }
                        default:
                            Task {
                                await viewmodel.completeHabitAutomatically(habit: habit)
                            }
                        }
                    } label: {
                        Text("Preencher Meta")
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                    .glassEffect()
                } else {
                    Button() { } label : {
                        Text("Preencher Meta")
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                }
            } else {
                if #available(watchOS 26.0, *) {
                    Button {
                            Task {
                                await viewmodel.didTapHabit(habit)
                            }

                    } label: {
                        Text(viewmodel.isHabbitWithIdRunning[habit.id] ?? false ? "Pausar" : "Iniciar Tempo" )
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                    .glassEffect()
                } else {
                    Button {
                        Task {
                            await viewmodel.didTapHabit(habit)
                        }
                    } label: {
                        Text(viewmodel.isHabbitWithIdRunning[habit.id] ?? true ? "Pausar" : "Iniciar" )
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
