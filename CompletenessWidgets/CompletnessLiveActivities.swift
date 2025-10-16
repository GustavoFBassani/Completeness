//
//  CompletnessLiveActivities.swift
//  Completeness
//
//  Created by Vítor Bruno on 13/10/25.
//

import Foundation
import ActivityKit
import WidgetKit
import SwiftUI

struct timerActivityAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var timePassed: Int
        var isRunning: Bool
    }
    
    var habitName: String
    var habitDuration: Int
    var habitIcon: String
}

struct timerLiveActivityWidget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: timerActivityAttributes.self) { context in
            VStack(alignment: .leading, spacing: 8){
                HStack{
                    Image(systemName: context.attributes.habitIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.indigoCustom)
                        .frame(width: 45, height: 45)
                    
                    Text(context.attributes.habitName)
                        .font(.title3.bold())
                        .foregroundStyle(.indigoCustom)
                }
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 45)
                        .foregroundStyle(.indigoCustom.opacity(0.3))
                        .frame(height: 12)
                    
                    RoundedRectangle(cornerRadius: 45)
                        .foregroundStyle(.indigoCustom)
                        .frame(
                            width: {
                                let totalWidth: CGFloat = 300
                                let maxValue = max(1, context.attributes.habitDuration)
                                let progress = CGFloat(context.state.timePassed) / CGFloat(maxValue)
                                return totalWidth * min(progress, 1.0) // Garante que não passe de 100%
                            }(),
                            height: 12
                        )
                }
                .frame(width: 300)
            }
            .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: context.attributes.habitIcon)
                        .resizable()
                        .padding(.top)
                        .padding(.leading)
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.indigoCustom)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.attributes.habitName)
                        .font(.headline)
                        .foregroundStyle(.indigoCustom)
                        .padding(.top)
                        .padding(.trailing)
                        .frame(maxWidth: .infinity)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 45)
                            .foregroundStyle(.indigoCustom.opacity(0.3))
                            .frame(height: 8)
                        
                        RoundedRectangle(cornerRadius: 45)
                            .foregroundStyle(.indigoCustom)
                            .frame(width: {
                                let totalWidth: CGFloat = 180
                                let maxValue = max(1, context.attributes.habitDuration)
                                let progress = CGFloat(context.state.timePassed) / CGFloat(maxValue)
                                return totalWidth * min(progress, 1.0)
                            }(), height: 8)
                    }
                    .padding(.horizontal)
                }
            } compactLeading: {
                Image(systemName: context.attributes.habitIcon)
                    .foregroundStyle(.indigoCustom)
            } compactTrailing: {
                ZStack {
                    Circle()
                        .stroke(Color.indigoCustom.opacity(0.3), lineWidth: 3)
                    
                    Circle()
                        .trim(from: 0, to: {
                            let duration = context.attributes.habitDuration
                            let timePassed = context.state.timePassed
                            return duration > 0 ? min(CGFloat(timePassed) / CGFloat(duration), 1.0) : 0.0
                        }())
                        .stroke(Color.indigoCustom, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }
                .padding(4)
                .frame(width: 24, height: 24)
            } minimal: {
                ZStack {
                    Circle()
                        .stroke(Color.indigoCustom.opacity(0.3), lineWidth: 3)
                    
                    Circle()
                        .trim(from: 0, to: {
                            let duration = context.attributes.habitDuration
                            let timePassed = context.state.timePassed
                            return duration > 0 ? min(CGFloat(timePassed) / CGFloat(duration), 1.0) : 0.0
                        }())
                        .stroke(Color.indigoCustom, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                }
                .padding(4)
                .frame(width: 24, height: 24)
            }
        }
    }
}
