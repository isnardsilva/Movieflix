//
//  MainCoordinator.swift
//  Movieflix
//
//  Created by Isnard Silva on 10/11/20.
//

import UIKit

class MainCoordinator: Coordinator {
    // MARK: - Properties
    var navigationController: UINavigationController
    
    
    // MARK: - Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    // MARK: - Internal Methods
    func start() {
        let movieListViewController = MovieListViewController()
        movieListViewController.coordinator = self
        navigationController.pushViewController(movieListViewController, animated: false)
    }
}

extension MainCoordinator {
    func navigateToMovieDetailViewController(movie: Movie) {
        let movieDetailViewController = MovieDetailViewController(movie: movie)
        movieDetailViewController.coordinator = self
        navigationController.pushViewController(movieDetailViewController, animated: true)
    }
}
