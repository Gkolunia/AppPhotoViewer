//
//  PhotoDetailViewController.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/// Delegation dissmissing
protocol PhotoDetailViewControllerDelegate : class {
    
    /// Passed all items which was downloaded by list controller.
    func doDissmiss(with allItems: [PhotoItemViewModel])
}

/// Controller setups views to show large image and small previews.
class PhotoDetailViewController : UIViewController {
    
    let imageView : UIImageView = UIImageView(frame: CGRect())
    let collectionViewContainer : UIView = UIView(frame: CGRect())
//    weak var photoListController : PhotoListViewController?
    weak var delegate : PhotoDetailViewControllerDelegate?
    
    var viewModel : PhotoItemViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            if let oldValue = oldValue, viewModel.id == oldValue.id { return }
            PhotosImageLoadManager.loadImage(viewModel.smallImageUrl, viewModel.largeImageUrl, imageView)
            self.navigationItem.title = viewModel.tagTitle.capitalized
        }
    }
    
    var currentIndexPath : IndexPath?

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if let indexPath = currentIndexPath {
//            photoListController?.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        delegate?.doDissmiss(with: photoListController!.collectionViewHelper.allItems())
    }
    
//    func setupChildPhotosController(_ photoListController: PhotoListViewController) {
//        self.photoListController = photoListController
//
//        self.addChildViewController(photoListController)
//        self.collectionViewContainer.addSubview(photoListController.view)
//
//        photoListController.view.translatesAutoresizingMaskIntoConstraints = false
//        photoListController.view.topAnchor.constraint(equalTo: self.collectionViewContainer.topAnchor).isActive = true
//        photoListController.view.bottomAnchor.constraint(equalTo: self.collectionViewContainer.bottomAnchor).isActive = true
//        photoListController.view.leadingAnchor.constraint(equalTo: self.collectionViewContainer.leadingAnchor).isActive = true
//        photoListController.view.trailingAnchor.constraint(equalTo: self.collectionViewContainer.trailingAnchor).isActive = true
//
//        photoListController.didMove(toParentViewController: self)
//
//    }
    
}
