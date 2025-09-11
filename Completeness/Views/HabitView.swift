//
//  HabitView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI

struct HabitView: View {
    var body: some View {
        VStack{
            Text("Habit")
            
            Button {
                NotificationHelper.scheduleNotification(title: "Título Teste", body: "Corpo de teste", timeInterval: 5)
                print("Botão clicado")
            } label: {
                Text("Notificação em 5 segundos")
                    .padding(6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            NotificationHelper.requestNotificationPermissions()
        }
    }
}

#Preview {
    HabitView()
}
