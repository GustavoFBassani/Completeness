////
////  HabitsPOCView.swift
////  Completeness
////
////  Created by Gustavo Melleu on 11/09/25.
////
//import SwiftUI
//import SwiftData
//
//struct HabitsPOCView: View {
//    @Bindable var viewModel: HabitsViewModel
//    @State private var editHabitsSheet = false
//    
//    var body: some View {
//        VStack(alignment: .center, spacing: 16){
//            TextField("New Habit Name", text: $viewModel.textField)
//                .frame(maxWidth: .infinity)
//                .padding()
//                .background(RoundedRectangle(cornerRadius: 16).fill(.gray))
//            
//            Picker("Completion Type", selection: $viewModel.completenessType) {
//                Text("Toggle simples").tag(CompletionHabit.byToggle)
//                Text("Toggle multiplo").tag(CompletionHabit.byMultipleToggle)
//                Text("By Timer").tag(CompletionHabit.byTimer)
//            }
//            .background(RoundedRectangle(cornerRadius: 16).fill(.brown))
//            
//            if viewModel.showAditionalConfigForHabit() {
//                HStack {
//                    Text("choose how many times you want to do it for a day")
//                    
//                    Picker("How many times", selection: $viewModel.howManyTimesToCompleteHabit) {
//                        ForEach(1..<10, id: \.self) { count in
//                            Text("\(count)").tag(count)
//                        }
//                    }
//                }
//            }
//
//            Button {
//                viewModel.createNewHabit()
//            } label: {
//                Text("Save New Habit")
//            }
//            
//            ForEach(viewModel.habits) { habit in
//                HStack {
//                    Text(habit.habitName)
//                    Spacer()
//                    
//                    if habit.habitCompleteness == .byToggle {
//                        Button {
//                            viewModel.completeHabitByToggle(by: habit.id)
//                        } label: {
//                            Circle().fill(habit.habitIsCompleted ? .green : .red)
//                                .frame(width: 20, height: 20, alignment: .trailing)
//                        }
//                    } else if habit.habitCompleteness == .byMultipleToggle {
//                        if habit.howManyTimesToToggle > habit.howManyTimesItWasDone + 1 {
//                            Button {
//                                viewModel.completeHabitByMultipleToggle(by: habit.id)
//                            } label: {
//                                Text("\(habit.howManyTimesItWasDone) /\(habit.howManyTimesToToggle)")
//                            }
//                        } else {
//                            Button {
//                                viewModel.completeHabitByToggle(by: habit.id)
//                            } label: {
//                                Circle().fill(habit.habitIsCompleted ? .green : .red)
//                                    .frame(width: 20, height: 20, alignment: .trailing)
//                            }
//                        }
//                    }
//                }
//                .frame(maxWidth: .infinity)
//                .onLongPressGesture(perform: {
//                    viewModel.deleteHabit(by: habit.id)
//                    Task {
//                        await viewModel.loadData()
//                    }
//                })
//                .onTapGesture {
//                    viewModel.habitToEdit = habit
//                    editHabitsSheet = true
//                }
//            }
//        }
//        .frame(alignment: .leading)
//        .padding(.horizontal, 16)
//        .task {
//            await viewModel.loadData()
//        }
//        .sheet(isPresented: $editHabitsSheet, content: {
//            SheetToEditHabitsTest(habit: viewModel.habitToEdit, editHabit: {viewModel.editHabit()})
//        })
//    }
//}
