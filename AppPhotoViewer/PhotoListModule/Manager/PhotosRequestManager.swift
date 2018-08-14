//
//  PhotosRequestManager.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

protocol PhotosRequestManagerProtocol {
    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping CompletionHandler<PhotosContainer>) 
}

class PhotosRequestManager : APIRequestManager, PhotosRequestManagerProtocol {

    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping CompletionHandler<PhotosContainer>) {
        makeAndDoRequest("/search/photos", ["page" : String(pageNumber), "per_page" : String(countPerPage), "query" : "car"], .get, handler: handler)
    }
    
}
