//
//  Constatns.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 17/09/22.
//

import Foundation

struct K {
    static let api_key: String = "b023b950ed31b2dab3a4f9b662fae6fc"
    static let baseUrl: String = "https://api.themoviedb.org/3"
    static let moviesUrl: String = "https://api.themoviedb.org/3/movie/top_rated"
    static let languageUrl: String = "https://api.themoviedb.org/3/movie/top_rated"
    static let baseUrlImage: String = "https://image.tmdb.org/t/p/w154"
    
    struct Movies {
        static let moviesKey = "movies"
    }
    
    struct Settings {
        static let appLanguage = "appLanguage"
        static let moviesLanguage = "moviesLanguage"
    }
}
