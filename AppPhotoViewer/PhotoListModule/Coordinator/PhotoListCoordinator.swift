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
    private var loader : PhotosPaginationLoader = PhotosPaginationLoader(PhotosRequestManager(with: URLRequestBuilder(with: UnsplashServiceConstants())))
    private var mainPhotosListHelper = VerticalCollectionViewHelper()
    
    func start(from navigationController: UINavigationController) {
        
        rootNavigationController = navigationController
    
        let layout = VerticalCollectionViewLayout()
        let configurator = CollectionViewConfigurator<PhotoItemCollectionViewCell>(with: layout, mainPhotosListHelper)
        mainPhotosListHelper.didSelectHandler = {[weak self] item in
            self?.doSelecting(item)
        }
        
        layout.delegate = mainPhotosListHelper
        loader.delegate = mainPhotosListHelper
        
        let controller = PhotoListViewController(configurator, loader)

        mainPhotosListHelper.delegate = controller
        navigationController.show(controller, sender: nil)
        
        loader.initialLoadPhotos()
        
    }
}

extension PhotoListCoordinator {
    
    func doSelecting(_ item: PhotoItemViewModel) {
        let detailPhotoController  = PhotoDetailViewController(nibName: nil, bundle: nil)
        
        let layout = HorizontalCollectionViewLayout()
        let collectionViewHelper = HorizontalCollectionViewHelper()
        collectionViewHelper.dataSource = mainPhotosListHelper.dataSource
        collectionViewHelper.didScrollToItem = { item in
            detailPhotoController.viewModel = item
        }

        let configurator = CollectionViewConfigurator<SmallPhotoItemCollectionViewCell>(with: layout, collectionViewHelper)
        
        loader.delegate = collectionViewHelper
        
        let photoListController = PhotoListViewController(configurator, loader)
        detailPhotoController.setupChildPhotosController(photoListController)
        detailPhotoController.viewModel = item
        detailPhotoController.currentIndexPath = collectionViewHelper.indexPath(for: item)
        
        rootNavigationController?.show(detailPhotoController, sender: nil)
    }
    
}
