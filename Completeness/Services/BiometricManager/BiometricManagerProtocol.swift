//
//  BiometricManagerProtocol.swift
//  Completeness
//
//  Created by Vítor Bruno on 22/09/25.
//

import Foundation

protocol BiometricManagerProtocol {
    func authenticate() async throws
}
