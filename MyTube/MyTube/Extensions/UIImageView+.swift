//
//  UIImageView+.swift
//  MyTube
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func urlImageLoad(imageUrl: String) {
        let url = URL(string: imageUrl)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(1.2))])
    }
}
