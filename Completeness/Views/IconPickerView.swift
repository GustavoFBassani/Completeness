//
//  IconPickerView.swift
//  Completeness
//
//  Created by Vítor Bruno on 30/09/25.
//

import SwiftUI

struct IconPickerView: View {
    @Binding var selectedIcon: String
    @State var viewModel: IconPickerViewModelProtocol = IconPickerViewModel()
    @Environment(\.dismiss) var dismiss
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 5)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if !viewModel.searchText.isEmpty { //if the textSearch is'n empty
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.searchResults, id: \.self) { icon in
                            iconButton(for: icon)
                        }
                    }
                    .padding()
                } else {
                    ForEach(viewModel.allCategories, id: \.id) { category in
                        VStack(alignment: .leading) {
                            Text(category.name)
                                .font(.headline)
                            
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(category.icons, id: \.self) { icon in
                                    iconButton(for: icon)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color.backgroundSecondary)
            .navigationTitle("Ícone")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Buscar")
        }
    }
    private func iconButton(for iconName: String) -> some View {
            Button(action: {
                selectedIcon = iconName
                dismiss()
            }) {
                Image(systemName: iconName)
                    .font(.title)
                    .frame(maxWidth: .infinity, minHeight: 60)
                    .background(.backgroundPrimary)
                    .foregroundStyle(.indigoCustom)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
        }
}

#Preview {
}
