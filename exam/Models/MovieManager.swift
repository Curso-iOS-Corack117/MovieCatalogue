//
//  MovieManager.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 15/09/22.
//

import Foundation
import UIKit

class MovieManager: ObservableObject {
    private var userDefaults: UserDefaults = UserDefaults()
    private var movieLanguage: String {
        if let languageParam = UserSettings.movieLanguage?.rawValue {
            return "&language=" + languageParam
        }
        return ""
    }
    @Published var movies: [Movies.Movie] = [Movies.Movie]()
    
    init(loadFetchData: Bool) {
        if loadFetchData {
            if let storedMovies = userDefaults.data(forKey: K.Movies.moviesKey) {
                self.parseJSON(storedMovies, saveData: false)
                return
            }
            self.fetchData()
        }
    }
    
    func fetchData() {
        let urlString = K.moviesUrl + "?api_key=" + K.api_key + movieLanguage
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                self.parseJSON(data!, saveData: true)
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data, saveData: Bool) {
        let decoder = JSONDecoder()
        do {
            let movies = try decoder.decode(Movies.self, from: data)
            DispatchQueue.main.async {
                self.movies = Array(movies.results[..<10])
                if saveData {
                    self.userDefaults.set(data, forKey: K.Movies.moviesKey)
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    enum MovieLanguage: String, CaseIterable, Identifiable {
        case english
        case español
        case français
        
        var languageString: String {
            rawValue.capitalized
        }
        
        var id: String {
            languageString
        }
        
        static func getLanguageFrom(tag: String) -> MovieLanguage{
            switch tag {
            case let str where str.contains("en"): return .english
            case let str where str.contains("es"): return .español
            case let str where str.contains("fr"): return .français
            default:
                return .english
            }
        }
    }
}
