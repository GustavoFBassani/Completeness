//
//  ConfigView.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 15/09/25.
//

import SwiftUI
import SwiftData

struct ConfigView: View {
    @AppStorage("notificationEnabled") private var notificationEnabled = true
    @AppStorage("badgeEnabled") private var badgeEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme = "system"
    @AppStorage("faceIDEnabled") private var faceIDEnabled = false
    @AppStorage("selectedLanguage") private var selectedLanguage = "pt"
    
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var showPrivacyPolicy = false
    
    var body: some View {
        Form {
            Section(header: Text("Geral")) {
//                HStack {
//                    Image(systemName: "flag.fill")
//                        .foregroundStyle(.indigoCustom)
//                    Text("Idioma")
//
//                    Spacer()
//
//                    Picker("", selection: $selectedLanguage) {
//                        Text("Português").tag("pt")
//                        Text("Inglês").tag("en")
//                    }
//                    .foregroundStyle(.labelSecondary)
//                    .pickerStyle(.menu)
//                    .labelsHidden()
//                    .tint(.labelSecondary)
//                }
                
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
                    .tint(.green)
                }
                
                
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
                    .tint(.labelSecondary)
                }
            }
            
            Section(header: Text("Notificações")) {
                HStack {
                    Image(systemName: "app.badge")
                        .foregroundStyle(.indigoCustom)
                    Toggle("Avisos", isOn: $badgeEnabled)
                }
                .tint(.green)
                
                HStack {
                    Image(systemName: "bell.badge")
                        .foregroundStyle(.indigoCustom)
                    Toggle("Permitir notificações", isOn: Binding(
                        get: { notificationEnabled },
                        set: { newValue in
                            Task {
                                if newValue {
                                    let granted = await NotificationHelper.shared.requestNotificationPermissions()
                                    if !granted {
                                        // Reverte a chave se o usuário negar
                                        notificationEnabled = false
                                        errorMessage = "Permissão de notificação negada nas Configurações do sistema."
                                        showError = true
                                    } else {
                                        notificationEnabled = true
                                        // Garante que sejamos delegate para controlar apresentação em primeiro plano
                                        NotificationHelper.shared.setDelegate()
                                    }
                                } else {
                                    notificationEnabled = false
                                    NotificationHelper.shared.stopAllNotifications()
                                    try? await UNUserNotificationCenter.current().setBadgeCount(0)
                                }
                            }
                        }
                    ))
                }
                .tint(.green)
            }
        
            Section(header: Text("Sobre nós")) {
//                Link(destination: URL(string: "https://apps.apple.com")!) {
//                    HStack {
//                        Image(systemName: "star.fill")
//                            .foregroundStyle(.indigoCustom)
//                        Text("Avalie")
//                            .foregroundColor(.primary)
//                        Spacer()
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.gray)
//                    }
//                }
                Button {
                    if let url = URL(string: "https://wa.me/5551983385200") {
                        UIApplication.shared.open(url)
                    }
                } label: {
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundStyle(.indigoCustom)
                        Text("Fale conosco")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }

                Button {
                    showPrivacyPolicy = true
                } label: {
                    HStack {
                        Image(systemName: "text.document")
                            .foregroundStyle(.indigoCustom)
                        Text("Termos de privacidade")
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationTitle("Configurações")
        .onAppear { NotificationHelper.shared.setDelegate() }
        .alert("Erro", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
        .sheet(isPresented: $showPrivacyPolicy) {
            PrivacyPolicyView()
        }
    }
}

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Política de Privacidade – Completeness")
                        .font(.title2).bold()
                    
                    Text("""
                    Sua privacidade é importante para nós. Esta Política de Privacidade descreve como coletamos, usamos e protegemos suas informações ao utilizar o Completeness.

                    1. Coleta de Informações

                    O Completeness foi projetado para ajudá-lo a acompanhar seus hábitos de forma simples.
                    Informações pessoais: não coletamos informações pessoais como nome, e-mail ou telefone, a menos que você as forneça voluntariamente
                    (por exemplo, ao criar uma conta).
                    Dados de uso: podemos coletar informações anônimas, como tempo de uso do aplicativo, frequência de abertura e estatísticas gerais,
                    apenas para melhorar a experiência do usuário.
                    Dados armazenados localmente: seus hábitos e registros ficam salvos localmente no dispositivo. Caso haja integração com iCloud,
                    esses dados poderão ser sincronizados entre seus aparelhos Apple.

                    2. Uso das Informações

                    As informações coletadas são utilizadas para:
                    Fornecer as funcionalidades principais do aplicativo;
                    Melhorar a experiência do usuário;
                    Corrigir falhas e manter a estabilidade do serviço.

                    3. Compartilhamento de Informações

                    Não compartilhamos, vendemos ou alugamos seus dados pessoais a terceiros.
                    Em caso de sincronização via iCloud ou outros serviços Apple, a gestão e proteção seguem as políticas da Apple.

                    4. Armazenamento e Segurança
                    Seus dados ficam protegidos nos servidores da Apple (quando armazenados via iCloud) ou localmente no dispositivo.
                    Adotamos medidas técnicas adequadas para proteger suas informações, mas não podemos garantir segurança absoluta contra todas as ameaças digitais.

                    5. Direitos do Usuário

                    Você pode, a qualquer momento:
                    Excluir seus dados diretamente no aplicativo;
                    Solicitar informações sobre os dados coletados;
                    Revogar permissões concedidas.

                    6. Alterações nesta Política

                    Podemos atualizar esta Política de Privacidade periodicamente. Recomendamos que você revise este documento regularmente para estar ciente de como protegemos suas informações.

                    7. Contato

                    Se tiver dúvidas ou solicitações relacionadas à privacidade, entre em contato pelo e-mail: [suportecompleteness@gmail.com].
                    """)
                }
                .padding()
            }
            .navigationTitle("Termos de privacidade")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.semibold))
                    }
                }
            }
        }
    }
}

#Preview {
    ConfigView()
}
