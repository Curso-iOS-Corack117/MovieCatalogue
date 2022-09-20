//
//  ConfigurationsManager.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 17/09/22.
//

import Foundation
import SwiftUI

class UserSettings: ObservableObject {
    static var appLanguage: Language?
    static var movieLanguage: MovieManager.MovieLanguage?
    
    private var userDefaults: UserDefaults = .standard
    
    @Published var currentLanguage: Language
    @Published var movieLang: MovieManager.MovieLanguage
    
    init() {
        let language = userDefaults.string(forKey: K.Settings.appLanguage)
        let moviesLanguage = userDefaults.string(forKey: K.Settings.moviesLanguage)
        let bundleLanguage = Bundle.main.preferredLocalizations.first!
        self.currentLanguage = Language(rawValue: language ?? Language.getLanguageFrom(tag: bundleLanguage).rawValue)!
        self.movieLang = MovieManager.MovieLanguage(rawValue: moviesLanguage ?? MovieManager.MovieLanguage.getLanguageFrom(tag: bundleLanguage).rawValue)!
        UserSettings.appLanguage = self.currentLanguage
        UserSettings.movieLanguage = self.movieLang
        if language == nil {
            userDefaults.set(self.currentLanguage.rawValue, forKey: K.Settings.appLanguage)
            userDefaults.set(self.movieLang.rawValue, forKey: K.Settings.moviesLanguage)
        }
    }
    
    enum Language: String, CaseIterable, Identifiable {
        case español
        case english
        
        var languageString: String {
            rawValue.capitalized
        }
        
        var id: String {
            languageString
        }
        
        var tag: String {
            switch self {
            case .english: return "en"
            case .español: return "es-419"
            }
        }
        
        static func getLanguageFrom(tag: String) -> Language{
            switch tag {
            case "en": return .english
            case "es-419": return .español
            case "es": return .español
            default:
                return .english
            }
        }
    }
    
    func update(from manager: UserSettings) {
        if self.currentLanguage != manager.currentLanguage {
            self.currentLanguage = manager.currentLanguage
            UserSettings.appLanguage = self.currentLanguage
            userDefaults.set(self.currentLanguage.rawValue, forKey: K.Settings.appLanguage)
        }
        
        if self.movieLang != manager.movieLang {
            self.movieLang = manager.movieLang
            UserSettings.movieLanguage = self.movieLang
            userDefaults.set(self.movieLang.rawValue, forKey: K.Settings.moviesLanguage)
        }
    }
}


extension Bundle {
    func localizedString(forKey key: String) -> String {
        return self.localizedString(forKey: key, value: nil, table: nil)
    }
}

extension String {
    var localizedString: String {
        let resource = UserSettings.appLanguage?.tag ?? Bundle.main.preferredLocalizations.first!
        if let path = Bundle.main.path(forResource: resource, ofType: "lproj") {
            let bundle = Bundle(path: path)
            return bundle!.localizedString(forKey: self)
        }
        return Bundle.main.localizedString(forKey: self)
    }
    
}
