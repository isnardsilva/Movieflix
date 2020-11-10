//
//  ViewController.swift
//  Movieflix
//
//  Created by Isnard Silva on 06/11/20.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - Views
    private var baseView = MovieListView()
    
    
    // MARK: - Properties
    private lazy var viewModel: MovieListViewModel = { [weak self] in
        let viewModel = MovieListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    weak var coordinator: MainCoordinator?
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        self.view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        navigationItem.title = "Movieflix"
        
        
        // Setup Collection View
        baseView.collectionView.dataSource = self
        baseView.collectionView.delegate = self
        
        
        // Fetch Movies
        viewModel.fetchTrendingMovies()
    }
}


// MARK: - MovieListViewModelDelegate
extension MovieListViewController: MovieListViewModelDelegate {
    func didReceiveBreaches() {
        DispatchQueue.main.async { [weak self] in
            self?.baseView.collectionView.reloadData()
        }
    }
    
    func didReceiveError() {
        // TODO: Handle Errors
    }
    
    
}


// MARK: - UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.movieCell, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        let movieViewModel = MovieViewModel(movie: viewModel.movies[indexPath.row])
        cell.movieViewModel = movieViewModel
        
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftSectionInsets: CGFloat = 5
        let itemsPerRow: CGFloat = 3
        
        let paddingSpace = leftSectionInsets * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem + 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}


// MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let touchedMovie = viewModel.movies[indexPath.row]
        coordinator?.navigateToMovieDetailViewController(movie: touchedMovie)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
