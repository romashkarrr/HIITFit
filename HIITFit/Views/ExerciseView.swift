//
//  ExerciseView.swift
//  HIITFit
//
//  Created by romashka on 04.06.2024.
//

import SwiftUI
import AVKit

struct ExerciseView: View {

    let index: Int
    let interval: TimeInterval = 30
    var exercise: Exercise {
        Exercise.exercises[index]
    }
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(exerciseName: exercise.exerciseName)
                VideoPlayerView(videoName: exercise.videoName)
                Text(Date().addingTimeInterval(interval), style: .timer)
                    .font(.system(size: geometry.size.height * 0.07))
                Button("Start/Done") {}
                    .font(.title3)
                    .padding()
                RatingView()
                    .padding()
                Spacer()
                Button("History") {}
                    .padding(.bottom)
            }
        }
    }
}

#Preview {
    ExerciseView(index: 0)
}

