//
//  PhotosPaginationLoader.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/14/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit


/// The loader incapsulates logic of pagination state. Provides simple interface to get more objects.
class PhotosPaginationLoader: PhotosPaginationListDatasource {
    
    let photoRequestManager : PhotosRequestManagerProtocol
    
    private(set) var currentPage : Int = 1
    private(set) var isLoading : Bool = false
    
    init(_ requestManager: PhotosRequestManagerProtocol) {
        photoRequestManager = requestManager
    }
    
    func initialLoadPhotos(_ handler: @escaping ([PhotoItemModel]?) -> ()) {
        photoRequestManager.getLatestPhotos(currentPage, 100) { (success, response, error) in
            handler(response?.results)
        }
    }
    
    func loadMoreFromCurrentPage(_ handler: @escaping ([PhotoItemModel]?) -> ()) {
        if !isLoading {
            isLoading = true
            photoRequestManager.getLatestPhotos(currentPage+1, 30) {[weak self] (success, response, error) in
                handler(response?.results)
                guard let `self` = self else {
                    return
                }
                self.isLoading = false
                self.currentPage = self.currentPage+1
            }
        }
        else {
            handler(nil)
        }
    }
    
}
