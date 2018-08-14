//
//  PhotoDetailViewController.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit
import Nuke

class PhotoDetailViewController : UIViewController {
    
    let imageView : UIImageView = UIImageView(frame: CGRect())
    let collectionViewContainer : UIView = UIView(frame: CGRect())
    
    var viewModel : PhotoItemViewModel! {
        didSet {
            // Firstly set image which is already loaded and then load full size image.
            let image = ImageCache.shared[ImageRequest(url: viewModel.smallImageUrl)]
            self.imageView.image = image

            ImagePipeline.shared.loadImage(with: viewModel.largeImageUrl, progress: nil) { (response, error) in
                self.imageView.image = response?.image
            }
            
            self.navigationItem.title = viewModel.tagTitle.capitalized
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        collectionViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(collectionViewContainer)
    
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: collectionViewContainer.topAnchor).isActive = true
        
        collectionViewContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionViewContainer.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        imageView.contentMode = .scaleAspectFit
        
    }
    
}
