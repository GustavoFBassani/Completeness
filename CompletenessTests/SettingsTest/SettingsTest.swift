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
    struct SettingsViewModelTests {
        var userDefaults: UserDefaults!
        var mockBiometricManager: MockBiometricManager!
        var viewModel: SettingsViewModel!
        
        init() {
            let suiteName = "SettingsViewModelTests"
            userDefaults = UserDefaults(suiteName: suiteName)
            userDefaults?.removePersistentDomain(forName: suiteName)
            
            mockBiometricManager = MockBiometricManager()
            
            viewModel = SettingsViewModel(
                biometricManager: mockBiometricManager,
                userDefaults: userDefaults
            )
        }
        
        @Test("Toggling isBiometryEnabled should save to UserDefaults")
        mutating func testToggleSavesToUserDefaults() {
            #expect(viewModel.isBiometryEnabled == false, "Biometry must start as disabled")
            
            viewModel.isBiometryEnabled = true
            
            let savedValue = userDefaults.bool(forKey: viewModel.biometryKey)
            #expect(savedValue == true, "True should have been saved")
        }
        
        @Test("Enabling biometry with success should update property")
        mutating func testEnableBiometry_Success() async {
            mockBiometricManager.shouldSucceed = true
            
            await viewModel.enableBiometry()
            
            #expect(mockBiometricManager.authenticateCalled == true, "authtenticate() should be called")
            #expect(viewModel.isBiometryEnabled == true, "Biometry should be enabled sucessfully")
            #expect(viewModel.showPermissionAlert == false, "No alerts should be shown")
        }
        
        @Test("Enabling biometry with failure should show an alert and disable biometry")
        mutating func testEnableBiometry_Failure() async {
            mockBiometricManager.shouldSucceed = false
            
            await viewModel.enableBiometry()
            
            #expect(mockBiometricManager.authenticateCalled == true)
            #expect(viewModel.isBiometryEnabled == false, "Biometry should be disabled in case of failure")
            #expect(viewModel.showPermissionAlert == true, "the alert should be shown")
            #expect(viewModel.alertMessage == BiometricManager.BiometricError.authenticationFailed.errorDescription)
        }
    }
}
