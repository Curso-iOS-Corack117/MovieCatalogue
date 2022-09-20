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
                        NavigationLink(destination: MoviewDetailView(movie: movie)) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
            }
            .frame(maxWidth: 800)
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
                                    movieManager.loadData(withLanguage: userSettings.movieLang.tag)
                                }
                            }
                        }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let userSettings: UserSettings = UserSettings()
        let movieManager: MovieManager = MovieManager(loadFetchData: true)
        ContentView()
            .environmentObject(userSettings)
            .environmentObject(movieManager)
//            .environment(\.locale, .init(identifier: userSettings.currentLanguage.tag))
    }
}
