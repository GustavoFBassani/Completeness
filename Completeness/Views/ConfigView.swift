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
@AppStorage("selectedTheme") private var selectedTheme = "system"
@AppStorage("faceIDEnabled") private var faceIDEnabled = false

@State private var showError = false
@State private var errorMessage = ""
    
var body: some View {
Form {
    Section(header: Text("Geral")) {
        HStack{
            Image(systemName: "flag.fill")
                .foregroundStyle(.indigoCustom)
            Text("idioma")
        }
        HStack {
            Image(systemName: "faceid")
                .foregroundStyle(.indigoCustom)
            Toggle("Face ID", isOn: Binding(
                get: { faceIDEnabled },
                    set: { newValue in
            Task {
                if newValue {
                    do {
                try await BiometricManager.shared.authenticate()
                    faceIDEnabled = true
                    } catch {
                faceIDEnabled = false
                errorMessage = error.localizedDescription
                showError = true
                    }
                } else {
                    faceIDEnabled = false
                    }
                }
                    }
                ))
            }
//        HStack{
//            Image(systemName: "paintpalette.fill")
//                .foregroundStyle(.indigoCustom)
//            Text("Aparência")
//        }
        HStack {
            Image(systemName: "paintpalette.fill")
                .foregroundStyle(.indigo)
            Text("Aparência")
            
            Spacer()
            
            Picker("", selection: $selectedTheme) {
                Text("Automático").tag("system")
                Text("Modo claro").tag("light")
                Text("Modo escuro").tag("dark")
            }
            .pickerStyle(.menu)
            .labelsHidden()
        }
    }
    
    Section(header: Text("Notificações")) {
        HStack{
            Image(systemName: "app.badge")
                .foregroundStyle(.indigoCustom)
            Toggle("Avisos", isOn: $timmerEnabled)
        }
        HStack{
            Image(systemName: "bell.badge")
                .foregroundStyle(.indigoCustom)
            Toggle("Permitir notificações", isOn: $dailyEnabled)
        }
    }
    
    Section(header: Text("Sobre nós")) {
        HStack{
            Image(systemName: "star.fill")
                .foregroundStyle(.indigoCustom)
            Text("Avalie")
        }
        HStack{
                Image(systemName: "phone.fill")
                    .foregroundStyle(.indigoCustom)
                Text("Fale conosco")
            }
        HStack{
            Image(systemName: "text.document")
                .foregroundStyle(.indigoCustom)
            Text("Termos de privacidade")
            }
    }
//            Button("Abrir Ajustes do Sistema") {
//                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
//                    UIApplication.shared.open(appSettings)
//                }
//            }
}
.navigationTitle("Configurações")
}
}

#Preview {
ConfigView()
}
