//
//  PhotosRequestManager.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

protocol PhotosListShowing : class {
    func photosLoaded(_ array: [PhotoItemModel])
}


class PhotosRequestManager : APIRequestManager {
    
    weak var delegate : PhotosListShowing?
    
    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping CompletionHandler<PhotosContainer>) {
        makeAndDoRequest("/search/photos", ["page" : String(pageNumber), "per_page" : String(countPerPage), "query" : "car"], .get, handler: handler)
    }
    
}

extension PhotosRequestManager : PhotosLoader {    
    
    func initialLoadPhotos() {
        getLatestPhotos(1, 100) { (success, array, error) in
            if let array = array {
                self.delegate?.photosLoaded(array.results)
            }
        }
    }
    
    func loadMore() {
        getLatestPhotos(1, 10) { (success, array, error) in
            
        }
    }
    
}
