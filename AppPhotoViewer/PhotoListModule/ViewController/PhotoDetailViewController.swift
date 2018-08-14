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
    weak var photoListController : PhotoListViewController?
    
    var viewModel : PhotoItemViewModel! {
        didSet {
            // Firstly set image which is already loaded and then load full size image.
            let image = ImageCache.shared[ImageRequest(url: viewModel.smallImageUrl)]

            let imageLoadingOptions = ImageLoadingOptions(placeholder: image, transition: nil, failureImage: nil, failureImageTransition: nil, contentModes: nil)

            Nuke.loadImage(with: viewModel.largeImageUrl, options: imageLoadingOptions, into: imageView, progress: nil) { (response, error) in
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
    
    func setupChildPhotosController(_ photoListController: PhotoListViewController) {
        self.photoListController = photoListController
        
        self.addChildViewController(photoListController)
        self.collectionViewContainer.addSubview(photoListController.view)
        
        photoListController.view.translatesAutoresizingMaskIntoConstraints = false
        photoListController.view.topAnchor.constraint(equalTo: self.collectionViewContainer.topAnchor).isActive = true
        photoListController.view.bottomAnchor.constraint(equalTo: self.collectionViewContainer.bottomAnchor).isActive = true
        photoListController.view.leadingAnchor.constraint(equalTo: self.collectionViewContainer.leadingAnchor).isActive = true
        photoListController.view.trailingAnchor.constraint(equalTo: self.collectionViewContainer.trailingAnchor).isActive = true
        
        photoListController.didMove(toParentViewController: self)
        
    }
    
}
