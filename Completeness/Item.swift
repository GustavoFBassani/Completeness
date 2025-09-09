//
//  Item.swift
//  Completeness
//
//  Created by Gustavo Ferreira bassani on 09/09/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
