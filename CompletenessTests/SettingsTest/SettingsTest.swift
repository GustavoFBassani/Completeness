//
//  SettingsTest.swift
//  CompletenessTests
//
//  Created by Vítor Bruno on 22/09/25.
//

import Foundation
import Testing
@testable import Completeness

struct SettingsTest {
    var userDefaults: UserDefaults!
    var mockBiometricManager: MockBiometricManager!
    var viewModel: SettingsViewModel!
    
    init() {
        userDefaults = UserDefaults(suiteName: "SettingsTest")
        userDefaults.removePersistentDomain(forName: "SettingsTest")
        
        mockBiometricManager = MockBiometricManager()
        
        viewModel = SettingsViewModel(
            biometricManager: mockBiometricManager,
            userDefaults: userDefaults
        )
    }
    
    @Test("Toggling isBiometryEnabled should save to UserDefaults")
    func testToggleSavesToUserDefaults() {
        viewModel.isBiometryEnabled = true
        
        let savedValue = userDefaults.bool(forKey: "isBiometryEnabled")
        #expect(savedValue == true)
        
        viewModel.isBiometryEnabled = false
        
        let savedValueAfterToggle = userDefaults.bool(forKey: "isBiometryEnabled")
        #expect(savedValueAfterToggle == false)
    }
    
    @Test("Enabling biometry with success should update property")
    func testEnableBiometry_Success() async {
        mockBiometricManager.shouldSucceed = true
        
        await viewModel.enableBiometry()
        
        #expect(mockBiometricManager.authenticateCalled == true, "A função authenticate() deveria ter sido chamada")
        #expect(viewModel.isBiometryEnabled == true, "Biometria deveria estar habilitada após sucesso")
        #expect(viewModel.showPermissionAlert == false, "Nenhum alerta deveria ser mostrado em caso de sucesso")
    }
    
    @Test("Enabling biometry with failure should show an alert")
    func testEnableBiometry_Failure() async {
        mockBiometricManager.shouldSucceed = false
        
        await viewModel.enableBiometry()
        
        #expect(mockBiometricManager.authenticateCalled == true)
        #expect(viewModel.isBiometryEnabled == false, "Biometria deveria permanecer desabilitada após falha")
        #expect(viewModel.showPermissionAlert == true, "Um alerta deveria ser mostrado em caso de falha")
        #expect(viewModel.alertMessage == BiometricManager.BiometricError.authenticationFailed.errorDescription)
    }
}
