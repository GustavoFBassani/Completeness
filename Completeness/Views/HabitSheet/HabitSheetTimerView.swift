//
//  HabitSheetTimerView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 26/09/25.
//
import SwiftUI

struct HabitSheetTimerView: View {
@Environment(\.dismiss) var dismiss
 
  //o circulo de progresso teste
@State private var currentValue = 3
let maxValue = 5
          
    var body: some View {
        VStack(spacing: 24){
            ZStack {
                Text("Aprender algo novo")
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
                ZStack{
                    Circle()
                        .stroke(Color.indigoCustomSecondary.opacity(0.3), lineWidth: 14)
                        .frame(width: 170, height: 170)
                    Circle()
                        .trim(from: 0, to: CGFloat(currentValue) / CGFloat(maxValue))
                        .stroke(Color.indigoCustom, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 170, height: 170)
                    Text("20:00")
                        .font(.system(size: 42.12, weight: .bold))
                }
            }
            Button {
                        //
            }label: {
                Text("Iniciar tempo")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 52)
                    .background(Color.indigoCustom)
                    .cornerRadius(26)
                    .font(.system(size: 17, weight: .semibold))
            }
            .padding(.horizontal)
            
            Button("Editar"){
                //editar ...
            }
            .font(.system(size: 17, weight: .semibold))
            .font(.callout)
            .foregroundColor(.labelPrimary)
            .underline()
                      
            Spacer()
        }
        .padding()
        .presentationDragIndicator(.visible)
    }
}

//#Preview {
//    HabitSheetView()
//}
//import SwiftUI
//
//struct HabitSheetTimerView: View {
//    @Environment(\.dismiss) var dismiss
//    
//    
//    // teste para tempo
//    @State private var totalTime: Int = 20 * 60   // 20 minutos
//    @State private var remainingTime: Int = 20 * 60
//    @State private var isRunning = false
//    @State private var timer: Timer? = nil
//    
//    var body: some View {
//        VStack(spacing: 24) {
//            ZStack {
//                Text("Aprender algo novo")
//                    .font(.system(size: 17, weight: .semibold))
//                
//                HStack {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Image(systemName: "xmark")
//                            .font(.title2)
//                            .foregroundColor(.primary)
//                            .padding(12)
//                            .background(.ultraThinMaterial, in: Circle())
//                    }
//                    Spacer()
//                }
//            }
//            
//            ZStack {
//                Circle()
//                    .stroke(Color.indigoCustomSecondary.opacity(0.3), lineWidth: 14)
//                    .frame(width: 170, height: 170)
//                
//                Circle()
//                    .trim(from: 0, to: CGFloat(progress))
//                    .stroke(Color.indigoCustom, style: StrokeStyle(lineWidth: 14, lineCap: .round))
//                    .rotationEffect(.degrees(-90))
//                    .frame(width: 170, height: 170)
//                
//                Text(timeString(from: remainingTime))
//                    .font(.system(size: 42, weight: .bold))
//            }
//            
//            if isRunning {
//                HStack(spacing: 16) {
//                    Button {
//                        resetTimer()
//                    } label: {
//                        Text("Zerar tempo")
//                            .foregroundColor(.indigoCustom)
//                            .frame(maxWidth: .infinity, minHeight: 52)
//                            .background(Color.white)
//                            .cornerRadius(26)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 26)
//                                    .stroke(Color.indigoCustom, lineWidth: 1)
//                            )
//                    }
//                    
//                    Button {
//                        pauseTimer()
//                    } label: {
//                        Text("Pausar")
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity, minHeight: 52)
//                            .background(Color.indigoCustom)
//                            .cornerRadius(26)
//                    }
//                }
//                .padding(.horizontal)
//            } else {
//                Button {
//                    startTimer()
//                } label: {
//                    Text("Iniciar tempo")
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity, minHeight: 52)
//                        .background(Color.indigoCustom)
//                        .cornerRadius(26)
//                        .font(.system(size: 17, weight: .semibold))
//                }
//                .padding(.horizontal)
//            }
//            Button("Editar") {
//                //
//            }
//            .font(.system(size: 17, weight: .semibold))
//            .foregroundColor(.primary)
//            .underline()
//            
//            Spacer()
//        }
//        .padding()
//        .presentationDragIndicator(.visible)
//        .onDisappear {
//            timer?.invalidate()
//        }
//    }
//    
//    // MARK: - Helpers
//    
//    private var progress: Double {
//        guard totalTime > 0 else { return 0 }
//        return Double(totalTime - remainingTime) / Double(totalTime)
//    }
//    
//    private func startTimer() {
//        isRunning = true
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if remainingTime > 0 {
//                remainingTime -= 1
//            } else {
//                timer?.invalidate()
//                isRunning = false
//            }
//        }
//    }
//    
//    private func pauseTimer() {
//        timer?.invalidate()
//        isRunning = false
//    }
//    
//    private func resetTimer() {
//        timer?.invalidate()
//        remainingTime = totalTime
//        isRunning = false
//    }
//    
//    private func timeString(from seconds: Int) -> String {
//        let minutes = seconds / 60
//        let seconds = seconds % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//}
//
//#Preview {
//    HabitSheetTimerView()
//}
