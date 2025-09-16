//
//  AppViewModel.swift
//  Completeness
//
//  Created by Vítor Bruno on 16/09/25.
//

import Foundation

@Observable
class AppViewModel {
    var isAuthenticated = false
    var errorMessage: String?

    var isBiometryEnabled: Bool {
        return UserDefaults.standard.bool(forKey: "isBiometryEnabled")
    }

    var biometricManager = BiometricManager.shared

    func autenticateIfNeeded() async {
        guard isBiometryEnabled else {
            self.isAuthenticated = true
            return
        }

        do {
            try await biometricManager.authenticate()
            self.isAuthenticated = true
            self.errorMessage = nil
        } catch {
            self.isAuthenticated = false
            self.errorMessage = error.localizedDescription
        }
    }
}
