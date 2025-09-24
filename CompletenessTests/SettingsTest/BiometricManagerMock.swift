//
//  BiometricManagerMock.swift
//  CompletenessTests
//
//  Created by Vítor Bruno on 22/09/25.
//

import Foundation
@testable import Completeness

class MockBiometricManager: BiometricManagerProtocol {
    var shouldSucceed = true
    var authenticateCalled = false
    
    func authenticate() async throws {
        authenticateCalled = true
        if !shouldSucceed {
            throw BiometricManager.BiometricError.authenticationFailed
        }
    }
}
