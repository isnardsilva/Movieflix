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
        
        print(DeviceInfo.shared.getLanguage())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Navigation Bar
        navigationItem.title = "Movieflix"
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Setup Collection View
        baseView.collectionView.dataSource = self
        baseView.collectionView.delegate = self
        
        // Setup Search Controller
        setupSearchController()
        
        // Show loading
        baseView.activityIndicatorView.startAnimating()
        
        // Fetch Movies
        viewModel.fetchTrendingMovies()
    }
    
    // MARK: - Private Methods
    private func showErrorMessage(message: String) {
        baseView.messageLabel.text = message
        baseView.collectionView.isHidden = true
        baseView.messageLabel.isHidden = false
    }
    
    private func showContent() {
        baseView.collectionView.isHidden = false
        baseView.messageLabel.isHidden = true
    }
    
    func setupSearchController() {
        baseView.searchController.searchBar.delegate = self
        baseView.searchController.obscuresBackgroundDuringPresentation = false
        baseView.searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = baseView.searchController
        definesPresentationContext = true
    }
}

// MARK: - MovieListViewModelDelegate
extension MovieListViewController: MovieListViewModelDelegate {
    
    func didReceiveMovies() {
        
        DispatchQueue.main.async { [unowned self] in
            baseView.activityIndicatorView.stopAnimating()
            
            if self.viewModel.movies.isEmpty {
                self.showErrorMessage(message: "No movies were found with the name \"\(viewModel.lastMovieNameSearched)\"")
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.showContent()
                    self?.baseView.collectionView.reloadData()
                }
            }
        }
    }
    
    func didReceiveError(error: Error) {
        print(error)
        
        DispatchQueue.main.async { [weak self] in
            if let detectedError = error as NSError?, detectedError.code == NSURLErrorNotConnectedToInternet {
                self?.showErrorMessage(message: "No internet connection!")
            } else {
                self?.showErrorMessage(message: "An error has occurred! Try again later!")
            }
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let movieName = searchBar.text, !movieName.isEmpty else {
            return
        }
        
        viewModel.searchMovieByName(movieName)
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
