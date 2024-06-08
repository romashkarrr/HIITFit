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

class HistoryStore: ObservableObject {

    @Published var loadingError = false
    @Published var exerciseDays: [ExerciseDay] = []

    var dataURL: URL {
        URL.documentsDirectory
            .appendingPathComponent("history.plist")
    }

    init() {
        #if DEBUG
//        createDevData()
        #endif
        print("Initializing HistoryStore")

        do {
            try load()
        } catch {
            loadingError = true
        }
    }

    func load() throws {
        do {
            guard let data = try? Data(contentsOf: dataURL) else {
                return
            }
            let plistData = try PropertyListSerialization.propertyList(
                from: data,
                options: [],
                format: nil)
            let convertedPlistData = plistData as? [[Any]] ?? []
            exerciseDays = convertedPlistData.map {
                ExerciseDay(
                    date: $0[1] as? Date ?? Date(),
                    exercises: $0[2] as? [String] ?? [])
            }
        } catch {
            throw FileError.loadFailure
        }
    }

    func save() throws {
        let plistData: [[Any]] = exerciseDays.map {
            [$0.id.uuidString, $0.date, $0.exercises]
        }

        do {
            let data = try PropertyListSerialization.data(
                fromPropertyList: plistData,
                format: .binary,
                options: .zero)
            try data.write(to: dataURL, options: .atomic)
        } catch {
            throw FileError.saveFailure
        }
    }

    func addDoneExercise(_ exerciseName: String) {
        let today = Date()
        if let firstDate = exerciseDays.first?.date,
                           today.isSameDay(as: firstDate) {
            print("Adding \(exerciseName)")
            exerciseDays[0].exercises.append(exerciseName)
        } else {
            exerciseDays.insert(
                ExerciseDay(date: today, 
                            exercises: [exerciseName]),
                            at: 0)
        }

        print("History: ", exerciseDays)

        do {
            try save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}

enum FileError: Error {
    case loadFailure
    case saveFailure
}


