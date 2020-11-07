//
//  ViewController.swift
//  Movieflix
//
//  Created by Isnard Silva on 06/11/20.
//

import UIKit

class MovieListViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    private var movies: [Movie] = []
    
    private let queryService = QueryService()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Table View
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        
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
                    self?.tableView.reloadData()
                }
            }
        })
    }

}


// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.movieCell, for: indexPath)
        
        let movie = movies[indexPath.row]
        
        cell.textLabel?.text = movie.title
        
        
        return cell
    }
    
    
}


// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(movies[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

