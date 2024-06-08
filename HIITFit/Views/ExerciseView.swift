//
//  ExerciseView.swift
//  HIITFit
//
//  Created by romashka on 04.06.2024.
//

import SwiftUI
import AVKit

struct ExerciseView: View {

    @EnvironmentObject var history: HistoryStore

    @State private var showHistory = false
    @State private var timerDone = false
    @State private var showTimer = false

    @State private var shoeSuccess = false

    @Binding var selectedTab: Int
    let index: Int

    var exercise: Exercise {
        Exercise.exercises[index]
    }
    
    var lastExercise: Bool {
        index + 1 == Exercise.exercises.count
    }

    var startButton: some View {
        RaisedButton(buttonText: "Start Exercise") {
            showTimer.toggle()
        }
    }

    var historyButton: some View {
        Button(
            action: {
                showHistory = true
            },
            label: {
                Text("History")
                    .fontWeight(.bold)
                    .padding([.leading, .trailing], 5)
            })
        .padding(.bottom, 10)
        .buttonStyle(EmbossedButtonStyle())
    }

    var doneButton: some View {
        Button("Done") {
            history.addDoneExercise(Exercise.exercises[index].exerciseName)
            timerDone = false
            showTimer.toggle()
            if lastExercise {
                shoeSuccess.toggle()
            } else {
                selectedTab += 1
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HeaderView(
                    selectedTab: $selectedTab,
                    titelText: Exercise.exercises[index].exerciseName)

                VideoPlayerView(videoName: exercise.videoName)

                HStack(spacing: 150) {
                    startButton
                    doneButton
                        .disabled(!timerDone)
                        .sheet(isPresented: $shoeSuccess, content: {
                            SuccessView(selectedTab: $selectedTab)
                                .presentationDetents([.medium, .large])
                        })
                }
                .font(.title3)
                .padding()

                if showTimer {
                    TimerView(timerDone: $timerDone, size: geometry.size.height * 0.07)
                }

                Spacer()
                
                RatingView(exerciseIndex: index)
                    .padding()

                historyButton
            }
        }
    }
}

#Preview {
    ExerciseView(selectedTab: .constant(0), index: 0)
        .environmentObject(HistoryStore())
}

