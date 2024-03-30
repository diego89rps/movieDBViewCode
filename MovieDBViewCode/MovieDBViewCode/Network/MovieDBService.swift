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
    
    func fetchMovieDetailAwait(movieId: Int) async throws -> MovieDetailsModel {
        do {
            let (data, _) = try await URLSession.shared.data(from: MovieDBAPI.movieDetails(movieId).url)
            printRequest(data: data)
            let decodedData = try JSONDecoder().decode(MovieDetailsModel.self, from: data)
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

//MARK: - if console not print a request use printRequest function
extension MovieDBService {
    func printRequest(data: Data) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Não foi possível converter os dados em um objeto JSON.")
                return
            }
            print("############# AQUI INICIO ")
            print("############# AQUI INICIO ")
            print(json)
            print("############# AQUI FIM ")
            print("############# AQUI FIM ")
        } catch {
            print("Erro ao converter os dados em JSON:", error)
        }
    }
}
