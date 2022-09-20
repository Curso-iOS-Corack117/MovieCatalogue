//
//  ConfigurationsView.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 17/09/22.
//

import SwiftUI

struct ConfigurationsView: View {
    @ObservedObject var settings: UserSettings
    
    var body: some View {
        Form {
            Section("config-general-section".localizedString) {
                Picker("config-general-language".localizedString, selection: $settings.currentLanguage) {
                    ForEach(UserSettings.Language.allCases) { language in
                        Text(language.languageString).tag(language)
                    }
                }
                Picker("config-general-movie-language".localizedString, selection: $settings.movieLang) {
                    ForEach(MovieManager.MovieLanguage.allCases) { language in
                        Text(language.languageString).tag(language)
                    }
                }
            }
        }
    }
}

struct ConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationsView(settings: UserSettings())
    }
}
