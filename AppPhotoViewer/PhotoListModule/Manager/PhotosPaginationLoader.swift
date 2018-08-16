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
    func photosLoaded(_ newElements: [PhotoItemModel])
}

class PhotosPaginationLoader : PhotosLoader {
    
    weak var delegate : PhotosListShowing?
    let photoRequestManager : PhotosRequestManagerProtocol
    
    private(set) var currentPage : Int = 1
    private(set) var isLoading : Bool = false
    
    init(_ requestManager: PhotosRequestManagerProtocol) {
        photoRequestManager = requestManager
    }
    
    func initialLoadPhotos() {
        photoRequestManager.getLatestPhotos(currentPage, 100) {[weak self] (success, response, error) in
            if let response = response {
                self?.delegate?.photosLoaded(response.results)
            }
        }
    }
    
    func loadMore() {
        if !isLoading {
            isLoading = true
            photoRequestManager.getLatestPhotos(currentPage+1, 30) {[weak self] (success, response, error) in
                guard let `self` = self else {
                    return
                }

                if let response = response {
                    self.delegate?.photosLoaded(response.results)
                }
                self.isLoading = false
                self.currentPage = self.currentPage+1
            }
        }
    }
    
}
