//
//  NotificationHelper.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 11/09/25.
//

import Foundation
import UserNotifications
import UIKit

 class NotificationHelper: NSObject {
    private let center = UNUserNotificationCenter.current()
    private let permissionKey = "notificationPermissionGranted"
     
    override init() {
        super.init()
    }

    // MARK: - UserDefaults Helpers
    
    var isPermissionGranted: Bool {
        UserDefaults.standard.bool(forKey: permissionKey)
    }

    // MARK: - Permissions
    @discardableResult
    func requestNotificationPermissions() async -> Bool {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .sound, .badge])
            UserDefaults.standard.set(granted, forKey: permissionKey)
            print("Notificações permitidas")
            return granted
        } catch {
            UserDefaults.standard.set(false, forKey: permissionKey)
            print("Notificações desabilitadas")
            return false
        }
    }

    // MARK: - Scheduling

    /// Function that schedules a notification based on a countdown.
    func regressiveNotification(
        title: String,
        body: String,
        timeInterval: TimeInterval
    ) {
        let content = makeContent(title: title, body: body)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print("Notificação de contagem regressiva agendada")
        center.add(request, withCompletionHandler: nil)
    }
     
     func weeklyNotification(
         title: String,
         body: String
     ) {
         let content = makeContent(title: title, body: body)

         var comps = DateComponents()
         comps.hour = 12
         comps.minute = 12
         comps.weekday = 2

         let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
         let request = UNNotificationRequest(
             identifier: "weeklyNotification",
             content: content,
             trigger: trigger
         )
         print("Notificação semanal agendada: \(comps)")
         center.add(request, withCompletionHandler: nil)
     }

     // MARK: - Recurrency notifications
     
     func nightlyNotification(
        title: String,
        body: String
     ) {
        let content = makeContent(title: title, body: body)

        var comps = DateComponents()
         comps.hour = 21
         comps.minute = 21
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        let request = UNNotificationRequest(
            identifier: "nightlyNotification",
            content: content,
            trigger: trigger)
        print("Notificação noturna agendada: \(comps)")
        center.add(request, withCompletionHandler: nil)
    }

     func dailyNotification(
        title: String,
        body: String
    ) {
        let content = makeContent(title: title, body: body)

        var comps = DateComponents()
        comps.hour = 17
        comps.minute = 17
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
        let request = UNNotificationRequest(
            identifier: "dailyNotification",
            content: content,
            trigger: trigger)
        print("Notificação diurna agendada: \(comps)")
        center.add(request, withCompletionHandler: nil)
    }

     // MARK: - Remove Notifications functions
    /// Remove all pending and delivered notifications.
    func stopAllNotifications() {
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
        print("TODAS notificações apagadas")
    }
     
     /// Functions for remove específic notifications
     func removeWeeklyNotification() {
         center.removePendingNotificationRequests(withIdentifiers: ["weeklyNotification"])
         center.removeDeliveredNotifications(withIdentifiers: ["weeklyNotification"])
         print("Notificações semanais apagadas")
     }

     func removeNightlyNotification() {
         center.removePendingNotificationRequests(withIdentifiers: ["nightlyNotification"])
         center.removeDeliveredNotifications(withIdentifiers: ["nightlyNotification"])
         print("Notificações noturnas apagadas")
     }

     func removeDailyNotification() {
         center.removePendingNotificationRequests(withIdentifiers: ["dailyNotification"])
         center.removeDeliveredNotifications(withIdentifiers: ["dailyNotification"])
         print("Notificações diurnas apagadas")
     }

    // MARK: - Helpers
    private func makeContent(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body

        let current = UIApplication.shared.applicationIconBadgeNumber
        content.badge = NSNumber(value: max(0, current) + 1)

        content.sound = .default
        return content
    }
}
