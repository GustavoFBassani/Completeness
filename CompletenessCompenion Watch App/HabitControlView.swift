//
//  SwiftUIView.swift
//  CompletenessCompenion Watch App
//
//  Created by Vítor Bruno on 08/10/25.
//

import SwiftUI

struct HabitControlView: View {
    @State var progresso = 2
    @State var maxProgresso = 5
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Ler páginas")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.indigo)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer()
                
                HStack(spacing: 15) {
                    if #available(watchOS 26.0, *) {
                        Button() {
                            
                        } label: {
                            Image(systemName: "minus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                        .glassEffect()
                    } else {
                        Button() {} label: {
                            Image(systemName: "minus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                    }
                    
                    VStack{
                        Text("\(progresso)/\(maxProgresso)")
                            .font(.title.bold())
                            .foregroundStyle(.primary)
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.indigoCustomSecondary)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.indigo)
                                .frame(width: 64 * (Double(progresso) / Double(maxProgresso)))
                        }
                        .frame(width: 64, height: 5)
                        .padding(-8)
                    }
                    
                    
                    
                    if #available(watchOS 26.0, *) {
                        Button() {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                        .glassEffect()
                    } else {
                        Button() {
                            
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 24).bold())
                        }
                        .clipShape(.circle)
                        .contentShape(.circle)
                        .frame(width: 44.5, height: 44.5)
                    }
                    
                }
                
                Spacer()
                
                if #available(watchOS 26.0, *) {
                    Button() {
                        
                    } label : {
                        Text("Preencher Meta")
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                    .glassEffect()
                } else {
                    Button() {
                        
                    } label : {
                        Text("Preencher Meta")
                            .foregroundStyle(.primary)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(.indigoCustom)
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
        
        
    }
}

#Preview {
    HabitControlView()
}
