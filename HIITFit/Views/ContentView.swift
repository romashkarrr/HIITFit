//
//  ContentView.swift
//  HIITFit
//
//  Created by romashka on 04.06.2024.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTab = 9

    var body: some View {
        TabView(selection: $selectedTab) {
            WelcomeView(selectedTab: $selectedTab)
                .tag(9)
            ForEach(Exercise.exercises.indices, id: \.self) { index in
                ExerciseView(selectedTab: $selectedTab, index: index)
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

#Preview {
    ContentView()
}
