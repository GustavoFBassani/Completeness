//
//  ConfigTest.swift
//  Completeness
//
//  Created by Gustavo Melleu on 16/09/25.
//

import SwiftUI

struct ConfigTest: View {
    @AppStorage("selectedTheme") private var selectedTheme = "system"
    var body: some View {
        HStack{
            Text("Escolha um tema")
            VStack {
                Picker("Tema", selection: $selectedTheme){
                    Text("Claro") .tag("light")
                    Text("Escuro") .tag("dark")
                }
                .pickerStyle(.segmented)
            }
        }
        .padding()
        .navigationTitle("Settings")
    }
}
#Preview {
    ConfigTest()
}
