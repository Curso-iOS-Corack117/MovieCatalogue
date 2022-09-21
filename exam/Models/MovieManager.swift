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
    private var lang: String { UserSettings.movieLanguage!.tag }
    private var currentMovieLang: String?
    private var movieLanguage: String {
        if let languageParam = UserSettings.movieLanguage?.tag {
            return "&language=" + languageParam
        }
        return ""
    }
    @Published var movies: [Movies.Movie] = [Movies.Movie]()
    @Published var currentMovie: Movies.Movie?
    
    init(loadFetchData: Bool) {
        
        if let dateStored = UserDefaults.standard.object(forKey: K.date) as? Date {
            let timeNow = Date().timeIntervalSince1970
            let timeLapsed = timeNow - dateStored.timeIntervalSince1970
            if timeLapsed >= K.secondsPerDay {
                if let domain = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                }
                userDefaults.set(Date(), forKey: K.date)
            }
        } else {
            userDefaults.set(Date(), forKey: K.date)
        }
        
        if loadFetchData {
            if let storedMovies = userDefaults.data(forKey: K.Movies.moviesKey + lang) {
                self.parseJSON(storedMovies, saveData: false)
                return
            }
            self.fetchAllData()
        }
    }
    
    func loadData(withLanguage: String) {
        if let storedMovies = userDefaults.data(forKey: K.Movies.moviesKey + lang) {
            self.parseJSON(storedMovies, saveData: false)
            return
        }
        self.fetchAllData(withLanguage: withLanguage, saveData: true)
    }
    
    func fetchAllData(withLanguage: String? = nil, saveData: Bool = true) {
        var urlString = K.moviesUrl + "?api_key=" + K.api_key + movieLanguage
        if let language = withLanguage {
            urlString = urlString + "&language=\(language)"
        }
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                self.parseJSON(data!, saveData: saveData)
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
                    self.userDefaults.set(data, forKey: K.Movies.moviesKey + self.lang)
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    func fetchMovie(withLanguage: String, movieID: Int) {
        self.currentMovieLang = withLanguage
        let stringUrl = K.moviesUrl + "?api_key=" + K.api_key + "&language=\(withLanguage)"
        if let url = URL(string: stringUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, urlResponse, error in
                if let e = error {
                    print(e.localizedDescription)
                }
                let decoder = JSONDecoder()
                do {
                    let movies = try decoder.decode(Movies.self, from: data!)
                    DispatchQueue.main.async {
                        let indexMovie = movies.results.firstIndex(where: {$0.id == movieID})
                        self.currentMovie = movies.results[indexMovie!]
                        if self.userDefaults.data(forKey: K.Movies.moviesKey + self.currentMovieLang!) == nil {
                            print("Hola")
                            self.userDefaults.set(data, forKey: K.Movies.moviesKey + self.currentMovieLang!)
                        }
                    }
                } catch {
                    print(error)
                }
            }
            task.resume()
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
        
        var tag: String {
            switch self {
            case .english: return "en-US"
            case .español: return "es-MX"
            case .français: return "fr-FR"
            }
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
