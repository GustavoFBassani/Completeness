//
//  TemplateView.swift
//  Completeness
//
//  Created by Gustavo on 10/09/2025.
//

import SwiftUI

struct TemplateView: View {
    
    // MARK: - Dependencies
    //let viewModel: ViewModel
    
    // MARK: - Environment
    @Environment(\.modelContext) var context
    
    // MARK: - State
    @State private var showDetails: Bool = false
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("")
                .task {
//                    await viewModel.loadData()
                }
                .sheet(isPresented: $showDetails) {
                    // Detail view goes here
                }
        }
    }
    
    // MARK: - Content
    @ViewBuilder
    private var content: some View {
//        switch viewModel.state {
//        case .idle:
//            Color.clear
//        case .loading:
//            ProgressView()
//        case .error:
//            // Error view placeholder
//            EmptyView()
//        case .loaded:
//            // Loaded view placeholder
//            EmptyView()
//        }
    }
}

// MARK: - Preview
//#Preview {
//    TemplateView(viewModel: TemplateViewModel.preview)
//}
