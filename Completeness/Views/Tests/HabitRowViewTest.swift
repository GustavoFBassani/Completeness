////
////  HabitRowViewTest.swift
////  Completeness
////
////  Created by Vítor Bruno on 20/09/25.
////
//
//import SwiftUI
//
//struct HabitRowView: View {
//    let habit: Habit
//    @Bindable var viewModel: HabitsViewModel
//    
//    var body: some View {
//        HStack {
//            Text(habit.habitName)
//                .foregroundStyle(.indigoCustom)
//            Spacer()
//            
//            switch habit.habitCompleteness {
//            case .byToggle:
//                Button(action: { Task { await viewModel.completeHabit(habit: habit, on: viewModel.selectedDate ) } }) {
//                    Image(systemName: habit.isCompleted(on: viewModel.selectedDate) ? "checkmark.circle.fill" : "circle")
//                        .font(.title2)
//                        .foregroundStyle(habit.isCompleted(on: viewModel.selectedDate) ? .green : .secondary)
//                }
//                .buttonStyle(.plain)
//                
//            case .byMultipleToggle:
//                if habit.isCompleted(on: viewModel.selectedDate) {
//                    Image(systemName: "checkmark.circle.fill")
//                        .font(.title2)
//                        .foregroundStyle(.green)
//                        .onTapGesture { Task { await viewModel.completeHabit(habit: habit, on: viewModel.selectedDate) } }
//                } else {
//                    Button(action: { Task { await viewModel.completeHabit(habit: habit, on: viewModel.selectedDate) } }) {
//                        Text("\(habit.howManyTimesItWasDone) / \(habit.howManyTimesToToggle)")
//                            .font(.caption)
//                            .fontWeight(.bold)
//                            .padding(8)
//                            .background(Circle().stroke(Color.secondary))
//                    }
//                    .buttonStyle(.plain)
//                }
//                
//            case .byTimer:
//                Button(action: { Task { await viewModel.completeHabit(habit: habit, on: viewModel.selectedDate) } }) {
//                    Image(systemName: "timer")
//                        .font(.title2)
//                        .foregroundStyle(.secondary)
//                }
//                .buttonStyle(.plain)
//                
//            default:
//                EmptyView()
//            }
//        }
//        .padding(.vertical, 8)
//    }
//}
