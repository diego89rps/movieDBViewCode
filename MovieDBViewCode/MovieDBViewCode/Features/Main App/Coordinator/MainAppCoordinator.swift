//
//  MainAppCoordinator.swift
//  MovieDBViewCode
//
//  Created by Diego Ribeiro on 19/03/24.
//

import UIKit

class MainAppCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToResume()
    }
    
    func goToResume() {
        let vc = MainAppViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
