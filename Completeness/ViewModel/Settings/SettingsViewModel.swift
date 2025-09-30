import Foundation

@Observable
final class SettingsViewModel: SettingsViewModelProtocol, ObservableObject {
    let biometryKey = "isBiometryEnabled"
    var biometricManager: BiometricManagerProtocol
    let userDefaults: UserDefaults
    var showPermissionAlert = false
    var alertMessage = ""

    var isBiometryEnabled: Bool {
        didSet {
            userDefaults.set(isBiometryEnabled, forKey: biometryKey)
        }
    }

    init(biometricManager: BiometricManagerProtocol = BiometricManager.shared,
         userDefaults: UserDefaults = .standard) {
        self.biometricManager = biometricManager
        self.userDefaults = userDefaults
        self.isBiometryEnabled = userDefaults.bool(forKey: biometryKey)
    }
    
    func enableBiometry() async {
        do {
            try await biometricManager.authenticate()
            isBiometryEnabled = true
        } catch {
            alertMessage = error.localizedDescription
            showPermissionAlert = true
            isBiometryEnabled = false
        }
    }
}
