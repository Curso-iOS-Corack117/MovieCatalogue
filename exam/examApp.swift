//
//  examApp.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 15/09/22.
//

import SwiftUI

@main
struct examApp: App {
    @StateObject var movieManager = MovieManager(loadFetchData: true)
    @StateObject var userSettings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(movieManager)
                .environmentObject(userSettings)
//                .environment(\.locale, .init(identifier: userSettings.currentLanguage.tag))
        }
    }
}
