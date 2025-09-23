//
//  habitViewComponent.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 22/09/25.
//

import SwiftUI

struct HabitViewComponent: View {
    @State private var progress = 0
    @State private var completionType: CompletionHabit = .byMultipleToggle
    
    private var maxProgress: Int { completionType == .byToggle ? 1 : 3 }
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.bouncy(duration: 0.6)) {
                    if progress < maxProgress {
                        progress += 1
                    } else {
                        progress = 0
                    }
                }
            }) {
                ZStack {
                    Circle()
                        .fill(progress == maxProgress ? Color.indigoCustom : Color.white)
                        .frame(width: 130, height: 130)
                        .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 4)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(progress) / CGFloat(maxProgress))
                        .stroke(Color.indigoCustom,
                                style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .frame(width: 124, height: 124)
                        .rotationEffect(.degrees(90))
                        .animation(.easeInOut, value: progress)
                    
                    VStack {
                        Image(systemName: "book.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(progress == maxProgress ? .white : .indigoCustom)
                            .frame(width: 58, height: 58)
                        
                        if progress < maxProgress && completionType != .byToggle {
                            Text("\(progress)/\(maxProgress)")
                                .font(.system(size: 12.8, weight: .semibold))
                                .foregroundColor(.labelSecondary)
                        }
                        
                        if progress == maxProgress {
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
    HabitViewComponent()
}
