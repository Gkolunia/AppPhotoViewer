//
//  PhotoListCoordinator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class PhotoListCoordinator : CoordinatorProtocol {
    
    var rootNavigationController : UINavigationController?
    private var loader : PhotosRequestManager = PhotosRequestManager(with: URLRequestBuilder(with: UnsplashServiceConstants()))
    
    func start(from navigationController: UINavigationController) {
        
        rootNavigationController = navigationController
    
        let layout = VerticalCollectionViewLayout()
        let configurator = CollectionViewConfigurator<PhotoItemCollectionViewCell>(with: layout)
        
        layout.delegate = configurator
        loader.delegate = configurator
        
        let controller = PhotoListViewController(configurator, loader)
        controller.delegate = self
        
        configurator.delegate = controller
        navigationController.show(controller, sender: nil)
        
    }
}

extension PhotoListCoordinator: PhotoListViewControllerDelegate {
    
    func doSelecting(_ item: PhotoItemViewModel) {
        let detailPhotoController  = PhotoDetailViewController(nibName: nil, bundle: nil)
        detailPhotoController.viewModel = item
        
        let layout = HorizontalCollectionViewLayout()
        let configurator = CollectionViewConfigurator<SmallPhotoItemCollectionViewCell>(with: layout)
        
        loader.delegate = configurator
        
        let photoListController = PhotoListViewController(configurator, loader)
        
        
        detailPhotoController.addChildViewController(photoListController)
        detailPhotoController.collectionViewContainer.addSubview(photoListController.view)
        
        photoListController.view.translatesAutoresizingMaskIntoConstraints = false
        photoListController.view.topAnchor.constraint(equalTo: detailPhotoController.collectionViewContainer.topAnchor).isActive = true
        photoListController.view.bottomAnchor.constraint(equalTo: detailPhotoController.collectionViewContainer.bottomAnchor).isActive = true
        photoListController.view.leadingAnchor.constraint(equalTo: detailPhotoController.collectionViewContainer.leadingAnchor).isActive = true
        photoListController.view.trailingAnchor.constraint(equalTo: detailPhotoController.collectionViewContainer.trailingAnchor).isActive = true
        
        photoListController.didMove(toParentViewController: detailPhotoController)
        
        rootNavigationController?.show(detailPhotoController, sender: nil)
    }
    
}
