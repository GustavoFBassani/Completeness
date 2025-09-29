//
//  NotificationHelper.swift
//  Completeness
//
//  Created by Pablo Garcia-Dev on 11/09/25.
//

import Foundation
import UserNotifications
import UIKit

final class NotificationHelper: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationHelper()
    
    private let center = UNUserNotificationCenter.current()
    private let enabledKey = "notificationEnabled"
    private let badgeKey = "badgeEnabled"
    private let permissionKey = "notificationPermissionGranted"

    override private init() {
        super.init()
        center.delegate = self
    }

    // MARK: - UserDefaults Helpers
    var isEnabled: Bool {
        UserDefaults.standard.bool(forKey: enabledKey)
    }
    
    var isPermissionGranted: Bool {
        UserDefaults.standard.bool(forKey: permissionKey)
    }

    var isBadgeEnabled: Bool {
        UserDefaults.standard.bool(forKey: badgeKey)
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

    func setDelegate() {
        center.delegate = self
    }

    // MARK: - Scheduling

    /// Function that schedules a notification based on a countdown.
    func regressiveNotification(
        title: String,
        body: String,
        timeInterval: TimeInterval
    ) {
        guard isEnabled else { return }

        let content = makeContent(title: title, body: body)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(1, timeInterval), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print("Notificação de contagem regressiva agendada")
        center.add(request, withCompletionHandler: nil)
    }

    /// Function that schedules a daily notification.
    /// If no weekdays are provided, it schedules daily without restrictions.
    func scheduledDailyNotification(
        title: String,
        body: String,
        hour: Int,
        minute: Int,
        weekdays: [Int] = []
    ) {
        guard isEnabled else { return }

        let content = makeContent(title: title, body: body)

        if weekdays.isEmpty {
            var comps = DateComponents()
            comps.hour = hour
            comps.minute = minute
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            print("Notificação diária agendada")
            center.add(request, withCompletionHandler: nil)
        } else {
            weekdays.forEach { wk in
                var comps = DateComponents()
                comps.hour = hour
                comps.minute = minute
                comps.weekday = wk
                let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: true)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                print("Notificação agendada para o dia \(wk)")
                center.add(request, withCompletionHandler: nil)
            }
        }
    }

    /// Function that schedules a one-time notification at specific time (today).
    func scheduledOneTimeNotification(
        title: String,
        body: String,
        hour: Int,
        minute: Int
    ) {
        guard isEnabled else { return }

        var comps = DateComponents()
        comps.hour = hour
        comps.minute = minute

        let content = makeContent(title: title, body: body)
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print("Notificação única agendada")
        center.add(request, withCompletionHandler: nil)
    }

    /// Remove all pending and delivered notifications.
    func stopAllNotifications() {
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
    }

    // MARK: - Helpers
    private func makeContent(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        if isBadgeEnabled {
            let current = UIApplication.shared.applicationIconBadgeNumber
            content.badge = NSNumber(value: max(0, current) + 1)
        }
        content.sound = .default
        return content
    }

    // MARK: - UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        guard isEnabled && isPermissionGranted else {
            completionHandler([])
            return
        }
        var options: UNNotificationPresentationOptions = [.sound, .banner, .list]
        if isBadgeEnabled {
            options.insert(.badge)
        }
        completionHandler(options)
    }
}
