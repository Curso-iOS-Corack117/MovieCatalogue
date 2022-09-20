//
//  examApp.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 15/09/22.
//

import SwiftUI

@main
struct examApp: App {
    @StateObject var userSettings = UserSettings()
    @StateObject var movieManager = MovieManager(loadFetchData: true)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userSettings)
                .environmentObject(movieManager)
//                .environment(\.locale, .init(identifier: userSettings.currentLanguage.tag))
        }
    }
}
