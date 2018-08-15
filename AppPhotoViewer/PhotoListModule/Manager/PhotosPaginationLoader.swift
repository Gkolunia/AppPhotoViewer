//
//  PhotosPaginationLoader.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

protocol PhotosListShowing : class {
    func photosLoaded(_ array: [PhotoItemModel])
}

class PhotosPaginationLoader : PhotosLoader {
    
    weak var delegate : PhotosListShowing?
    let photoRequestManager : PhotosRequestManagerProtocol
    
    var currentPage : Int = 1
    var isLoading : Bool = false
    
    var dataSource = [PhotoItemModel]()
    
    init(_ requestManager: PhotosRequestManagerProtocol) {
        photoRequestManager = requestManager
    }
    
    func initialLoadPhotos() {
        photoRequestManager.getLatestPhotos(currentPage, 100) { (success, response, error) in
            if let response = response {
                self.delegate?.photosLoaded(response.results)
                self.dataSource.append(contentsOf: response.results)
            }
        }
    }
    
    func loadMore() {
        if !isLoading {
            isLoading = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            photoRequestManager.getLatestPhotos(currentPage+1, 30) { (success, response, error) in
                if let response = response {
                    self.delegate?.photosLoaded(response.results)
                    self.dataSource.append(contentsOf: response.results)
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.isLoading = false
                self.currentPage = self.currentPage+1
            }
        }
    }
    
}
