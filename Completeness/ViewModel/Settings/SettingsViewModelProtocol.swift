//
//  SettingsViewModelProtocol.swift
//  Completeness
//
//  Created by Vítor Bruno on 22/09/25.
//

import Foundation

protocol SettingsViewModelProtocol {
    /// Controla se a autenticação biométrica está habilitada.
    var isBiometryEnabled: Bool { get set }
    
    /// Controla a exibição de um alerta de permissão na tela.
    var showPermissionAlert: Bool { get set }
    
    /// A mensagem a ser exibida no alerta.
    var alertMessage: String { get set }
}
