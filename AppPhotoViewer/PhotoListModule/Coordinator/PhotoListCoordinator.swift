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
    
    func start(from navigationController: UINavigationController) {
        
        rootNavigationController = navigationController
        
        let loader = PhotosRequestManager(with: URLRequestBuilder(with: UnsplashServiceConstants()))
        let configurator = CollectionViewConfigurator()
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
        rootNavigationController?.show(detailPhotoController, sender: nil)
    }
    
}
