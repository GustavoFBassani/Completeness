//
//  NotificationHelper.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 11/09/25.
//

import Foundation
import UserNotifications

    // MARK: - Função para solicitar permissão de envio de notificação, ela deve estar no .onApper da tela onde a notificação criada para ser disparada.
struct NotificationHelper {
    static func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            if granted {
                    print(">>> Notification permission granted.")
            } else {
                print(">>> Notification permission denied.")
            }
        }
    }
    
    // MARK: - Função que agenda uma notificação partindo de uma contagem regressiva
    static func regressiveNotification(title: String, body: String, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.launchImageName = "LaunchImage"
        content.badge = 1 as NSNumber
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print(">>> Notification scheduled.")
            }
        }
    }
    
    static func scheduledDailyNotification(
        title: String,
        body: String,
        hour: Int,
        minute: Int,
        weekdays: [Int] = []
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        content.badge = 1

        // Se não vier dia da semana, agenda diário sem restrição de weekday
        if weekdays.isEmpty {
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print(">>> Daily notification scheduled.")
                }
            }
        } else {
            // Para cada dia da semana, cria um agendamento
            weekdays.forEach { wk in
                var dateComponents = DateComponents()
                dateComponents.hour = hour
                dateComponents.minute = minute
                dateComponents.weekday = wk // 1 = Sunday, 2 = Monday, ... 7 = Saturday
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let request = UNNotificationRequest(
                    identifier: UUID().uuidString,
                    content: content,
                    trigger: trigger
                )
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification for weekday \(wk): \(error)")
                    } else {
                        print(">>> Notification scheduled for weekday \(wk).")
                    }
                }
            }
        }
    }
    
    
}
