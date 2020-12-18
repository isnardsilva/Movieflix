//
//  Coordinator.swift
//  Movieflix
//
//  Created by Isnard Silva on 10/11/20.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
