//
//  PhotoListCoordinator.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import UIKit

class PhotoListCoordinator : CoordinatorProtocol {
    
    func start(from navigationController: UINavigationController) {
        
        let controller = PhotoListViewController(CollectionViewConfigurator(), PhotosRequestManager(with: URLRequestBuilder(with: UnsplashServiceConstants())))
        navigationController.show(controller, sender: nil)
        
    }
    
    
}
