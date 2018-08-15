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
    private let loader : PhotosPaginationLoader
    
    init() {
        let urlRequestBuilder = URLRequestBuilder()
        loader = PhotosPaginationLoader(PhotosRequestManager(with: urlRequestBuilder))
    }
    
    func start(from navigationController: UINavigationController) {
        
        let mainPhotosListHelper = VerticalCollectionViewHelper()
        rootNavigationController = navigationController
        mainPhotosListHelper.didSelectHandler = {[weak self] item in
            self?.doSelecting(item)
        }
    
        let layout = VerticalCollectionViewLayout()
        layout.delegate = mainPhotosListHelper
        
        let controller = PhotoListViewController(loader, mainPhotosListHelper, layout)
        loader.delegate = controller
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
        collectionViewHelper.didScrollToItem = { item in
            detailPhotoController.viewModel = item
            detailPhotoController.currentIndexPath = collectionViewHelper.indexPath(for: item)
        }

        let photoListController = PhotoListViewController(loader, collectionViewHelper, layout)
        loader.delegate = photoListController
        collectionViewHelper.delegate = photoListController
        detailPhotoController.setupChildPhotosController(photoListController)
        detailPhotoController.viewModel = item
        detailPhotoController.currentIndexPath = collectionViewHelper.indexPath(for: item)
        
        rootNavigationController?.show(detailPhotoController, sender: nil)

    }
    
}

extension PhotoListCoordinator : PhotoDetailViewControllerDelegate {
    
    func doDissmiss(with detailViewcontroller: PhotoDetailViewController) {
//        loader.delegate = mainPhotosListHelper
        
        
//        if let updatedDataSource = detailPhotoListHelper?.dataSource {
//            mainPhotosListHelper.dataSource = updatedDataSource
//            if let indexPath = detailViewcontroller.currentIndexPath {
//                mainPhotosListHelper.collectionView?.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
//            }
//        }
        
        
    }
    
}
