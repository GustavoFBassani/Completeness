//
//  habitViewComponent.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 22/09/25.
//

import SwiftUI

struct ToggleHabitViewComponent: View {
    @State private var isDone = false
    var body: some View {
        VStack{
            Button(action: {
                withAnimation(.bouncy(duration: 1)) {
                    isDone.toggle()
                }
            }) {
                ZStack {
                    Circle()
                        .fill(isDone ? Color.white : Color.indigoCustom)
                        .frame(width: 130, height: 130)
                        .shadow(color: .black.opacity(0.25), radius: 34, x: 0, y: 4)
                    
                    VStack{
                        Image(systemName: "book.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(isDone ? .indigoCustom : .white)
                            .frame(width: 58, height: 58)
                        
                        if !isDone {
                            Text("Feito!")
                                .font(.system(size: 12.8, weight: .semibold))
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .buttonStyle(.plain)
            
            Text("Estudar")
                .padding(.top, 6)
                .font(.system(size: 12.8, weight: .semibold))
                .foregroundColor(.labelPrimary)
        }
    }
}

#Preview {
    ToggleHabitViewComponent()
}
