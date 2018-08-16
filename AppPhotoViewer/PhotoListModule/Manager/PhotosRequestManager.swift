//
//  PhotosRequestManager.swift
//  AppPhotoViewer
//
//  Created by Hrybeniuk Mykola on 8/12/18.
//  Copyright © 2018 Hrybenuik Mykola. All rights reserved.
//

import Foundation

/// Abstraction for getting photos
protocol PhotosRequestManagerProtocol {
    
    /// Get latest photos
    ///
    /// - Parameters:
    ///   - pageNumber: getting page. There is simple pagination.
    ///   - countPerPage: Amount of photos per page
    ///   - handler: handler of response with parsed object or error.
    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping CompletionHandler<PhotosContainer>)
}

class PhotosRequestManager : APIRequestManager, PhotosRequestManagerProtocol {
    
    /// In the cases some parameters of request are hardcoded for testing purposes
    func getLatestPhotos(_ pageNumber: Int, _ countPerPage: Int, handler: @escaping CompletionHandler<PhotosContainer>) {
        makeAndDoRequest("/search/photos", ["page" : String(pageNumber), "per_page" : String(countPerPage), "query" : "car"], .get, handler: handler)
    }
    
}
