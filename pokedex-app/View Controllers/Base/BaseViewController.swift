//
//  BaseViewController.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {

    class var cellIdentifier: String {
        return String(describing: self)
    }
}
