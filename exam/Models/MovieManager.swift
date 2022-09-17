//
//  MovieManager.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 15/09/22.
//

import Foundation
import UIKit

class MovieManager: ObservableObject {
    @Published var movies: [Movies.Movie] = [Movies.Movie]()
    
    private let api_key = "b023b950ed31b2dab3a4f9b662fae6fc"
    private let urlBase = "https://api.themoviedb.org/3/movie/top_rated"
    
    func fetchData() {
        let urlString = urlBase + "?api_key=" + api_key
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                self.parseJSON(data!)
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) {
        let decoder = JSONDecoder()
        do {
            let movies = try decoder.decode(Movies.self, from: data)
            DispatchQueue.main.sync {
                self.movies = Array(movies.results[..<10])
            }
        } catch {
            print(error)
        }
    }
}
