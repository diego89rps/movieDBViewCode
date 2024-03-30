//
//  PopularMoviesCoordinator.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 28/03/24.
//

import UIKit

class PopularMoviesCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToResume()
    }
    
    func goToResume() {
        let vm = PopularMoviesViewModel()
        vm.coordinatorDelegate = self
        let vc = PopularMoviesViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
}

extension PopularMoviesCoordinator: PopularMoviesViewModelCoordinatorDelegate {
    func goToMovieDetailView(movieId: Int) {
        let coordinator = MovieDetailsCoordinator(navigationController: navigationController, movieId: movieId)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
