//
//  MovieDetailsViewModel.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 28/03/24.
//

import Foundation

protocol MovieDetailsCoordinatorDelegate: AnyObject {
    func goBack()
}

protocol MovieDetailslViewDelegate: AnyObject {
    func loadingView(isLoading: Bool)
    func setupView(data: Data)
}

class MovieDetailsViewModel {
    
    weak var coordinatorDelegate: MovieDetailsCoordinatorDelegate?
    weak var viewDelegate: MovieDetailslViewDelegate?
    
    let movieDBService = MovieDBService()
    
    var movieDetails: MovieDetailsModel?
    
    var movieId: Int
    
    var screenTitleText: String {
        return "Details"
    }
    
    var leftButtonText: String {
        return "to back"
    }
    
    var movieTitleText: String {
        return movieDetails?.title ?? ""
    }
    
    var movieOverviewText: String {
        return movieDetails?.overview ?? ""
    }
    
    var backdropURL: String {
        return movieDetails?.backdrop_path ?? ""
    }
    
    var releaseData: String {
        return movieDetails?.release_date?.formattedDate() ?? ""
    }
    
    var voteAverage: Double {
        return movieDetails?.vote_average ?? 0.0
    }
    
    var homepage: String {
        return movieDetails?.homepage ?? ""
    }
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func featchMovieDetails() {
        self.viewDelegate?.loadingView(isLoading: true)
        Task {
            do {
                let result = try await movieDBService.fetchMovieDetailAwait(movieId: movieId)
                self.movieDetails = result
                do {
                    let data = await downloadImage(posterURL: self.backdropURL)
                    guard let imagemData = data else { return }
                    DispatchQueue.main.async {
                        
                        self.viewDelegate?.setupView(data: imagemData)
                        self.viewDelegate?.loadingView(isLoading: false)

                    }
                }

            } catch {
                print(error)
                self.viewDelegate?.loadingView(isLoading: false)
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
    
    func goBack() {
        coordinatorDelegate?.goBack()
    }
}
