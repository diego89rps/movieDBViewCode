//
//  MovieResult.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 26/03/24.
//

import Foundation

struct MovieResult: Codable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages" 
        case results
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
