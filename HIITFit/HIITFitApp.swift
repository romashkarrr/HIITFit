//
//  HIITFitApp.swift
//  HIITFit
//
//  Created by romashka on 04.06.2024.
//

import SwiftUI

@main
struct HIITFitApp: App {

    @StateObject private var historyStore = HistoryStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    print(URL.documentsDirectory)
                }
                .environmentObject(historyStore)
                .alert(isPresented: $historyStore.loadingError) {
                    Alert(
                        title: Text("History"),
                        message: Text(
                          """
                          Unfortunately we can't load your past history.
                          Email support:
                            support@xyz.com
                          """))
                }
        }
    }
}
