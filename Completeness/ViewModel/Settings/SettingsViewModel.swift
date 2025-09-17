//
//  SettingsViewModel.swift
//  Completeness
//
//  Created by Vítor Bruno on 16/09/25.
//

import Foundation

@Observable
class SettingsViewModel: ObservableObject {
    private let biometryKey = "isBiometryEnabled"

    var biometricManager = BiometricManager.shared

    var showPermissionAlert = false
    var alertMessage = ""

    var isBiometryEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isBiometryEnabled, forKey: biometryKey)
        }
    }

    init() {
        self.isBiometryEnabled = UserDefaults.standard.bool(forKey: biometryKey)
    }
}
