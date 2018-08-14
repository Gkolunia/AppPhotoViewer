//
//  PhotoListCoordinator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class PhotoListCoordinator : CoordinatorProtocol {
    
    weak var rootNavigationController : UINavigationController?
    private var loader : PhotosPaginationLoader = PhotosPaginationLoader(PhotosRequestManager(with: URLRequestBuilder(with: UnsplashServiceConstants())))
    private var mainPhotosListHelper = VerticalCollectionViewHelper()
    private weak var detailPhotoListHelper : HorizontalCollectionViewHelper?
    
    func start(from navigationController: UINavigationController) {
        
        rootNavigationController = navigationController
        loader.delegate = mainPhotosListHelper
        mainPhotosListHelper.didSelectHandler = {[weak self] item in
            self?.doSelecting(item)
        }
    
        let layout = VerticalCollectionViewLayout()
        layout.delegate = mainPhotosListHelper
        
        let configurator = CollectionViewConfigurator<PhotoItemCollectionViewCell>(with: layout, mainPhotosListHelper)
        
        let controller = PhotoListViewController(configurator, loader)
        mainPhotosListHelper.delegate = controller
        
        navigationController.show(controller, sender: nil)
        
        loader.initialLoadPhotos()
        
    }
}

extension PhotoListCoordinator {
    
    func doSelecting(_ item: PhotoItemViewModel) {
        let detailPhotoController  = PhotoDetailViewController(nibName: nil, bundle: nil)
        detailPhotoController.delegate = self
        
        let layout = HorizontalCollectionViewLayout()
        let collectionViewHelper = HorizontalCollectionViewHelper()
        collectionViewHelper.dataSource = mainPhotosListHelper.dataSource
        collectionViewHelper.didScrollToItem = { item in
            detailPhotoController.viewModel = item
            detailPhotoController.currentIndexPath = collectionViewHelper.indexPath(for: item)
        }

        let configurator = CollectionViewConfigurator<SmallPhotoItemCollectionViewCell>(with: layout, collectionViewHelper)
        
        loader.delegate = collectionViewHelper
        
        let photoListController = PhotoListViewController(configurator, loader)
        collectionViewHelper.delegate = photoListController
        detailPhotoController.setupChildPhotosController(photoListController)
        detailPhotoController.viewModel = item
        detailPhotoController.currentIndexPath = collectionViewHelper.indexPath(for: item)
        
        rootNavigationController?.show(detailPhotoController, sender: nil)
        
        detailPhotoListHelper = collectionViewHelper
    }
    
}

extension PhotoListCoordinator : PhotoDetailViewControllerDelegate {
    
    func doDissmiss(with detailViewcontroller: PhotoDetailViewController) {
        loader.delegate = mainPhotosListHelper
        if let updatedDataSource = detailPhotoListHelper?.dataSource {
            mainPhotosListHelper.dataSource = updatedDataSource
            if let indexPath = detailViewcontroller.currentIndexPath {
                mainPhotosListHelper.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
            }
        }
    }
    
}
