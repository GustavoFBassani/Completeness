//
//  WeekDayPicke.swift
//  Completeness
//
//  Created by Gustavo Melleu on 17/09/25.
//
import SwiftUI

struct WeekDayPicker: View {
    @Binding var selectedDate: Date
    
    private var weekDays: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.date(
            from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today)
        )!
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: startOfWeek) }
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(weekDays, id: \.self) { date in
                let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                VStack {
                    Text("\(Calendar.current.component(.day, from: date))")
                        .font(.headline)
                        .foregroundColor(isSelected ? .indigo : .primary) 

                    Text(shortWeekdayFormatter.string(from: date).withoutDot.capitalized)
                        .font(.caption)
                        .foregroundColor(isSelected ? .indigo : .gray)
                }
                .frame(width: 43, height: 62)
                .background(.backgroundPrimary)
                .cornerRadius(12)
                .overlay(
                    Group {
                        if isSelected {
                                RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.indigo, lineWidth: 2)
                              }
                    }
                )
                .onTapGesture {
                    selectedDate = date
                }
            }
        }
        .padding(.horizontal)
    }
}

private let shortWeekdayFormatter: DateFormatter = {
    let df = DateFormatter()
    df.locale = Locale(identifier: "pt_BR")
    df.dateFormat = "EEE"
    return df
}()

// para remover o ponto
extension String {
    var withoutDot: String {
        self.replacingOccurrences(of: ".", with: "")
    }
}
