//
//  ExerciseView.swift
//  HIITFit
//
//  Created by romashka on 04.06.2024.
//

import SwiftUI
import AVKit

struct ExerciseView: View {

    @State private var shoeSuccess = false
    @State private var rating = 0
    @Binding var selectedTab: Int
    let index: Int
    let interval: TimeInterval = 30

    var exercise: Exercise {
        Exercise.exercises[index]
    }
    
    var lastExercise: Bool {
        index + 1 == Exercise.exercises.count
    }

    var startButton: some View {
        Button("Start Exercise") {}
    }

    var doneButton: some View {
        Button("Done") {
            if lastExercise {
                shoeSuccess.toggle()
            } else {
                selectedTab += 1
            }
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(
                    selectedTab: $selectedTab,
                    titelText: Exercise.exercises[index].exerciseName)

                VideoPlayerView(videoName: exercise.videoName)

                Text(Date().addingTimeInterval(interval), style: .timer)
                    .font(.system(size: geometry.size.height * 0.07))

                HStack(spacing: 150) {
                    startButton
                    doneButton
                        .sheet(isPresented: $shoeSuccess, content: {
                            SuccessView(selectedTab: $selectedTab)
                                .presentationDetents([.medium, .large])
                        })
                }

                .font(.title3)
                .padding()

                RatingView(rating: $rating)
                    .padding()

                Spacer()

                Button("History") {}
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ExerciseView(selectedTab: .constant(3), index: 3)
}

