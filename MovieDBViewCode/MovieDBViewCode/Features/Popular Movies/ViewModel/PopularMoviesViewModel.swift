//
//  PopularMoviesViewModel.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 28/03/24.
//

import Foundation

protocol PopularMoviesViewModelCoordinatorDelegate: AnyObject {
    func goToMovieDetailView(movieId: Int)
    func goBack()
}

protocol PopularMoviesViewModelViewDelegate: AnyObject {
    func reloadTableView()
    func loadingView(isLoading: Bool)
    func setupImage(data: Data)
}

class PopularMoviesViewModel {
    
    weak var coordinatorDelegate: PopularMoviesViewModelCoordinatorDelegate?
    weak var viewDelegate: PopularMoviesViewModelViewDelegate?
    
    let movieDBService = MovieDBService()
    
    var movieResult: MovieResult?
    
    var screenTitleText: String {
        return "Menu"
    }
    
    var leftButtonText: String {
        return "esquerda"
    }
    
    var rightButtonText: String {
        return "direita"
    }
    
    var numberOfMovies: Int {
        return movieResult?.results.count ?? 0
    }
    
    init() {
        
    }
    
    func featchPopularMovies() {
        Task {
            do {
                let result = try await movieDBService.fetchPopularMoviesAwait()
                self.movieResult = result
                DispatchQueue.main.async {
                    self.viewDelegate?.reloadTableView()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func downloadImage(posterURL: String) async -> Data?  {
        do {
            let imageData = try await movieDBService.fetchImageData(imageURLString: posterURL)
            return imageData
        } catch {
            return nil
        }
    }
    
    func moviePosterPath(at index: Int) -> String? {
        guard let movies = movieResult?.results, index >= 0 && index < numberOfMovies, let path = movies[index].posterPath else {
            return nil
        }
        
       return path
    }
    
    func movieTitle(at index: Int) -> String {
        guard let movies = movieResult?.results, index >= 0 && index < numberOfMovies else {
            return "titulo nao carregou"
        }
        return movies[index].title
    }
    
    func movieOverview(at index: Int) -> String {
        guard let movies = movieResult?.results, index >= 0 && index < numberOfMovies else {
            return "descricao nao carregou"
        }
        return movies[index].overview
    }
    
    func goToNextView(index: Int) {
        if let movie = movieResult?.results[index] {
            coordinatorDelegate?.goToMovieDetailView(movieId: movie.id)
        }
    }
    
    func goBack() {
        coordinatorDelegate?.goBack()
    }
}
