//
//  WelcomeView.swift
//  HIITFit
//
//  Created by romashka on 04.06.2024.
//

import SwiftUI

struct WelcomeView: View {

    @State private var showHistory = false
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
            VStack {
                HeaderView(selectedTab: $selectedTab, titelText: "Welcome")
                Spacer()
                Button("History") {
                    showHistory.toggle()
                }
                .sheet(isPresented: $showHistory){
                    HistoryView(showHistory: $showHistory)
                }
            }

            VStack {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("Get fit")
                            .font(.largeTitle)
                        Text("with high intensity interval training")
                            .font(.headline)
                    }
                    Image("step-up")
                        .resizedToFill(width: 240, height: 240)
                        .clipShape(Circle())
                }
                
                Button(action: { selectedTab = 0 }) {
                    Text("Get Start")
                    Image(systemName: "arrow.right.circle")
                }
                .font(.title2)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 2))
            }
        }
    }
}

#Preview {
    WelcomeView(selectedTab: .constant(9))
}
