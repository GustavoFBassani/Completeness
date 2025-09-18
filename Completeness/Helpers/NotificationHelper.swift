//
//  NotificationHelper.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 11/09/25.
//

import Foundation
import UserNotifications

/// Function to request notification permission.
/// This should be called inside `.onAppear` of the screen
/// where the notification will be scheduled to fire.
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
    
    /// Function that schedules a notification based on a countdown.
    static func regressiveNotification(
        title: String,
        body: String,
        timeInterval: TimeInterval
    ) {
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
    
    /// Function that schedules a daily notification.
    /// If no weekdays are provided, it schedules daily without restrictions.
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

        // If no weekdays are provided, schedule daily without weekday restriction
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
            // For each weekday, create a schedule
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
    
    static func scheduledOneTimeNotification(
        title: String,
        body: String,
        hour: Int,
        minute: Int
    ) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
    }
    
    static func stopAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
