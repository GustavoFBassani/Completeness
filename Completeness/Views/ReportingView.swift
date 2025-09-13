//
//  ReportingView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 11/09/25.
//

import SwiftUI
import UserNotifications

struct ReportingView: View {
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
        NavigationView {
            VStack(spacing: 20) {
                DatePicker("Horário", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                
                Toggle("Repetir todos os dias", isOn: $repeatEveryday)
                    .padding(.horizontal)
                
                if !repeatEveryday {
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
                }
                
                Button(action: scheduleNotification) {
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
            .navigationTitle("Teste Notificação")
        }
    }
    
    private func scheduleNotification() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: selectedTime)
        let minute = calendar.component(.minute, from: selectedTime)
        
        if repeatEveryday {
            NotificationHelper.scheduledDailyNotification(
                title: "Lembrete Diário",
                body: "Hora marcada chegou!",
                hour: hour,
                minute: minute
            )
        } else {
            NotificationHelper.scheduledDailyNotification(
                title: "Lembrete Semanal",
                body: "Dia específico!",
                hour: hour,
                minute: minute,
                weekdays: Array(selectedWeekdays)
            )
        }
    }
}

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
    ReportingView()
}
