//
//  MovieListDataSource.swift
//  Movieflix
//
//  Created by Isnard Silva on 20/12/20.
//

import UIKit

class MovieListDataSource: NSObject, UICollectionViewDataSource {
    // MARK: - Properties
    private var movies: [Movie]
    
    var didSelectMovie: ((Movie) -> Void)?
    
    // MARK: - Initialization
    init(movies: [Movie]) {
        self.movies = movies
        super.init()
    }
}

// MARK: - Setup Content Cells
extension MovieListDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier.Cell.movieCell, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        
        let movieViewModel = MovieViewModel(movie: movies[indexPath.row])
        cell.movieViewModel = movieViewModel
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MovieListDataSource: UICollectionViewDelegateFlowLayout {
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
extension MovieListDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedMovie = movies[indexPath.row]
        self.didSelectMovie?(selectedMovie)
    }
}
