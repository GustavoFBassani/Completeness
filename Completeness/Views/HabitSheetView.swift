//
//  HabitSheetView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 25/09/25.
//

import SwiftUI

struct HabitSheetView: View {
    //view wrappers
    var id = UUID()
    @Environment(\.dismiss) var dismiss
    @State var showEditView: Bool
    @Binding var isHabbitRunning: [UUID:Bool]
    @State var showAlertOfHabitRunning = false
    
    var selectedDate: Date
    // coming from viewModel
    var resetHabitTimer: () -> Void
    //coming from viewModel
    var completeTheHabitAutomatically: () -> Void
    // coming from viewModel
    var subtractOneStep: () -> Void
    // coming from viewModel
    var increaseOneStepOrStopAndPauseTimer: () -> Void
    // coming from viewModel
    var habit: Habit
    //coming from view (ok)
    var configsVMFactory: HabitsConfigVMFactory
    //should come from viewModel...
    @State var detailsView: HabitsConfigView
    // swiftlint:disable:next line_length
    init(showEditView: Bool = false,
         isHabbitRunning: Binding<[UUID: Bool]>,
         selectedDate: Date,
         resetHabitTimer: @escaping () -> Void,
         completeTheHabitAutomatically: @escaping () -> Void,
         subtractOneStep: @escaping () -> Void,
         increaseOneStepOrStopAndPauseTimer: @escaping () -> Void,
         habit: Habit,
         configsVMFactory: HabitsConfigVMFactory){
        self._showEditView = State(initialValue: showEditView) //underline pq é binding...
        self._isHabbitRunning = isHabbitRunning
        self.selectedDate = selectedDate
        self.resetHabitTimer = resetHabitTimer
        self.completeTheHabitAutomatically = completeTheHabitAutomatically
        self.subtractOneStep = subtractOneStep
        self.increaseOneStepOrStopAndPauseTimer = increaseOneStepOrStopAndPauseTimer
        self.habit = habit
        self.configsVMFactory = configsVMFactory

        self.habitProgress = {
            if let habitLog = habit.habitLogs?.first(where: { log in
                log.completionDate == Calendar.current.startOfDay(for: selectedDate)
            }) {
                switch habit.habitCompleteness {
                case .byToggle, .byMultipleToggle:
                    return habitLog.howManyTimesItWasDone
                case .byTimer:
                    return habitLog.secondsElapsed
                case .none:
                    return 0
                }
            }
            return 0
        }()

        self.habitMaxProgress = {
            switch habit.habitCompleteness {
            case .byToggle, .byMultipleToggle:
                return habit.howManyTimesToToggle
            case .byTimer:
                return habit.howManySecondsToComplete
            case .none:
                return 0
            }
        }()

        self.isHabbitIsByTimer = {
            habit.habitCompleteness == .byTimer
        }()

        self.habitProgressTimer = {
            if let habitLog = habit.habitLogs?.first(where: { log in
                log.completionDate == Calendar.current.startOfDay(for: Date())
            }) {
                return habitLog.formattedTime
            }
            return "00:00"
        }()

        self._detailsView = State(initialValue: HabitsConfigView(
            id: habit.id,
            viewModel: configsVMFactory.editHabits(
                habitName: habit.habitName,
                scheduleDays: habit.scheduleDays,
                habitSimbol: habit.habitSimbol,
                habitCompleteness: habit.habitCompleteness,
                howManySecondsToComplete: habit.howManySecondsToComplete,
                howManyTimesToToggle: habit.howManyTimesToToggle,
                habitDescription: habit.habitDescription
            ),
            title: habit.habitName,
            howManyTimesToToggle: habit.howManyTimesToToggle
        ))
    }
    
    private var habitProgress: Int
    private var habitMaxProgress: Int
    private var isHabbitIsByTimer: Bool
    private var habitProgressTimer: String

    var body: some View {
        VStack(spacing: 24){
            ZStack {
                Text(habit.habitName)
                    .font(.system(size: 17, weight: .semibold))
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .padding(12)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    Spacer()
                }
            }
            
            HStack(spacing: 40){
                if !isHabbitIsByTimer {
                    Button {
                        subtractOneStep()
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 21.06, weight: .medium))
                            .frame(width: 50, height: 50)
                        //                        .background(Color.gray.opacity(0.2), in: Circle())
                            .background(.ultraThinMaterial, in: Circle())
                            .foregroundColor(.primary)
                    }
                }
                ZStack{
                    Circle()
                        .stroke(Color.indigoCustomSecondary.opacity(0.3), lineWidth: 14)
                        .frame(width: 170, height: 170)
                    Circle()
                        .trim(from: 0, to: habitMaxProgress > 0 ? CGFloat(habitProgress) / CGFloat(habit.isCompleted(on: selectedDate) ? habitProgress:   habitMaxProgress) : 0)
                        .stroke(Color.indigoCustom, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                        .rotationEffect(.degrees(90))
                        .frame(width: 170, height: 170)
                    Text(isHabbitIsByTimer ? habitProgressTimer : "\(habitProgress)/\(habit.isCompleted(on: selectedDate) ? habitProgress:   habitMaxProgress)")
                        .font(.system(size: 42.12, weight: .bold))
                }
                if !isHabbitIsByTimer {
                    Button {
                        increaseOneStepOrStopAndPauseTimer()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 21.06, weight: .medium))
                            .frame(width: 50, height: 50)
                            .background(Color.indigoCustom, in: Circle())
                            .foregroundColor(.white)
                    }
                }
            }
            if isHabbitRunning[habit.id] ?? false &&
                !habit.isCompleted(on: selectedDate){
                HStack(spacing: 4) {
                    Button {
                        resetHabitTimer()
                    } label: {
                        Text("Zerar Tempo")
                            .frame(width: 157, height: 52)
                            .background(RoundedRectangle(cornerRadius: 26).fill(.backgroundPrimary))
                            .foregroundStyle(.indigoCustom)
                            .fontWeight(.semibold)
                    }
                    Button {
                        increaseOneStepOrStopAndPauseTimer()
                    } label: {
                        Text("Pausar")
                            .frame(width: 157, height: 52)
                            .background(RoundedRectangle(cornerRadius: 26).fill(.indigoCustom))
                            .foregroundStyle(.backgroundPrimary)
                            .fontWeight(.semibold)
                    }
                }
            } else {
                Button {
                    if isHabbitIsByTimer {
                        increaseOneStepOrStopAndPauseTimer()
                    } else {
                        completeTheHabitAutomatically()
                    }
                }label: {
                    Text(isHabbitIsByTimer ? "Iniciar Tempo" : "Completar")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(Color.indigoCustom)
                        .cornerRadius(26)
                        .font(.system(size: 17, weight: .semibold))
                }
            }

            
            Button("Editar"){

                if habit.isCompleted(on: selectedDate) {
                    isHabbitRunning[habit.id] = false
                }
                if isHabbitRunning[habit.id] ?? false {
                    showAlertOfHabitRunning = true
                } else {
                    showEditView = true
                }
            }
            .font(.system(size: 17, weight: .semibold))
            .font(.callout)
            .foregroundColor(.labelPrimary)
            .underline()
            
            Spacer()
        }
        .alert(
            "Hábito em andamento",
            isPresented: $showAlertOfHabitRunning,
            actions: {
                Button("OK", role: .cancel) { }
            },
            message: {
                Text("O hábito não pode ser editado enquanto está em andamento. Por favor, pause-o para poder editá-lo.")
            }
        )
        .sheet(isPresented: $showEditView, content: {
                detailsView
                .onAppear{
                    detailsView.dismissSheet = dismiss
                }
            }
        )
        .padding()
        .presentationDragIndicator(.visible)
    }
}
