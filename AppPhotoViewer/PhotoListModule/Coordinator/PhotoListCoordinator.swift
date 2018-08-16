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
    private let loader : PhotosPaginationLoader
    // Main list controller to update it's state when we back from detail controller.
    private weak var mainListController : PhotoListViewController?
    
    init() {
        let urlRequestBuilder = URLRequestBuilder()
        loader = PhotosPaginationLoader(PhotosRequestManager(with: urlRequestBuilder))
    }
    
    func start(from navigationController: UINavigationController) {
        rootNavigationController = navigationController
    
        let mainPhotosListHelper = VerticalCollectionViewHelper()
        mainPhotosListHelper.didSelectHandler = {[weak self] indexPath, items in
            self?.doSelecting(indexPath, items)
        }
    
        let layout = VerticalCollectionViewLayout()
        layout.delegate = mainPhotosListHelper
        
        let controller = PhotoListViewController(loader, mainPhotosListHelper, layout)
        
        loader.delegate = controller
        mainPhotosListHelper.delegate = controller
        
        navigationController.show(controller, sender: nil)
        
        loader.initialLoadPhotos()
        
        mainListController = controller
    }
    
    func doSelecting(_ indexPath: IndexPath,_ items: [PhotoItemViewModel]) {
        let detailPhotoController  = PhotoDetailViewController(nibName: nil, bundle: nil)
        detailPhotoController.delegate = self
        detailPhotoController.currentIndexPath = indexPath
        detailPhotoController.viewModel = items[indexPath.row]
        
        let layout = HorizontalCollectionViewLayout()
        let collectionViewHelper = HorizontalCollectionViewHelper(with: items)
        collectionViewHelper.didScrollToItem = { item in
            detailPhotoController.viewModel = item
            detailPhotoController.currentIndexPath = collectionViewHelper.indexPath(for: item)
        }
        
        let photoListController = PhotoListViewController(loader, collectionViewHelper, layout)
        loader.delegate = photoListController
        collectionViewHelper.delegate = photoListController
        
        detailPhotoController.setupChildPhotosController(photoListController)
        
        rootNavigationController?.show(detailPhotoController, sender: nil)
    }
}

extension PhotoListCoordinator : PhotoDetailViewControllerDelegate {
    
    func doDissmiss(with allItems: [PhotoItemViewModel]) {
        // Loader should have previous delegate to send updates about new elements to main list.
        loader.delegate = mainListController
        // Update data source on main screen.
        mainListController?.collectionViewHelper.setNewDataSource(allItems)
    }
    
}
