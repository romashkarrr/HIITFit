//
//  HeaderView.swift
//  HIITFit
//
//  Created by romashka on 05.06.2024.
//

import SwiftUI

struct HeaderView: View {

    @Binding var selectedTab: Int
    let titelText: String
    var body: some View {
        VStack {
            Text(titelText)
                .font(.largeTitle)
            HStack {
                ForEach(Exercise.exercises.indices, id: \.self) { index in
                    let fill = index == selectedTab ? ".fill" : ""
                    Image(systemName: "\(index + 1).circle\(fill)")
                        .onTapGesture {
                            selectedTab = index
                        }
                }
            }
            .font(.title2)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HeaderView(selectedTab: .constant(0), titelText: "Squat")
        .padding(.bottom)
}

