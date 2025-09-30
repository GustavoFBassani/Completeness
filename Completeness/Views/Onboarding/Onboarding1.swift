//
//  Onboarding1.swift
//  Completeness
//
//  Created by Gustavo Melleu on 26/09/25.
//

import SwiftUI

import SwiftUI

struct Onboarding1: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    var body: some View {
        ZStack {
            Image("Frame 1")
                .scaledToFill()
                .ignoresSafeArea()
                .padding(.bottom, 90)
            VStack {
                HStack {
                    Spacer()
                    Button {
                        hasSeenOnboarding = true
                    }label: {
                        Text("Pular")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.indigoCustomSecondary)
                    }
                    .padding(.trailing, 24)
                    .padding(.top, 16)
                }
                Spacer()
                
                ZStack(alignment: .bottom) {
                    Image("Ellipse 8")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea(edges: .bottom)
                    
                    VStack(spacing: 16) {
                        Text("Bem-vindo a \n sua nova rotina")
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        Text("Aqui, cada pequeno hábito conta \n para grandes transformações.")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        NavigationLink(destination: Onboarding2()) {
                            Text("Começar")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.indigo)
                                .cornerRadius(26)
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
        .background(.white)
    }
}
#Preview {
    Onboarding1()
}
