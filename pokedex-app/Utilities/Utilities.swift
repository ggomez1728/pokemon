//
//  Utilities.swift
//  pokedex-app
//
//  Created by German Gomez on 4/18/20.
//  Copyright © 2020 German Gomez. All rights reserved.
//

import UIKit
import Kingfisher
import SystemConfiguration

enum FontType: String {
    case firaSansLight = "FiraSans-Light"
    case error =  "error"
}

struct Utilities {
    
    /// Add corner radius and border to layer
    /// - Parameter layer: Layer to apply
    /// - Parameter borderWidth: border width to apply
    /// - Parameter borderColor: border color to apply
    /// - Parameter cornerRadius: corner radius to apply in all rounded nodes
    static func addCornerAndBorder(_ layer: CALayer, borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
    /**
     Add corner radius to layer
     
     - parameter layer: Layer to apply shadow
     */
    static func addCornerRadiusTo(_ layer: CALayer, cornerRadius: CGFloat, maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]) {
        layer.maskedCorners = maskedCorners
        layer.cornerRadius = cornerRadius
    }
    

    
    /**
     Add shadow to layer
     
     - parameter layer: Layer to apply shadow
     */
    static func addShadowTo(_ layer: CALayer, shadowRadius: CGFloat = 3.0, width: CGFloat = 0.0, height: CGFloat = 0.0, opacity: Float = 0.12, addBorder: Bool = false, borderColor: UIColor = .blue) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: width, height: height)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = opacity
        
        if addBorder {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = 1
        }
    }
    
    /// Add shadow and corner radius
    ///
    /// - Parameters:
    ///   - layer: layer to add shador
    ///   - cornerRadius: radius of the corners
    ///   - shadowRadius: shadow radius
    ///   - width: width of the shadow
    ///   - height: height of the shadow
    ///   - opacity: opacity of the shadow
    static func addShadowAndCorners(layer: CALayer,
        fillColor: UIColor,
        opacity: Float,
        cornerRadius: CGFloat, height: CGFloat, shadowRadius: CGFloat) {
        if layer.sublayers?.first(where: { $0.name == "Shadow" }) == nil {
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: layer.bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: height)
            shadowLayer.shadowOpacity = opacity
            shadowLayer.shadowRadius = shadowRadius
            shadowLayer.name = "Shadow"
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
   
 

    /**
     Get a particular font
     
     - parameter font: Font needed
     - parameter size: Font size
     - returns: A particular font requested
     */
    static func getFont(_ fontType: FontType, withSize size: CGFloat) -> UIFont {
        return UIFont(name: fontType.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
    

    /**
     Check if there is an internet connection
     
     - returns: Bool indicating if device is connected to network
     */
    static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return isReachable && !needsConnection
    }
    
    /// Verify if view is visible to user
    /// - Parameter view: view to verify
    static func isVisible(view: UIView) -> Bool {
        func isVisible(view: UIView, inView: UIView?) -> Bool {
            guard let inView = inView else { return true }
            let viewFrame = inView.convert(view.bounds, from: view)
            if viewFrame.intersects(inView.bounds) {
                return isVisible(view: view, inView: inView.superview)
            }
            return false
        }
        return isVisible(view: view, inView: view.superview)
    }
    
    /**
       Register cells for collection view
       
       - parameter collectionView: TableView to register cells
       */
      static func registerCellsFor(collectionView: UICollectionView) {
              // tableView.register(UINib(nibName: PremiumDishSwimlaneTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PremiumDishSwimlaneTableViewCell.cellIdentifier)
         
      }
  
    /**
     Register cells for table view
     
     - parameter tableView: TableView to register cells
     */
    static func registerCellsFor(tableView: UITableView) {
        tableView.register(UINib(nibName: PokemonTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PokemonTableViewCell.cellIdentifier)
    }
    
    /// Apply gradient in view
    /// - Parameter view: View to add gradient
    /// - Parameter firstColor: Initial gradient color
    /// - Parameter lastColor: end gradient color
    /// - Parameter isVertical: gradient is vertical
    static func setBackgroundGradient(view: UIView, firstColor: UIColor, lastColor: UIColor, isVertical: Bool) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor, lastColor]
        gradientLayer.type = .axial
        gradientLayer.locations = [0, 1]
        view.layer.addSublayer(gradientLayer)
    }
    
    /**
    Change font in specific words
    
    - parameter label: label to apply new font
    - parameter font: font to change in specific words
    - parameter word: words that we need to change with parameter font
    */
    static func setFontTo(label: UILabel, font: UIFont, words: [String]) {
        
        let attributedString = NSMutableAttributedString(string: label.text!, attributes: [
            .font: label.font as UIFont,
            .foregroundColor: label.textColor as UIColor
        ])
        
        for word in words {
            let wordArrange = (label.text! as NSString).range(of: word)
            attributedString.addAttribute(.font, value: font as UIFont, range: wordArrange)
        }
        
        label.attributedText = attributedString
    }
    
    /**
     Set image of url to imageView
     
     - parameter url: Image URL
     - parameter to: ImageView to set image
     - parameter placeholder: Placeholder to set
     */
    static func setImageOf(url: String?, to imageView: UIImageView, placeholder: UIImage?) {
        guard let urlString = url, let validatedURL = URL(string: urlString) else {
            imageView.image = placeholder
            
            return
        }
        imageView.kf.setImage(with: validatedURL, placeholder: placeholder)
    }
    
    /// Set a saturation value to an imge
    ///
    /// - Parameters:
    ///   - image: image to be modified
    ///   - value: saturation value
    static func setSaturation(image: UIImage, value: Float) -> UIImage {
        let beginImage = CIImage(image: image)
        let filter = CIFilter(name: "CIColorControls")
        filter?.setValue(beginImage, forKey: kCIInputImageKey)
        filter?.setValue(value, forKey: kCIInputSaturationKey)
        if let ciimage = filter?.outputImage {
            return UIImage(ciImage: ciimage)
        }
        return image
    }
}
