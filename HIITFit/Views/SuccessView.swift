//
//  SuccessView.swift
//  HIITFit
//
//  Created by romashka on 05.06.2024.
//

import SwiftUI

struct SuccessView: View {

    @Binding var selectedTab: Int
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "hand.raised.fill")
                    .resizedToFill(width: 75, height: 75)
                    .foregroundStyle(Color.purple)
                Text("High Five!")
                    .font(.title)
                    .fontWeight(.bold)
                Text("""
                         Good job completing all four exercises!
                         Remember tomorrow's another day.
                         So eat well and get some rest.
                        """)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray)
            }
            
            VStack {
                Spacer()
                Button("Countinue") {
                    dismiss()
                    selectedTab = 9
                }
                .padding()
            }
        }
    }
}

#Preview {
    SuccessView(selectedTab: .constant(3))
}
