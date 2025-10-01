//
//  IconPickerViewModelTest.swift
//  Completeness
//
//  Created by Vítor Bruno on 01/10/25.
//

import Testing
@testable import Completeness

struct IconPickerViewModelTests {
    var viewModel: IconPickerViewModel!

    init() {
        viewModel = IconPickerViewModel()
    }
    
    @Test("Search results should be empty when search text is empty")
    mutating func testEmptySearch() {
        viewModel.searchText = ""
        
        let results = viewModel.searchResults
        
        #expect(results.isEmpty, "Search results should be empty for an empty query")
    }
    
    @Test("Search results should contain icons matching the query")
    mutating func testSearchWithResults() {
        viewModel.searchText = "run"
        
        let results = viewModel.searchResults
        
        #expect(results.contains("figure.run"), "Results should contain 'figure.run'")
        #expect(!results.contains("figure.walk"), "Results should not contain 'figure.walk'")
    }
    
    @Test("Search results should be empty for a query with no matches")
    mutating func testSearchWithNoResults() {
        viewModel.searchText = "xyznonexistenticon"
        
        let results = viewModel.searchResults
        
        #expect(results.isEmpty, "Search results should be empty for a non-matching query")
    }
    
    @Test("Search should be case-insensitive")
    mutating func testCaseInsensitiveSearch() {
        viewModel.searchText = "RUN"
        
        let results = viewModel.searchResults
        
        #expect(results.contains("figure.run"), "Search should find results regardless of case")
    }
}
