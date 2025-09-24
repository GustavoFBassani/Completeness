//
//  HabitSectionView.swift
//  Completeness
//
//  Created by Gustavo Melleu on 23/09/25.
//

import SwiftUI

struct HabitSectionView: View {
    let title: String
    let habits: [PredefinedHabits]
    
    @State private var showMore = false
    
    var body: some View {
        Text(title)
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.secondary)
            .padding(.leading, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        //padding negativo eu sei :(
            .padding(.bottom , -10)
        VStack(alignment: .leading, spacing: 0) {
            // lista de hábitos
            ForEach(showMore ? habits : Array(habits.prefix(3))) { habit in
                HStack {
                    Image(systemName: habit.habitSimbol)
                        .foregroundColor(.indigoCustom)
                    Text(habit.habitName)
                        .foregroundColor(.primary)
                    Spacer()
                    Text("Detalhes")
                        .foregroundColor(.gray)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                 Divider()
                    .padding(.horizontal,16)
            }
            // botão ver mais
            if habits.count > 3 {
                Button {
                    withAnimation {
                        showMore.toggle()
                    }
                }
                label: {
                    Text(showMore ? "Ver menos" : "Ver mais")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
            }
            Spacer()
        }
        .background(.backgroundPrimary)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
