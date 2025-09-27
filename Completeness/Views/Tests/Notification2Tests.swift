//
//  ReportingView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI
import UserNotifications

struct Notification2Tests: View {
    @State private var selectedTime = Date()
    @State private var repeatEveryday = true
    @State private var selectedWeekdays: Set<Int> = []
    @State private var notificationTitle = ""
    @State private var notificationBody = ""

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
        NavigationView {
            VStack(spacing: 20) {
                TextField("Digite título da notificação", text: $notificationTitle)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                TextField("Digite o corpo da notificação", text: $notificationBody)
                    .keyboardType(.default)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                DatePicker("Horário", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()


                    List(weekdays, id: \.0) { day in
                        MultipleSelectionRow(
                            title: day.1,
                            isSelected: selectedWeekdays.contains(day.0)
                        ) {
                            if selectedWeekdays.contains(day.0) {
                                selectedWeekdays.remove(day.0)
                            } else {
                                selectedWeekdays.insert(day.0)
                            }
                        }
                    }
                    .frame(maxHeight: 250)
                
                Button(action: buttonTapped) {
                    Text("Agendar Notificação")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                Spacer()
            }
//            .navigationTitle("Teste Notificação")
            .onAppear {
                NotificationHelper.requestNotificationPermissions()
                NotificationHelper.requestNotificationPermissionsBadge()
            }
        }
    }
    
    //PARA QUEM FOR TIRAR DO TESTE, COLOCAR ESTA FUNÇÃO NA VIEWMODEL ESPECÍFICA
    private func buttonTapped() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: selectedTime)
        let minute = calendar.component(.minute, from: selectedTime)
        
        if UserDefaults.standard.bool(forKey: "notificationEnabled") {
            NotificationHelper.scheduledDailyNotification(
                title: notificationTitle,
                body: notificationBody,
                hour: hour,
                minute: minute,
                weekdays: Array(selectedWeekdays)
            )
        }
    }
}

// MARK: - Desnecessário, por isto não está em um arquivo separado
struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}


#Preview {
    Notification2Tests()
}
