//
//  WeekDayPicke.swift
//  Completeness
//
//  Created by Gustavo Melleu on 17/09/25.
//
import SwiftUI

struct WeekDayPicker: View {
    @Binding var selectedDate: Date
    
    // Alcance de semanas que podem ser navegadas (ex.: -52..+52 = ~2 anos)
    private let weeksRange: ClosedRange<Int> = -52...52
    @State private var currentWeekOffset: Int = 0
    private var calendar: Calendar { Calendar.current }
    
    // Layout constants para estabilidade visual
    private let horizontalPadding: CGFloat = 16
    private let itemSpacing: CGFloat = 8
    private let itemHeight: CGFloat = 62
    private let itemCornerRadius: CGFloat = 12
    private let topPadding: CGFloat = 6
    private let bottomPadding: CGFloat = -18
    
    var body: some View {
            TabView(selection: $currentWeekOffset) {
                ForEach(weeksRange, id: \.self) { offset in
                    GeometryReader { proxy in
                        // Calcula a largura exata para 7 itens + 6 espaçamentos
                        let availableWidth = max(0, proxy.size.width - (horizontalPadding * 2))
                        let totalSpacing = itemSpacing * 6
                        let rawItemWidth = (availableWidth - totalSpacing) / 7
                        let itemWidth = max(40, floor(rawItemWidth)) // largura mínima defensiva
                        
                        HStack(spacing: itemSpacing) {
                            ForEach(weekDays(for: offset), id: \.self) { date in
                                let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
                                
                                VStack(spacing: 4) {
                                    Text("\(calendar.component(.day, from: date))")
                                        .font(.headline)
                                        .foregroundColor(isSelected ? .indigo : .primary)
                                    
                                    Text(shortWeekdayFormatter.string(from: date).withoutDot.capitalized)
                                        .font(.caption)
                                        .foregroundColor(isSelected ? .indigo : .gray)
                                }
                                .frame(width: itemWidth, height: itemHeight)
                                .background(
                                    RoundedRectangle(cornerRadius: itemCornerRadius)
                                        .fill(Color.backgroundPrimary)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: itemCornerRadius)
                                        .stroke(isSelected ? Color.indigo : .clear, lineWidth: 2)
                                )
                                .contentShape(RoundedRectangle(cornerRadius: itemCornerRadius))
                                .onTapGesture {
                                    selectedDate = date
                                }
                            }
                        }
                        .padding(.horizontal, horizontalPadding)
                        .padding(.top, topPadding)       // espaço com o título
                        .padding(.bottom, bottomPadding) // evita corte na base
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
                    .tag(offset)
                }
            }
            .padding(.top, -20)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: itemHeight + topPadding + bottomPadding)
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
        // Força um Date válido (ambiente controlado)
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
