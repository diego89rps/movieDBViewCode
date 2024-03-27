//
//  MainAppViewModel.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 23/03/24.
//

import Foundation

protocol MainAppViewModelCoordinatorDelegate: AnyObject {
    func goToNextView()
}

protocol MainAppViewModelViewDelegate: AnyObject {
    func createSimpleView()
    func createCompleteView()
    func loadingView(isLoading: Bool)
    func setupImage(data: Data)
}

class MainAppViewModel {
    
    weak var viewDelegate: MainAppViewModelViewDelegate?
    weak var coordinatordDlegate: MainAppViewModelCoordinatorDelegate?
    
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
    
    var simpleTitleText: String {
        return "Implementacao Simples"
    }
    
    var simpleSubTitleText: String {
        return "Implementado apenas a lista de filmes e seus detalhes"
    }
    
    var completedTitleText: String {
        return "Implementacao Completa"
    }
    
    var completedSubTitleText: String {
        return "Implementado material completo da API MOVIE DB"
    }
    
    var alertTitleText: String {
        return "INDISPONIVEL"
    }
    
    var alertDescriptionText: String {
        return "Aplicacao em desenvolvimento."
    }
    
    var alertBtnTitleText: String {
        return "OK"
    }
    
    init() {
        
    }
    
    func featchPopularMovies() {
        Task {
            do {
                let result = try await movieDBService.fetchPopularMoviesAwait()
                self.movieResult = result
                self.downloadImage()
            } catch {
                print(error)
            }
        }
    }
    
    func downloadImage() {
        guard let movie = movieResult?.results[3], let posterURL = movie.posterPath  else { return }
        
        Task {
            do {
                let imageData = try await movieDBService.fetchImageData(imageURLString: posterURL)
                self.viewDelegate?.setupImage(data: imageData)
            } catch {
                print("Erro ao buscar imagem:", error.localizedDescription)
            }
        }
    }
    
    func setupView() {
        viewDelegate?.createSimpleView()
        viewDelegate?.createCompleteView()
    }
    
    func goToNextView() {
        coordinatordDlegate?.goToNextView()
    }
}
