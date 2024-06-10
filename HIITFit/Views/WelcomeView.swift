//
//  WelcomeView.swift
//  HIITFit
//
//  Created by romashka on 04.06.2024.
//

import SwiftUI

struct WelcomeView: View {

    @EnvironmentObject var historyStore: HistoryStore
    @State private var showHistory = false
    @State private var showReports = false
    @Binding var selectedTab: Int

    var getStartedButton: some View {
        RaisedButton(buttonText: "Get Started") {
            selectedTab = 0
        }
        .padding()
    }

    var buttonHStack: some View {
        HStack(spacing: 40) {
            historyButton
            reportsButton
        }
        .padding(10)
    }

    var reportsButton: some View {
        Button(
            action: {
                showReports = true
            }, label: {
                Text("Reports")
                    .fontWeight(.bold)
            })
        .buttonStyle(EmbossedButtonStyle())
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

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HeaderView(selectedTab: $selectedTab, titelText: "Welcome")
                Spacer()

                ContainerView {
                    ViewThatFits {
                        VStack {
                            WelcomeView.images
                            WelcomeView.welcomeText
                            getStartedButton
                            Spacer()
                            buttonHStack
                        }
                        VStack {
                            WelcomeView.welcomeText
                            getStartedButton
                            Spacer()
                            buttonHStack
                        }
                    }
                    .frame(height: geometry.size.height * 0.8)
                }
                .sheet(isPresented: $showHistory) {
                    HistoryView(showHistory: $showHistory)
                }
                .sheet(isPresented: $showReports) {
                    BarChartWeekView()
                }
            }
        }
    }
}

#Preview {
    WelcomeView(selectedTab: .constant(9))
}
