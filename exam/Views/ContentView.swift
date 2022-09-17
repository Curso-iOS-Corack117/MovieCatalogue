//
//  ContentView.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 15/09/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var movieManager = MovieManager()
    
    var body: some View {
        NavigationView {
            List(movieManager.movies) { movie in
                MovieView(movie: movie)
                    .overlay {
                        NavigationLink(destination: Text("Test")) {
                            EmptyView()
                        }
                        .opacity(0)
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Top 10 películas")
        }
        .task {
            movieManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
