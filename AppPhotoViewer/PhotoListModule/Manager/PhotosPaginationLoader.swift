//
//  PhotosPaginationLoader.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

/// Abstraction of object which can show and handle new elements.
protocol PhotosListShowing : class {
    
    /// Pass only new items which is loaded for current page
    func photosLoaded(_ newElements: [PhotoItemModel])
}


/// The loader incapsulates logic of pagination state. Provides simple interface to get more objects.
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
