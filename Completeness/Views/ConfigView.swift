//
//  ConfigView.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
//

import SwiftUI
import SwiftData

struct ConfigView: View {
    @AppStorage("dailyEnabled") private var dailyEnabled = true
    @AppStorage("timmerEnabled") private var timmerEnabled = true
    
    var body: some View {
        Form {
            Section(header: Text("Notificações")) {
                Toggle("Notificação Hábito diário", isOn: $dailyEnabled)
                Toggle("Notificação Hábito timmer", isOn: $timmerEnabled)
            }
            
            Button("Abrir Ajustes do Sistema") {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                }
            }
        }
        .navigationTitle("Configurações")
    }
}

#Preview {
    ConfigView()
}
