//
//  HabitView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI

struct notificationTest: View {
    @State private var intervalText = ""
    @State private var interval = 0
    @State private var notificationTitle = ""
    @State private var notificationBody = ""
  
    var body: some View {
        VStack{
            Text("Hábitos")
                .font(.title)
            TextField("Digite o tempo em segundos", text: $intervalText)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("Digite título da notificação", text: $notificationTitle)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            TextField("Digite o corpo da notificação", text: $notificationBody)
                .keyboardType(.default)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button(action: actionButtonTapped) {
                Text("Agendar Notificação")
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
        .task {
            let granted = await NotificationHelper.shared.requestNotificationPermissions()
            if granted {
                NotificationHelper.shared.setDelegate()
            }
        }
    }

    //PARA QUEM FOR TIRAR DO TESTE, COLOCAR ESTA FUNÇÃO NA VIEWMODEL ESPECÍFICA
    private func actionButtonTapped() {
        if UserDefaults.standard.bool(forKey: "notificationEnabled"){
            if let time = Int(intervalText), time > 0 {
                interval = time
                NotificationHelper.shared.regressiveNotification(
                    title: notificationTitle,
                    body: notificationBody,
                    timeInterval: TimeInterval(interval)
                )
                print("Notificação agendada em \(interval) segundos")
            } else {
                print("Digite um tempo válido")
            }
        }
    }
}

#Preview() {
    notificationTest()
}
