//
//  MovieDetailView.swift
//  Movieflix
//
//  Created by Isnard Silva on 10/11/20.
//

import UIKit

class MovieDetailView: UIView {
    // MARK: - Views
    let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - ViewCodable
extension MovieDetailView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(backdropImageView)
        addSubview(titleLabel)
        addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    func setupAditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}
