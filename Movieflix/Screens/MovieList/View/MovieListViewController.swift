//
//  ViewController.swift
//  Movieflix
//
//  Created by Isnard Silva on 06/11/20.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - Properties
    private var baseView = MovieListView()
    
    private lazy var viewModel: MovieListViewModel = { [weak self] in
        let viewModel = MovieListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private var dataSource: MovieListDataSource? {
        didSet {
            guard let validDataSource = dataSource else {
                return
            }

            // Setup movie selection
            validDataSource.didSelectMovie = { [weak self] selectedMovie in
                self?.didSelectMovie(selectedMovie: selectedMovie)
            }
            
            // Setup pagination handle
            validDataSource.didEndOfCollectionView = { [weak self] in
                self?.didEndOfCollectionView()
            }

            // Update Collection View
            DispatchQueue.main.async { [weak self] in
                self?.baseView.collectionView.dataSource = validDataSource
                self?.baseView.collectionView.delegate = validDataSource
                self?.baseView.collectionView.reloadData()
                
                let isPaginationMode = self?.viewModel.isPaginationMode ?? false
                
                if !isPaginationMode {
                    self?.baseView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        }
    }
    
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
        navigationItem.hidesSearchBarWhenScrolling = false
        
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
        baseView.searchController.searchBar.placeholder = "Search Movie"
        navigationItem.searchController = baseView.searchController
        definesPresentationContext = true
    }
}

// MARK: - Setup Activity Indicator View
extension MovieListViewController {
    private func stopLoadingAnimation() {
        DispatchQueue.main.async { [weak self] in
            self?.baseView.activityIndicatorView.stopAnimating()
        }
    }
}

// MARK: - MovieListViewModelDelegate
extension MovieListViewController: MovieListViewModelDelegate {
    
    func didReceiveMovies() {
        stopLoadingAnimation()
        
        DispatchQueue.main.async { [unowned self] in
            if self.viewModel.movies.isEmpty {
                if let lastMovieNameSearched = baseView.searchController.searchBar.text {
                    self.showErrorMessage(message: "No movies were found with the name \"\(lastMovieNameSearched)\"")
                } else {
                    self.showErrorMessage(message: "No movies were found.")
                }
            } else {
                self.dataSource = MovieListDataSource(movies: viewModel.movies)
                self.showContent()
            }
        }
    }
    
    func didReceiveError(error: Error) {
        stopLoadingAnimation()
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            viewModel.fetchTrendingMovies()
        }
    }
}

// MARK: - Hadle Movie Selection
extension MovieListViewController {
    private func didSelectMovie(selectedMovie: Movie) {
        coordinator?.navigateToMovieDetailViewController(movie: selectedMovie)
    }
}

// MARK: - Hadle Pagination
extension MovieListViewController {
    private func didEndOfCollectionView() {
        if !baseView.searchController.isActive {
            self.viewModel.fetchTrendingMovies(pagination: true)
        }
    }
}
