//
//  BarChartDayView.swift
//  HIITFit
//
//  Created by romashka on 10.06.2024.
//

import Charts
import SwiftUI

struct BarChartDayView: View {

    let day: ExerciseDay

    var body: some View {
        Chart {
            ForEach(Exercise.names, id: \.self) { name in
                BarMark(
                    x: .value(name, name),
                    y: .value("Total Count", day.countExercise(exercise: name)))
                .foregroundStyle(Color("history-bar"))
            }
            RuleMark(y: .value("Exercise", 1))
                .foregroundStyle(.red)
        }
        .padding()
    }
}

#Preview {
    var history = HistoryStore(preview: true)
    return BarChartDayView(day: history.exerciseDays[0])
        .environmentObject(history)
}
