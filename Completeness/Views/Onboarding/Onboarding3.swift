//
//  Onboarding3.swift
//  Completeness
//
//  Created by Gustavo Melleu on 26/09/25.
//

import SwiftUI

import SwiftUI

struct Onboarding3: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    var body: some View {
        ZStack {
            Image("Frame 1")
                .scaledToFill()
                .ignoresSafeArea()
                .padding(.bottom ,90)
                .opacity(0.3)
            Image("Group 2")
                .scaledToFill()
                .ignoresSafeArea()
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
                        Text("Acompanhe\nseu progresso")
                            .font(.system(size: 28, weight: .bold))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        Text("Veja resumos semanais e gerais que mostram sua evolução")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        NavigationLink(destination: Onboarding4()) {
                            Text("Continuar")
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
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    Onboarding3()
}
