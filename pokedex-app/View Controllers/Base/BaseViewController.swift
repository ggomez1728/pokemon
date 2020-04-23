//
//  BaseViewController.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
    // MARK: - Public Methods
    /// Return name class
    class var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Private Methods
    /// Setup imageView with image name asset.
    /// - Parameters:
    ///   - imageUrlType: nama image to load in UIImageView
    ///   - imageView: UIImageView
    func configure(imageUrlType: String?, imageView: UIImageView) {
         if let imageUrlType = imageUrlType {
             imageView.isHidden = false
             imageView.image = UIImage(named: imageUrlType)
         }
     }
}
