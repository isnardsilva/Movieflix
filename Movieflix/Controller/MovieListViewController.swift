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
    private var movies: [Movie] = []
    private let queryService = QueryService()
    
//    private let itemsPerRow: CGFloat = 3
//    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 20.0)
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Collection View
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        getAllMovies()
    }
        
    
    private func getAllMovies() {
        queryService.getRequest(completion: { [weak self] results, error in
            if error != nil {
                print(error!)
                return
            }
            
            if let receivedMovies = results {
                self?.movies = receivedMovies
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        })
    }

}


// MARK: - UICollectionViewDataSource
extension MovieListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
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


extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(movies[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
