//
//  BaseViewController.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {

    class var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Private Methods
    func configure(imageUrlType: String?, imageView: UIImageView) {
         if let imageUrlType = imageUrlType {
             imageView.isHidden = false
             imageView.image = UIImage(named: imageUrlType)
         }
     }
     
  
     
}
