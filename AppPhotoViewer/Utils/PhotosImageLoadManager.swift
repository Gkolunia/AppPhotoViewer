//
//  PhotosImageLoadManager.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/16/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit
import Nuke

/// Abstraction above image loader framework
class PhotosImageLoadManager {
    
    
    /// Method loads firstly image by smallImageUrl, then by largeImageurl. Also it returns cached images.
    /// Also downloading automatically stoped when another dowloading is started on the same instance of an imageView.
    ///
    /// - Parameters:
    ///   - smallImageUrl: url to small size image can be used for preview
    ///   - largeImageUrl: url to large size image
    ///   - imageView: imageView in which downloaded image should be set.
    static func loadImage(_ smallImageUrl: URL, _ largeImageUrl: URL?, _ imageView: UIImageView) {

        Nuke.loadImage(with: smallImageUrl, options: ImageLoadingOptions(), into: imageView, progress: nil) { (response, error) in
            if let largeImageUrl = largeImageUrl {
                let imageLoadingOptions = ImageLoadingOptions(placeholder: response?.image, transition: nil, failureImage: nil, failureImageTransition: nil, contentModes: nil)
                
                Nuke.loadImage(with: largeImageUrl, options: imageLoadingOptions, into: imageView, progress: nil) { (response, error) in
                    imageView.image = response?.image
                }
            }
        }
        
    }
    
}
