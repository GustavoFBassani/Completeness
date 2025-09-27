//
//  StatsEmptyView.swift
//  Completeness
//
//  Created by Vítor Bruno on 25/09/25.
//

import SwiftUI

struct StatsEmptyView: View {
    var body: some View {
        VStack(spacing: 8){
            Image(systemName: "nosign")
                .foregroundStyle(.labelTertiary)
                .font(.system(size: 50.32).bold())
            
            Text("Acompanhe seu progresso semanal")
                .font(.title.bold())
                .multilineTextAlignment(.center)
                .foregroundColor(Color.labelTertiary)
            
            Text("Conclua sua primeira semana de hábitos e você verá o resumo sobre sua evolução aqui.")
                .font(.footnote)
                .foregroundStyle(.labelTertiary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    StatsEmptyView()
}
