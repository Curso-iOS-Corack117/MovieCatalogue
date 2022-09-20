//
//  ContentView.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 15/09/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var movieManager: MovieManager
    @EnvironmentObject var userSettings: UserSettings
    @StateObject private var manager: UserSettings = UserSettings()
    @State var isPresenting: Bool = false
    
    var body: some View {
        NavigationView {
            List(movieManager.movies, id: \.id) { movie in
                MovieView(movie: movie)
                    .overlay {
                        NavigationLink(destination: Text("Test")) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
            }
            .toolbar {
                Button {
                    manager.update(from: userSettings)
                    isPresenting.toggle()
                } label: {
                    Image(systemName: "gear")
                }

            }
            .listStyle(.plain)
            .navigationTitle("home-title".localizedString)
            .sheet(isPresented: $isPresenting) {
                NavigationView {
                    ConfigurationsView(settings: manager)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("home-Cancel".localizedString) {
                                    isPresenting.toggle()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("home-Accept".localizedString) {
                                    isPresenting.toggle()
                                    userSettings.update(from: manager)
                                }
                            }
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let movieManager: MovieManager = MovieManager(loadFetchData: true)
        let userSettings: UserSettings = UserSettings()
        ContentView()
            .environmentObject(movieManager)
            .environmentObject(userSettings)
//            .environment(\.locale, .init(identifier: userSettings.currentLanguage.tag))
    }
}
