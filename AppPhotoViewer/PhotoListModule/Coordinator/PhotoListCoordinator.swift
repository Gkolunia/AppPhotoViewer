//
//  PhotoListCoordinator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

/// Coordinator incapsulates logic of navigation beetwen controllers.
/// Also creates all needed objects for the Controllers, but the logic would be better to move in some factories.
class PhotoListCoordinator : CoordinatorProtocol {
    
    var rootNavigationController : UINavigationController?
    // Loader of images. It is shared instance among controllers in the coordinator.
    private let presenter : PhotosListPresenter
    
    init() {
        let urlRequestBuilder = URLRequestBuilder()
        let loader = PhotosPaginationLoader(PhotosRequestManager(with: urlRequestBuilder))
        presenter = PhotosListPresenter(loader)
    }
    
    func start(from navigationController: UINavigationController) {
        rootNavigationController = navigationController
        
        presenter.input = self
        
        let photosListViewController = VerticalPhotosViewController(presenter, presenter, VerticalCollectionViewLayout())
        navigationController.show(photosListViewController, sender: nil)

    }
    
}

extension PhotoListCoordinator: CoordinatorInput {
    
    func doSelect(with item: PhotoItemViewModel) {
        
        let photosListViewController = HorizontalPhotosViewController(presenter, presenter, HorizontalCollectionViewLayout())
        
        let detailsController = PhotoDetailViewController(nibName: nil, bundle: nil)
        detailsController.viewModel = item
        detailsController.setupChildPhotosController(photosListViewController)
        
        rootNavigationController?.show(detailsController, sender: nil)
        
    }
    
}
