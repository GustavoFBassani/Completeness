//
//  BiometricManager.swift
//  Completeness
//
//  Created by Vítor Bruno on 16/09/25.
//

import Foundation
import LocalAuthentication

@Observable
class BiometricManager {
    static let shared = BiometricManager()

    enum BiometricError: LocalizedError {
        case authenticationFailed
        case userCancelled
        case biometricNotAvailable
        case biometricLockout
        case unknown

        var errorDescription: String? {
            switch self {
            case .authenticationFailed: return "Falha na autenticação."
            case .userCancelled: return "Autenticação cancelada pelo usuário."
            case .biometricNotAvailable: return "Face ID/Touch ID não disponível neste dispositivo."
            case .biometricLockout: return "Face ID/Touch ID bloqueado por muitas tentativas. Tente novamente mais tarde."
            case .unknown: return "Ocorreu um erro desconhecido."
            }
        }
    }

    func authenticate() async throws {
        let context = LAContext()
        let reason = "Você configurou para inicar o app utilizando o FaceID ou TouchID"
        var error: NSError?

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            throw BiometricError.biometricNotAvailable
        }

        do {
            let success = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                                           localizedReason: reason)
            if !success {
                throw BiometricError.authenticationFailed
            }
        } catch let authError as LAError {
            switch authError.code {
            case .userCancel:
                throw BiometricError.userCancelled
            case .biometryNotAvailable:
                throw BiometricError.biometricNotAvailable
            case .biometryLockout:
                throw BiometricError.biometricLockout
            default:
                throw BiometricError.unknown
            }
        } catch {
            throw BiometricError.unknown
        }
    }
}
