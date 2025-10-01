//
//  IconPickerViewModelProtocol.swift
//  Completeness
//
//  Created by Vítor Bruno on 30/09/25.
//

import Foundation

protocol IconPickerViewModelProtocol: Observable {
    var searchText: String { get set }
    var searchResults: [String] { get }
    var allCategories: [IconCategory] { get }
}
