//
//  UIImage+SetImage.swift
//  Movieflix
//
//  Created by Isnard Silva on 09/11/20.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url: URL?) {
        if url == nil {
            self.image = UIImage(systemName: "photo")
            self.contentMode = .scaleAspectFit
            return
        } else {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url)
        }
    }
}
