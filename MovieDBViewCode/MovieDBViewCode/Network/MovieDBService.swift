//
//  MovieDBProvider.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 26/03/24.
//

import Foundation

class MovieDBService {
    func fetchPopularMoviesAwait() async throws -> MovieResult {
        do {
            let (data, _) = try await URLSession.shared.data(from: MovieDBAPI.popularMovies.url)
            let decodedData = try JSONDecoder().decode(MovieResult.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
    func fetchImageData(imageURLString: String) async throws -> Data {
        let formatedURL = "https://image.tmdb.org/t/p/w500" + imageURLString
        guard let url = URL(string: formatedURL) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }

}
