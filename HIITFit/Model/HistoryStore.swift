//
//  HistoryStore.swift
//  HIITFit
//
//  Created by romashka on 05.06.2024.
//

import Foundation

struct ExerciseDay: Identifiable {

    let id = UUID()
    let date: Date
    var exercises: [String] = []
    
}

struct HistoryStore {

    var exerciseDays: [ExerciseDay] = []

    init() {
        #if DEBUG
        createDevData()
        #endif
    }
}



