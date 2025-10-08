//
//  WeekDayPicke.swift
//  Completeness
//
//  Created by Gustavo Melleu on 17/09/25.
//
import SwiftUI

struct WeekDayPicker: View {
    @Binding var selectedDate: Date
    
    // Alcance de semanas navegáveis
    private let weeksRange: ClosedRange<Int> = -52...52
    @State private var currentWeekOffset = 0
    @Binding var hapticTrigger: Int
    private var calendar: Calendar { Calendar.current }
    
    var body: some View {
        TabView(selection: $currentWeekOffset) {
            ForEach(weeksRange, id: \.self) { offset in
                HStack(spacing: 12) {
                    ForEach(weekDays(for: offset), id: \.self) { date in
                        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                        
                        VStack {
                            Text("\(calendar.component(.day, from: date))")
                                .font(.headline)
                                .foregroundColor(isSelected ? .indigo : .primary)
                            
                            Text(shortWeekdayFormatter.string(from: date).withoutDot.capitalized)
                                .font(.caption)
                                .foregroundColor(isSelected ? .indigo : .gray)
                        }
                        .frame(width: 43, height: 62)
                        .background(Color.backgroundPrimary)
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
                            hapticTrigger += 1
                            selectedDate = date
                        }
                        .sensoryFeedback(.impact(weight: .light), trigger: hapticTrigger)
                    }
                }

                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .center)
                .tag(offset)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 83)
        .onAppear {
            currentWeekOffset = clampedOffset(for: selectedDate)
        }

        .onChange(of: selectedDate) { newValue in
            currentWeekOffset = clampedOffset(for: newValue)
        }
    }
    // MARK: - Helpers
    
    private func startOfWeek(for date: Date) -> Date {
        let comps = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: comps)!
    }
    
    private var baseStartOfWeek: Date {
        startOfWeek(for: Date())
    }
    
    private func weekStartDate(offset: Int) -> Date {
        calendar.date(byAdding: .weekOfYear, value: offset, to: baseStartOfWeek)!
    }
    
    private func weekDays(for offset: Int) -> [Date] {
        let start = weekStartDate(offset: offset)
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }
    
    private func weekOffset(for date: Date) -> Int {
        let base = baseStartOfWeek
        let target = startOfWeek(for: date)
        return calendar.dateComponents([.weekOfYear], from: base, to: target).weekOfYear ?? 0
    }
    
    private func clampedOffset(for date: Date) -> Int {
        let offset = weekOffset(for: date)
        return min(max(offset, weeksRange.lowerBound), weeksRange.upperBound)
    }
}

private let shortWeekdayFormatter: DateFormatter = {
    let df = DateFormatter()
    df.locale = Locale(identifier: "pt_BR")
    df.dateFormat = "EEE"
    return df
}()

extension String {
    var withoutDot: String {
        self.replacingOccurrences(of: ".", with: "")
    }
}
