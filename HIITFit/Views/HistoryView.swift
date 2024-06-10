//
//  HistoryView.swift
//  HIITFit
//
//  Created by romashka on 05.06.2024.
//

import SwiftUI

struct HistoryView: View {
    
    @State private var addMode = false
    @EnvironmentObject var history: HistoryStore
    @Binding var showHistory: Bool
    
    var headerView: some View {
        HStack {
            Button {
                addMode = true
            } label: {
                Image(systemName: "plus")
            }
            .padding(.trailing)
            EditButton()
            Spacer()
            Text("History")
                .font(.title)
            Spacer()
            Button {
                showHistory.toggle()
            } label: {
                Image(systemName: "xmark.circle")
            }
            .font(.title)
        }
    }
    
    func dayView(day: ExerciseDay) -> some View {
        DisclosureGroup {
            BarChartDayView(day: day)
                .deleteDisabled(true)
        } label: {
            Text(day.date.formatted(as: "d MMM YYYY"))
                .font(.headline)
        }
    }
    
    func exerciseView(day: ExerciseDay) -> some View {
        ForEach(day.exercises, id: \.self) { exercise in
            Text(exercise)
        }
    }
    
    var body: some View {
        VStack {
            Group {
                if addMode {
                    Text("History")
                        .font(.title)
                } else {
                    headerView
                }
            }
                .padding()
            List($history.exerciseDays, editActions: [.delete]) { $day in
                dayView(day: day)
                if addMode {
                    AddHistoryView(addMode: $addMode)
                        .background(Color.primary.colorInvert())
                        .shadow(color: .primary.opacity(0.5), radius: 7)
                }
            }
            .onDisappear {
                try? history.save()
            }
        }
    }
}

#Preview {
    HistoryView(showHistory: .constant(true))
        .environmentObject(HistoryStore())
}
