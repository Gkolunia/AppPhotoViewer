//
//  PhotosRequestManager.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation
import UIKit

protocol PhotosListShowing : class {
    func photosLoaded(_ array: [PhotoItemModel])
}


class PhotosRequestManager : APIRequestManager {
    
    weak var delegate : PhotosListShowing?
    
    var currentPage : Int = 1
    var isLoading : Bool = false
    
    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping CompletionHandler<PhotosContainer>) {
        makeAndDoRequest("/search/photos", ["page" : String(pageNumber), "per_page" : String(countPerPage), "query" : "car"], .get, handler: handler)
    }
    
}

extension PhotosRequestManager : PhotosLoader {    
    
    func initialLoadPhotos() {
        getLatestPhotos(currentPage, 100) { (success, array, error) in
            if let array = array {
                self.delegate?.photosLoaded(array.results)
            }
        }
    }
    
    func loadMore() {
        if !isLoading {
            isLoading = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            getLatestPhotos(currentPage+1, 30) { (success, array, error) in
                if let array = array {
                    self.delegate?.photosLoaded(array.results)
                }
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.isLoading = false
                self.currentPage = self.currentPage+1
            }
        }
    }
    
}
