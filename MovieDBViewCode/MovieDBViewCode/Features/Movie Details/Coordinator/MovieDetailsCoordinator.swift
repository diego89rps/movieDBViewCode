//
//  MovieDetailsCoordinator.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 28/03/24.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var movieId: Int
    
    init(navigationController: UINavigationController, movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }
    
    func start() {
        let vm = MovieDetailsViewModel(movieId: movieId)
        vm.coordinatorDelegate = self
        let vc = MovieDetailsViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MovieDetailsCoordinator: MovieDetailsCoordinatorDelegate {
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
