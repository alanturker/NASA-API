//
//  Extension + KF.swift
//  NasaAPI-Turker
//
//  Created by Gülşah Alan on 29.09.2021.
//

import Foundation
import Kingfisher

extension UIImageView {
    func fetchImage(from urlString: String) {
        if let url = URL(string: urlString) {
            self.kf.setImage(with: url)
        }
    }
}

