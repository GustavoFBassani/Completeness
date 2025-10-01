//
//  ContentView.swift
//  CompletenessCompenion Watch App
//
//  Created by Gustavo Melleu on 01/10/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    NavigationLink(destination: DetailHabit()) {
                        CardHabit()
                    }
                    NavigationLink(destination: DetailHabit()) {
                        CardHabit()
                    }
                    NavigationLink(destination: DetailHabit()) {
                        CardHabit()
                    }
                }
                .padding()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Hábitos")
        }
        .buttonStyle(.plain)
    }
}
