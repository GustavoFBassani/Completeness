//
//  NotificationHelper.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 11/09/25.
//

import Foundation
import UserNotifications

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
    
    static func scheduleNotification(title: String, body: String, timeInterval: TimeInterval) {
        
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
    
    
}
