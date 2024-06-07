//
//  TimerView.swift
//  HIITFit
//
//  Created by romashka on 07.06.2024.
//

import SwiftUI

struct CountdownView: View {

    let date: Date
    @Binding var timeRemaining: Int
    let size: Double

    var body: some View {
        Text("\(timeRemaining)")
            .font(.system(size: size, design: .rounded))
            .padding()
            .onChange(of: date) { oldValue, newValue in
                timeRemaining -= 1
            }
    }
}

struct TimerView: View {

    @State private var timeRemaining: Int = 3
    @Binding var timerDone: Bool
    let size: Double

    var body: some View {
        TimelineView(
            .animation(
                minimumInterval: 1.0,
                paused: timeRemaining <= 0)) { context in
                    CountdownView(
                        date: context.date,
                        timeRemaining: $timeRemaining,
                        size: size)
                }
                .onChange(of: timeRemaining) { oldValue, newValue in
                    if timeRemaining < 1 {
                        timerDone = true
                    }
                }
    }
}


#Preview {
    TimerView(timerDone: .constant(false), size: 90)
}
