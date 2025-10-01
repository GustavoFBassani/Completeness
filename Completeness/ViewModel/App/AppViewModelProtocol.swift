//
//  AppViewModelProtocol.swift
//  Completeness
//
//  Created by Vítor Bruno on 01/10/25.
//

import Foundation

protocol AppViewModelProtocol {
    var isAuthenticated: Bool { get }
    
    var errorMessage: String? { get }
    
    func autenticateIfNeeded() async
}
