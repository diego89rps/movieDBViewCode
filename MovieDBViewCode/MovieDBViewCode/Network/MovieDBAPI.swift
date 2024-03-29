//
//  File.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 26/03/24.
//

import Foundation

enum MovieDBAPI {
    case popularMovies
    case movieDetails(Int)
    
    private var fullPath: String {
        let apiKey = "79bb37b9869aa0ed97dc7a23c93d0829"
        let baseURLString = "https://api.themoviedb.org/3"
        var endpoint: String
        switch self {
        case .popularMovies:
            endpoint = "/movie/popular"
        case .movieDetails(let movieId):
            endpoint = "/movie/\(movieId)"
        }

        let urlString = "\(baseURLString)\(endpoint)?api_key=\(apiKey)&language=en-US&page=1"
        return urlString
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(self.self) is not valid")
        }
        return url
    }
}
