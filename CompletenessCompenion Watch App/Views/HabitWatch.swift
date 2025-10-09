//
//  HabitWatch.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Melleu on 09/10/25.
//
//
//import SwiftUI
//
//struct HabitWatch: View {
//    var habits = [
//        "Ler páginas",
//        "Yoga",
//        "Dormir cedo",
//        "Beber água",
//        "Estudar SwiftUI"
//    ]
//    
//    @State private var isBolView = false
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(spacing: 3.5) { // espaço entre cards
//                    ForEach(habits, id: \.self) { habit in
//                        NavigationLink(destination: HabitControlView()) {
//                            if isBolView {
//                                HabitsComponentBol()
//                            } else {
//                                HabitsComponent()
//                            }
//                        }
//                        .buttonStyle(.plain)
//                    }
//                }
//                .padding(.vertical, 6)
//            }
//            .navigationTitle("Hábitos")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    Button {
//                        withAnimation(.easeInOut) {
//                            isBolView.toggle()
//                        }
//                    } label: {
//                        Image(systemName: isBolView ? "list.bullet" : "circle.hexagongrid.fill")
//                            .font(.system(size: 17, weight: .semibold))
//                            .foregroundStyle(.white)
//                    }
//                }
//            }
//            .toolbarRole(.navigationStack)
//        }
//    }
//}
//
//#Preview {
//    HabitWatch()
//}
import SwiftUI

struct HabitWatch: View {
    var habits = [
        "Ler páginas",
        "Yoga",
        "Dormir cedo",
        "Beber água",
        "Estudar SwiftUI"
    ]
    
    @State private var isBolView = false

    var body: some View {
        NavigationStack {
            GeometryReader { outerGeo in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 6) {
                        ForEach(habits.indices, id: \.self) { index in
                            GeometryReader { geo in
                                // Calcula a distância do centro da tela
                                let midY = geo.frame(in: .global).midY
                                let screenMid = outerGeo.size.height
                                let distance = abs(screenMid - midY)
                                
                                // Controla o fator de escala (quanto mais perto do centro, maior)
                                let scale = max(0.85, 1 - (distance / 600))
                                
                                NavigationLink(destination: HabitControlView()) {
                                    if isBolView {
                                        HabitsComponentBol()
                                            .scaleEffect(scale)
                                            .animation(.easeInOut(duration: 0.25), value: scale)
                                    } else {
                                        HabitsComponent()
                                            .scaleEffect(scale)
                                            .animation(.easeInOut(duration: 0.25), value: scale)
                                            .frame(maxWidth: .infinity)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                            .frame(height: 105)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Hábitos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            isBolView.toggle()
                        }
                    } label: {
                        Image(systemName: isBolView ? "list.bullet" : "circle.hexagongrid.fill")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                }
            }
            .toolbarRole(.navigationStack)
        }
    }
}

#Preview {
    HabitWatch()
}
