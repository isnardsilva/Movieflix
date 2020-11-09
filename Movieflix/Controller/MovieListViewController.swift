//
//  ViewController.swift
//  Movieflix
//
//  Created by Isnard Silva on 06/11/20.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Properties
    private lazy var viewModel: MovieListViewModel = { [weak self] in
        let viewModel = MovieListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Collection View
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Fetch Movies
        viewModel.fetchTrendingMovies()
    }
}


// MARK: - MovieListViewModelDelegate
extension MovieListViewController: MovieListViewModelDelegate {
    func didReceiveBreaches() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.movieCell, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let leftSectionInsets: CGFloat = 8
        let itemsPerRow: CGFloat = 3
        
        let paddingSpace = leftSectionInsets * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}


// MARK: - UICollectionViewDelegate
extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.movies[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
