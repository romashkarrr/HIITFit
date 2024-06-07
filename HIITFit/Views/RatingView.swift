//
//  RatingView.swift
//  HIITFit
//
//  Created by romashka on 05.06.2024.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    let maximumRating = 5
    
    let onColor = Color.red
    let offColor = Color.gray
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1, id: \.self) { index in
                Image(systemName: "waveform.path.ecg")
                    .foregroundColor(
                        index > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
        .font(.largeTitle)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RatingView(rating: .constant(3))
}
