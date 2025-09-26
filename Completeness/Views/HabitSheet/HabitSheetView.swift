//
//  HabitSheetView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 25/09/25.
//

import SwiftUI

struct HabitSheetView: View {
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
                Button {
                    if currentValue > 0 { currentValue -= 1 }
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 21.06, weight: .medium))
                        .frame(width: 50, height: 50)
//                        .background(Color.gray.opacity(0.2), in: Circle())
                        .background(.ultraThinMaterial, in: Circle())
                        .foregroundColor(.primary)
                    }
                
                ZStack{
                    Circle()
                        .stroke(Color.indigoCustomSecondary.opacity(0.3), lineWidth: 14)
                        .frame(width: 170, height: 170)
                    Circle()
                        .trim(from: 0, to: CGFloat(currentValue) / CGFloat(maxValue))
                        .stroke(Color.indigoCustom, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .frame(width: 170, height: 170)
                    Text("\(currentValue)/\(maxValue)")
                        .font(.system(size: 42.12, weight: .bold))
                }
                          
                Button {
                    if currentValue < maxValue { currentValue += 1 }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 21.06, weight: .medium))
                        .frame(width: 50, height: 50)
                        .background(Color.indigoCustom, in: Circle())
                        .foregroundColor(.white)
                    }
            }
            Button {
                
            }label: {
                Text("Completar")
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

#Preview {
    HabitSheetView()
}
