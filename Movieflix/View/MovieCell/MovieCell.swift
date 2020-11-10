//
//  MovieCell.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import UIKit

class MovieCell: UICollectionViewCell {
    // MARK: - Views
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    // MARK: - Properties
    var movieViewModel: MovieViewModel! {
        didSet {
            setupUI()
        }
    }
    
    
    // MARK: - Initialization
    
    
    // MARK: Private Methods
    private func setupUI() {
        imageView.setImage(url: movieViewModel.thumbnailPath)
        setupViews()
    }
}


// MARK: - ViewCodable
extension MovieCell: ViewCodable {
    func setupViewHierarchy() {
        self.contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    func setupAditionalConfiguration() {
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 5
    }
}
