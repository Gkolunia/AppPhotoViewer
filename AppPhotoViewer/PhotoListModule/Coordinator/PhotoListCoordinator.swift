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
    private var mainPhotosListDataSource = VerticalCollectionViewHelper()
    
    func start(from navigationController: UINavigationController) {
        
        rootNavigationController = navigationController
    
        let layout = VerticalCollectionViewLayout()
        let configurator = CollectionViewConfigurator<PhotoItemCollectionViewCell>(with: layout, mainPhotosListDataSource)
        mainPhotosListDataSource.didSelectHandler = {[weak self] item in
            self?.doSelecting(item)
        }
        
        layout.delegate = mainPhotosListDataSource
        loader.delegate = mainPhotosListDataSource
        
        let controller = PhotoListViewController(configurator, loader)

        mainPhotosListDataSource.delegate = controller
        navigationController.show(controller, sender: nil)
        
        loader.initialLoadPhotos()
        
    }
}

extension PhotoListCoordinator {
    
    func doSelecting(_ item: PhotoItemViewModel) {
        let detailPhotoController  = PhotoDetailViewController(nibName: nil, bundle: nil)
        
        let layout = HorizontalCollectionViewLayout()
        let collectionViewDelegate = HorizontalCollectionViewHelper()
        collectionViewDelegate.dataSource = mainPhotosListDataSource.dataSource
        collectionViewDelegate.didScrollToItem = { item in
            detailPhotoController.viewModel = item
        }

        let configurator = CollectionViewConfigurator<SmallPhotoItemCollectionViewCell>(with: layout, collectionViewDelegate)
        
        loader.delegate = collectionViewDelegate
        
        let photoListController = PhotoListViewController(configurator, loader)
        detailPhotoController.setupChildPhotosController(photoListController)
        detailPhotoController.viewModel = item
        detailPhotoController.currentIndexPath = collectionViewDelegate.indexPath(for: item)
        
        rootNavigationController?.show(detailPhotoController, sender: nil)
    }
    
}
