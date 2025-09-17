//
//  TemplateViewModel.swift
//  Completeness
//
//  Created by Gustavo Ferreira Bassani on 10/09/2025.
//

import SwiftUI
import Observation

// MARK: - State
enum TemplateState {
    case idle
    case loading
    case error
    case loaded
}

// MARK: - ViewModel
@Observable
final class TemplateViewModel: TemplateProtocol {
    // MARK: - Properties
    var state: TemplateState = .idle
    var errorMessage: String?
    // MARK: - Init
    init() {
        // Setup dependencies here
    }
    // MARK: - Functions
    func loadData() async {
        // Async data loading logic goes here

    }
}
