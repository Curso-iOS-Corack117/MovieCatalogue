//
//  Movie.swift
//  exam
//
//  Created by Sergio Ordaz Romero on 16/09/22.
//

import Foundation
import UIKit

struct Movies: Decodable {
    let results: [Movie]
    
    struct Movie: Codable, Identifiable {
        let id: Int
        let title: String
        let original_title: String
        let original_language: String
        let popularity: Double
        let overview: String
        let poster_path: String
        let vote_average: Double
//        let release_date: Date
        
        var popularity_value: String {
            String(format: "%.2f", popularity)
        }
        
        var vote_average_value: String {
            String(format: "%.2f", vote_average)
        }
    }
}
