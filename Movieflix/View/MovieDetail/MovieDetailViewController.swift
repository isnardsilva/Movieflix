//
//  MovieDetailViewController.swift
//  Movieflix
//
//  Created by Isnard Silva on 10/11/20.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - Views
    private let baseView = MovieDetailView()
    
    // MARK: - Properties
    private let viewModel: MovieViewModel
    
    weak var coordinator: MainCoordinator?
    
    
    // MARK: - Initialization
    init(movie: Movie) {
        viewModel = MovieViewModel(movie: movie)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - Private Methods
    private func setupUI() {
        baseView.backdropImageView.setImage(url: viewModel.backdropPath)
        baseView.titleLabel.text = viewModel.title
        baseView.overviewLabel.text = viewModel.overview
    }
}
