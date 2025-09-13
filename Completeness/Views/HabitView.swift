//
//  HabitView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI

struct HabitView: View {
    @State private var intervalText = ""
    @State private var interval = 0
    @State private var notificationTitle = ""
    @State private var notificationBody = ""
    
    @State private var selectedTime = Date()
    @State private var repeatEveryday = true
    @State private var selectedWeekdays: Set<Int> = []
    
    let weekdays = [
        (1, "Domingo"),
        (2, "Segunda"),
        (3, "Terça"),
        (4, "Quarta"),
        (5, "Quinta"),
        (6, "Sexta"),
        (7, "Sábado")
    ]
    
    var body: some View {
        VStack{
            Text("Habit")
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
            
            Button {
                if let time = Int(intervalText), time > 0 {
                    interval = time
                    NotificationHelper.regressiveNotification(
                        title: notificationTitle,
                        body: notificationBody,
                        timeInterval: TimeInterval(interval)
                    )
                    print("Notificação agendada em \(interval) segundos")
                } else {
                    print("Digite um tempo válido")
                }
            } label: {
                Text("Agendar Notificação")
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
        .onAppear {
            NotificationHelper.requestNotificationPermissions()
        }
    }
}

#Preview() {
    HabitView()
}
